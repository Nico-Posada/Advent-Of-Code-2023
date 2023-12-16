#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

typedef struct {
    int x, y, dir;
} Ray;

int get_file_len(FILE* fp)
{
    fseek(fp, 0, SEEK_END);
    int size = ftell(fp);
    fseek(fp, 0, SEEK_SET);
    return size;
}

int get_row_count(char* data)
{
    int total = 0;
    for (int i = 0; data[i]; ++i)
        if (data[i] == '\n')
            total++;

    return total + 1; // +1 to account for the last row
}

int get_col_count(char* data)
{
    int total = 0;
    for (; data[total] && data[total] != '\n'; ++total);
    return total;
}

int get_energized_count(char** grid, bool* energized, int rows, int cols, int start_x, int start_y, int start_dir) {
    memset(energized, 0, USHRT_MAX);

    int size = 1, count = 0;
    Ray* rays = (Ray*)calloc(size, sizeof(Ray));
    rays->x = start_x;
    rays->y = start_y;
    rays->dir = start_dir;

    while (size > 0) {
        int new_size = 0;
        Ray* new_rays = (Ray*)calloc(size * 2, sizeof(Ray));

        for (int i = 0; i < size; ++i) {
            Ray* cur = &rays[i];
            int x = cur->x, y = cur->y, dir = cur->dir;
            if (x<0 || x>=cols || y<0 || y>=rows)
                continue;

            unsigned short pos = x | y << 7;
            unsigned short packed = dir | pos << 2;
            if (energized[packed])
                continue;

            int* casted = (int*)energized;
            if (casted[pos] == 0)
                count++;
            
            energized[packed] = true;
            char c = grid[y][x];

            if (c == '/') {
                dir = 3 - dir;
            }
            else if (c == '\\') {
                dir ^= 1;
            }
            else if (c == '-') {
                if (dir == 1 || dir == 3) {
                    Ray* ray1 = &new_rays[new_size], * ray2 = &new_rays[new_size+1];
                    ray1->x = x+1;
                    ray1->y = y;
                    ray1->dir = 0;

                    ray2->x = x-1;
                    ray2->y = y;
                    ray2->dir = 2;
                    new_size += 2;
                    continue;
                }
            }
            else if (c == '|') {
                if (dir == 0 || dir == 2) {                    
                    Ray* ray1 = &new_rays[new_size], * ray2 = &new_rays[new_size+1];
                    ray1->x = x;
                    ray1->y = y+1;
                    ray1->dir = 1;

                    ray2->x = x;
                    ray2->y = y-1;
                    ray2->dir = 3;
                    new_size += 2;
                    continue;
                }
            }

            if (dir == 0)
                x++;
            else if (dir == 1)
                y++;
            else if (dir == 2)
                x--;
            else
                y--;       

            Ray* new_ray = &new_rays[new_size];
            new_ray->x = x;
            new_ray->y = y;
            new_ray->dir = dir;
            new_size++;
        }

        free(rays);
        rays = new_rays;
        size = new_size;
    }

    free(rays);
    return count;
}

int main(int argc, char** argv)
{
    if (argc != 2) {
        printf("Usage: part2.exe <filename>\n");
        return 1;
    }

    char *filename = argv[1];
    FILE *fp = fopen(filename, "rb");

    if (fp == NULL) {
        printf("Error: could not open file %s", filename);
        return 1;
    }

    int len = get_file_len(fp);
    char* grid_str = (char*)malloc(len);

    fread(grid_str, sizeof(char), len, fp);
    fclose(fp);

    int rows = get_row_count(grid_str), cols = get_col_count(grid_str);
    char** grid = (char**)calloc(rows, sizeof(char*));

    // packed energy bits (MSB):
    // y       x       dir
    // 0000000 0000000 00
    bool* energized = (bool*)calloc(USHRT_MAX, sizeof(bool));

    // init grid
    char* tok = strtok(grid_str, "\n");
    int idx = 0;
    while (tok) {
        grid[idx++] = tok;
        tok = strtok(NULL, "\n");
    }

    int total = get_energized_count(grid, energized, rows, cols, 0, 0, 0);
    printf("part 1: %d\n", total);
    
    int max = 0;
    // top and bottom
    for (int i = 0; i < cols; ++i) {
        int top = get_energized_count(grid, energized, rows, cols, i, 0, 1);
        int bottom = get_energized_count(grid, energized, rows, cols, i, rows - 1, 3);

        if (top > max) max = top;       
        if (bottom > max) max = bottom;
    }

    // left and right
    for (int i = 0; i < rows; ++i) {
        int left = get_energized_count(grid, energized, rows, cols, 0, i, 0);
        int right = get_energized_count(grid, energized, rows, cols, cols - 1, i, 2);

        if (left > max) max = left;
        if (right > max) max = right;
    }

    printf("part 2: %d\n", max);
    return 0;
}
