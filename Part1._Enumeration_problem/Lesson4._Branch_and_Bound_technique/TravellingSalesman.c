#include <stdio.h>
#include <stdbool.h>

#define InputFile "TOURISM.INP"
#define OutputFile "TOURISM.OUT"
#define max 20

int C[max + 1][max + 1], Free[max + 1];
int X[max + 2], T[max + 2];
int *BestWay;
int m, n, MinSpending;
FILE *fi, *fo;

void Enter()
{
    fi = fopen("TOURISM.INP", "r");
    if (fi != NULL)
    {
        fscanf(fi, "%d %d\n", &n, &m);
        for (int i = 1; i <= n; i++)
        {
            for (int j = 1; j <= n; j++)
            {
                if (i == j)
                {
                    C[i][j] = 0;
                }
                else
                {
                    C[i][j] = __INT_MAX__;
                }
            }
        }
        int i, j;
        for (int k = 1; k <= m; k++)
        {
            fscanf(fi, "%d %d %d\n", &i, &j, &C[i][j]);
            C[j][i] = C[i][j];
        }
        fclose(fi);
    }
}

void Init()
{
    for (int i = 0; i <= max; i++)
    {
        Free[i] = true;
    }
    Free[1] = false;
    X[1] = 1;
    T[1] = 0;
    MinSpending = __INT_MAX__;
}

void Try(int i)
{
    for (int j = 2; j <= n; j++)
    {
        if (Free[j])
        {
            X[i] = j;
            T[i] = T[i - 1] + C[X[i - 1]][j];
            if (T[i] < MinSpending)
            {
                if (i < n)
                {
                    Free[j] = false;
                    Try(i + 1);
                    Free[j] = true;
                }
                else if ((T[n] + C[X[n]][1]) < MinSpending)
                {
                    BestWay = X;
                    MinSpending = T[n] + C[X[n]][1];
                }
            }
        }
    }
}

void PrintResult()
{
    fo = fopen("TOURISM.OUT", "w");
    if (MinSpending == __INT_MAX__)
    {
        fprintf(fo, "NO SOLUTION\n");
    }
    else
    {
        for (int i = 1; i <= n; i++)
        {
            fprintf(fo, "%d->", BestWay[i]);
        }
        fprintf(fo, "1\n");
        fprintf(fo, "Cost: %d\n", MinSpending);
    }
    fclose(fo);
}

int main()
{
    Enter();
    Init();
    Try(2);
    PrintResult();
    return 0;
}