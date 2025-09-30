#include <stdio.h>
#include "fokker_f28_constants.h"

// Примерная формула расчета топлива
double calculate_fuel(double speed_knots, double distance_nm) {
    double time = distance_nm / speed_knots; // время в часах
    double fuel_needed = time * F28_MK1000_CRUISE_ECON_FLOW_KGH; // необходимое топливо в кг

    return fuel_needed;
}

int main() {
    printf("Система расчета топлива для Fokker F28\n");

    printf("Введите среднюю скорость полета (узлы): ");
    double speed_knots;
    scanf("%lf", &speed_knots);

    printf("Введите дальность полета (морские мили): ");
    double distance_nm;
    scanf("%lf", &distance_nm);

    double fuel_needed = calculate_fuel(speed_knots, distance_nm);

    printf("Необходимое топливо: %.2f кг\n", fuel_needed);

    return 0;
}