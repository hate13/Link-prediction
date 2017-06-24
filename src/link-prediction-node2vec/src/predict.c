/* predict.c

   Do predict job.

   Usage: predict nodes_in origin_edges_in testing_edges_in vectors_in

       file_in: input graph file
       file_training_out: write training data set
       file_testing_out: write testing data set

   Example:

       predict a.nodes a.origin_edges a.testing.edges a.vectors
*/
#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <algorithm>
#include <cmath>
#include <cerrno>
#include <ctime>
using namespace std;
#define max(a, b) ((a) > (b) ? (a) : (b))
#define min(a, b) ((a) < (b) ? (a) : (b))
#define EPS 1e-4
#define TEST_NUM 10000
#define MAX_NODES 200000
#define MAX_EDGES 5000000
#define MAX_DIM 810

typedef struct {
    int start, end;
} edge;

/* node */
int nodes_num;
int nodes[MAX_NODES];

/* edge */
int edges_test_num;
int edges_origin_num;
edge edges_test[MAX_EDGES];
edge edges_origin[MAX_EDGES];

/* vector */
int dimensions;
double vectors[MAX_NODES][MAX_DIM];

void read_nodes(char *, int*, int*);
void read_edges(char *, edge *, int *);
void read_vectors(char*, double [][MAX_DIM], int, int*);
void predict(int*, int, edge*, int, edge*, int, double [][MAX_DIM], int);
double cal_euclidean_dis(double [][MAX_DIM], int, int, int);
double cal_manhattan_dis(double [][MAX_DIM], int, int, int);
double cal_camberra_dis(double [][MAX_DIM], int, int, int);
double cal_cos(double [][MAX_DIM], int, int, int);
double cal_r(double [][MAX_DIM], int, int, int);
void cal_auc(double, double, double*, int*);
int edge_exist(edge*, int, int, int);
int eq(double, double);

int main(int argc, char **argv)
{
    if (argc != 5 || strcmp(argv[1], "--help") == 0) {
        fprintf(stderr, "Usage: predict nodes_in origin_edges_in testing_edges_in vectors_in\n");
        exit(1);
    }

    read_nodes(argv[1], nodes, &nodes_num);
    read_edges(argv[2], edges_origin, &edges_origin_num);
    read_edges(argv[3], edges_test, &edges_test_num);
    read_vectors(argv[4], vectors, nodes_num, &dimensions);
    predict(nodes, nodes_num, edges_origin, edges_origin_num, edges_test, edges_test_num, vectors, dimensions);

    return 0;
}

// Read nodes from path
void read_nodes(char *path, int *nodes, int *nodes_num)
{
    FILE *fp;
    int number;

    if ((fp = fopen(path, "r")) == NULL) {
        perror(path);
        exit(1);
    }

    (*nodes_num) = 0;
    while (fscanf(fp, "%d", &number) != EOF) {
        nodes[(*nodes_num)++] = number;
        if (*nodes_num > MAX_NODES) {
            fprintf(stderr, "the number of the nodes is too much(max: %d\n)", MAX_NODES);
            exit(1);
        }
    }

    fclose(fp);
}

// Read edges from path
void read_edges(char *path, edge *edges, int *edges_num)
{
    FILE *fp;
    int start, end;

    if ((fp = fopen(path, "r")) == NULL) {
        perror(path);
        exit(1);
    }

    (*edges_num) = 0;
    while (fscanf(fp, "%d%d", &start, &end) != EOF) {
        edges[(*edges_num)].start = min(start, end);
        edges[(*edges_num)].end = max(start, end);
        (*edges_num)++;
        if (*edges_num > MAX_EDGES) {
            fprintf(stderr, "the number of the edges is too much(max: %d\n)", MAX_EDGES);
            exit(1);
        }
    }

    fclose(fp);
}

// Read vector from path
void read_vectors(char *path, double vectors[][MAX_DIM], int node_num, int *dimensions)
{
    FILE *fp;
    int tmp;
    int idx;

    if ((fp = fopen(path, "r")) == NULL) {
        perror(path);
        exit(1);
    }

    fscanf(fp, "%d%d", &tmp, dimensions);
    if (tmp != node_num) {
        fprintf(stderr, "node number is not equals between edges and vectors(%d != %d)", node_num, tmp);
        exit(1);
    }

    for (int i = 0; i < node_num; i++) {
        fscanf(fp, "%d", &idx);
        for (int j = 0; j < *dimensions; j++) {
            fscanf(fp, "%lf", &vectors[idx][j]);
        }
    }

    fclose(fp);
}

// Do predict job and cal AUC
void predict(int* nodes, int nodes_num,
             edge *edges_origin, int edges_origin_num,
             edge *edges_test, int edges_test_num,
             double vectors[][MAX_DIM], int dimensions)
{
    srand((int)time(0));

    int idx;
    int rstart, rend;
    double x[4], y[4];
    double total[4] = {0.0};
    int equals[4] = {0};

    for (int k = 0; k < TEST_NUM; k++) {
        idx = rand() % edges_test_num; // rand in testing data
        while (true) { // rand in complementary graph
            rstart = nodes[rand() % nodes_num];
            rend = nodes[rand() % nodes_num];
            if (rstart == rend) continue;
            if (edge_exist(edges_origin, edges_origin_num, rstart, rend) <= 0) {
                break;
            }
        }

        // printf("%d->%d vs %d->%d\n", edges_test[idx].start, edges_test[idx].end, rstart, rend);

        x[0] = cal_euclidean_dis(vectors, dimensions, edges_test[idx].start, edges_test[idx].end);
        y[0] = cal_euclidean_dis(vectors, dimensions, rstart, rend);
        x[1] = cal_camberra_dis(vectors, dimensions, edges_test[idx].start, edges_test[idx].end);
        y[1] = cal_camberra_dis(vectors, dimensions, rstart, rend);
        x[2] = cal_cos(vectors, dimensions, edges_test[idx].start, edges_test[idx].end);
        y[2] = cal_cos(vectors, dimensions, rstart, rend);
        x[3] = cal_r(vectors, dimensions, edges_test[idx].start, edges_test[idx].end);
        y[3] = cal_r(vectors, dimensions, rstart, rend);

        for (int i = 0; i < 4; i++) {
            cal_auc(x[i], y[i], &total[i], &equals[i]);
        }
    }

    printf("accuracy: %lf %lf %lf %lf\n", total[0] / TEST_NUM, total[1] / TEST_NUM, total[2] / TEST_NUM, total[3] / TEST_NUM);
    // printf("equals: %d %d %d %d\n", equals[0], equals[1], equals[2], equals[3]);
}

// Checking the edge exists or not
int edge_exist(edge *edges, int edges_num, int start, int end)
{
    if (start > end) {
        int tmp = start;
        start = end;
        end = tmp;
    }
    // FIXME, using binary_search instead.
    for (int i = 0; i < edges_num; i++) {
        if (edges[i].start == start && edges[i].end == end) {
            return 1;
        }
    }
    return 0;
}

// Euclidean distances between two vectors
double cal_euclidean_dis(double vectors[][MAX_DIM], int dimensions, int i, int j)
{
    double sum = 0.0;
    for (int k = 0; k < dimensions; k++) {
        sum += (vectors[i][k] - vectors[j][k]) * (vectors[i][k] - vectors[j][k]);
    }
    return -sqrt(sum);
}

// Manhattan distances between two vectors
double cal_manhattan_dis(double vectors[][MAX_DIM], int dimension, int i, int j)
{
    double sum = 0.0;
    for (int k = 0; k < dimensions; k++) {
        sum += fabs(vectors[i][k] - vectors[j][k]);
    }
    return -sum;
}

// Camberra distance between two vectors
double cal_camberra_dis(double vectors[][MAX_DIM], int dimension, int i, int j)
{
    double sum = 0.0;
    for (int k = 0; k < dimensions; k++) {
        sum += fabs(vectors[i][k] - vectors[j][k]) / fabs(vectors[i][k] + vectors[j][k]);
    }
    return -sum;
}

// Cosine between two vectors
double cal_cos(double vectors[][MAX_DIM], int dimensions, int i, int j)
{
    double a = 0.0, b = 0.0, c = 0.0;
    for (int k = 0; k < dimensions; k++) {
        a += vectors[i][k] * vectors[j][k];
        b += vectors[i][k] * vectors[i][k];
        c += vectors[j][k] * vectors[j][k];
    }
    if (b == 0.0 || c == 0.0) return 0.0;
    return a / (sqrt(b) * sqrt(c));
}

// Correlation Coefficient Method
double cal_r(double vectors[][MAX_DIM], int dimensions, int i, int j)
{
    double avg_i = 0.0, avg_j = 0.0;
    for (int k = 0; k < dimensions; k++) {
        avg_i += vectors[i][k];
        avg_j += vectors[j][k];
    }
    avg_i = avg_i / dimensions;
    avg_j = avg_j / dimensions;

    double a = 0.0, b = 0.0, c = 0.0;
    for (int k = 0; k < dimensions; k++) {
        a += (vectors[i][k] - avg_i) * (vectors[j][k] - avg_j);
        b += (vectors[i][k] - avg_i) * (vectors[i][k] - avg_i);
        c += (vectors[j][k] - avg_j) * (vectors[j][k] - avg_j);
    }
    return a / (sqrt(b) * sqrt(c));
}

void cal_auc(double x, double y, double *total, int *equals)
{
    if (x > y) *total += 1.0;
    else if(eq(x, y)) *total += 0.5, (*equals)++;
}

int eq(double a, double b)
{
    if (fabs(a - b) <= EPS) return 1;
    return 0;
}
