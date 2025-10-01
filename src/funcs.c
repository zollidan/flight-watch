#include <stdio.h>
#include "fokker_f28_constants.h"

// Примерная формула расчета топлива
double calculate_fuel(const double distance_nm) {
    const double time = distance_nm / F28_MK1000_CRUISE_ECON_SPEED_KIAS; // время в часах
    const double fuel_needed = time * F28_MK1000_CRUISE_ECON_FLOW_KGH; // необходимое топливо в кг

    return fuel_needed;
}