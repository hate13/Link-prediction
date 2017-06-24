/* convert.c

   Help to convert log to json

   Usage: convert in out(redirect IO)

   Example:

       graph_tool < a.log > a.json
*/
#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <cstring>
using namespace std;
#define MAX_ROWS 1000
#define DATA_NUM 4
#define ALGO_NUM 4

int main(int argc, char *argv[])
{
    int rows;
    double data[ALGO_NUM][DATA_NUM][MAX_ROWS]; // each algorithm, each data, each row
    double xaxis[MAX_ROWS];

    if (argc > 1 && (strcmp(argv[1], "-h") == 0 || strcmp(argv[1], "--help") == 0)) {
        printf("Usage: convert in out(redirect IO)\n");
        exit(1);
    }

    scanf("%d", &rows); // each data rows
    for (int i = 0; i < rows; i++) {
        scanf("%lf", &xaxis[i]);
    }
    for (int i = 0; i < DATA_NUM; i++) {
        for (int j = 0; j < rows; j++) {
            for (int k = 0; k < ALGO_NUM; k++) {
                double x;
                scanf("%lf", &x);
                data[k][i][j] = x * 100;
            }
        }
    }

    for (int i = 0; i < ALGO_NUM; i++) { // each algorithm
        puts("[");
        for (int j = 0; j < DATA_NUM; j++) { // each data
            puts("    [");
            for (int k = 0; k < rows; k++) { // each rows
                printf("        [%g, %.4f],\n", xaxis[k], data[i][j][k]);
            }
            puts("    ],");
        }
        puts("],");
    }

    return 0;
}

