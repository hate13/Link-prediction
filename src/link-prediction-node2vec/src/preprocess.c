/* preprocess.c

   Help to divide edges into two parts, training set and testing set

   Usage: preprocess file_in file_nodes_out file_edges_training_out file_edges_testing_out

       file_in: input graph file
       file_training_out: write training set
       file_testing_out: write testing set

   Example:

       preprocess a.edges a.nodes training.edges testing.edges
*/
#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <ctime>
#include <cerrno>
#include <algorithm>
using namespace std;
#define MAX_NODE 500000

int nodes;
int node[MAX_NODE];
int node_vis[MAX_NODE];

int node_exist(int node);
void node_put(int node);

int main(int argc, char *argv[])
{
	if (argc != 5 || strcmp(argv[1], "--help") == 0) {
		printf("Usage: preprocess file_in file_nodes_out file_edges_training_out file_edges_testing_out\n");
		exit(1);
	}

	srand((int)time(0));

	FILE *fp1, *fp2, *fp3, *fp4;

	if ((fp1 = fopen(argv[1], "r")) == NULL) {
		perror(argv[1]);
		exit(1);
	}

	if ((fp2 = fopen(argv[2], "w+")) == NULL) {
		perror(argv[2]);
		exit(1);
	}

	if ((fp3 = fopen(argv[3], "w+")) == NULL) {
		perror(argv[3]);
		exit(1);
	}

	if ((fp4 = fopen(argv[4], "w+")) == NULL) {
		perror(argv[4]);
		exit(1);
	}

	int start, end;
	int LINE = 0;

	while (fscanf(fp1, "%d%d", &start, &end) != EOF) {

            LINE++;
            if (start > MAX_NODE || end > MAX_NODE) {
                fprintf(stderr, "node number is too large(max: %d), line: %d\n", MAX_NODE, LINE);
                exit(1);
            }

	    if (!node_exist(start)) {
                node_put(start);
                node[nodes++] = start;
            }

	    if (!node_exist(end)) {
                node_put(end);
                node[nodes++] = end;
	    }

	    int rd = rand() % 2;
	    if (rd > 0) {
		fprintf(fp3, "%d %d\n", start, end);
	    } else {
		fprintf(fp4, "%d %d\n", start, end);
	    }
        }

	sort(node, node + nodes);
	for (int i = 0; i < nodes; i++) {
            fprintf(fp2, "%d\n", node[i]);
	}

        fclose(fp1);
	fclose(fp2);
	fclose(fp3);
	fclose(fp4);

	return 0;
}

int node_exist(int node)
{
    return node_vis[node] > 0;
}

void node_put(int node)
{
    node_vis[node] = 1;
}

