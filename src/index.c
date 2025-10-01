#include <stdio.h>
#include "fokker_f28_constants.h"
#include "funcs.h"

int main() {
    printf("Fuel Calculator for Fokker F28\n");

    printf("Enter flight distance (nautical miles): ");
    double distance_nm;
    scanf("%lf", &distance_nm);

    double fuel_needed = calculate_fuel(distance_nm);

    printf("Fuel needed: %.2f kg\n", fuel_needed);

    return 0;
}