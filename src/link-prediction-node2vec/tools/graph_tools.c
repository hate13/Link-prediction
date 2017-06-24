/* graph_tool.c

   Help to cal actual nodes, edges, degree, density on undirected graph

   Usage: graph_tool file_in file_nodes_out file_edges_out

       file_in: input graph file
       file_node_out: write graph nodes list
       file_edge_out: write graph edges

   Example:

       graph_tool a.edges a.nodes a.edges
*/
#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <map>
#include <algorithm>
using namespace std;
#define LL long long
#define MAX_NODE 500000
#define MAX_EDGES 5000000

typedef struct {
    int u, v;
} Edge;

int nodes;
int edges;
int degrees;
int degree[MAX_NODE];
int node[MAX_NODE];
Edge edge[MAX_EDGES];
bool node_vis[MAX_NODE];
map<LL, bool> edge_vis;

bool node_exist(int node);
bool edge_exist(int start, int end);
void node_put(int node);
void edge_put(int start, int end);
void swap(int *a, int *b);

int main(int argc, char *argv[])
{
    int LINE;
    FILE *fp_in;
    FILE *fp_node_out;
    FILE *fp_edge_out;
    int start, end;

    if (argc != 4 || strcmp(argv[1], "--help") == 0) {
        fprintf(stderr, "Usage: graph_tool file_in file_nodes_out file_edges_out\n");
        exit(1);
    }

    if ((fp_in = fopen(argv[1], "r")) == NULL) {
        perror(argv[1]);
        exit(1);
    }

    LINE = 0;
    while (fscanf(fp_in, "%d%d", &start, &end) != EOF) {
        LINE++;
        if (start > MAX_NODE || end > MAX_NODE) {
            fprintf(stderr, "node number is too large(max: %d), line: %d\n", MAX_NODE, LINE);
            exit(1);
        }

        // make start <= end
        if (start > end) {
            swap(&start, &end);
        }

        // new edge
        if (!edge_exist(start, end)) {
            // new start-node
            if (!node_exist(start)) {
                node[nodes++] = start;
                node_put(start);
            }

            // new end-node
            if (!node_exist(end)) {
                node[nodes++] = end;
                node_put(end);
            }

            degrees += 2;
            degree[start]++;
            degree[end]++;

            edge[edges].u = start;
            edge[edges].v = end;
            edge_put(start, end);

            edges++;
            if (edges > MAX_EDGES) {
                fprintf(stderr, "the number of the edges is too much(max: %d\n)", MAX_EDGES);
                exit(1);
            }
        }
    }

    LL total = (LL)nodes * (nodes - 1) / 2;
    printf("nodes: %d, edges: %d, average degree: %lf, density: %lf\n",
           nodes, edges, degrees * 1.0 / nodes, edges * 1.0 / total);

    // out for node
    if ((fp_node_out = fopen(argv[2], "w+")) == NULL) {
        perror(argv[2]);
        exit(1);
    }

    // make nodes ordered
    sort(node, node + nodes);
    for (int i = 0; i < nodes; i++) {
        fprintf(fp_node_out, "%d\n", node[i]);
    }

    // out for edge
    if ((fp_edge_out = fopen(argv[3], "w+")) == NULL) {
        perror(argv[3]);
        exit(1);
    }
    for (int i = 0; i < edges; i++) {
        fprintf(fp_edge_out, "%d %d\n", edge[i].u, edge[i].v);
    }

    fclose(fp_in);
    fclose(fp_node_out);
    fclose(fp_edge_out);

    return 0;
}

bool node_exist(int node)
{
    return node_vis[node];
}

void node_put(int node)
{
    node_vis[node] = true;
}

// Please make sure start <= end
bool edge_exist(int start, int end)
{
    return edge_vis[(LL)start * MAX_NODE + end];
}

// Please make sure start <= end
void edge_put(int start, int end)
{
    edge_vis[(LL)start * MAX_NODE + end] = true;
}

void swap(int *a, int *b)
{
    int tmp = *a;
    *a = *b;
    *b = tmp;
}
