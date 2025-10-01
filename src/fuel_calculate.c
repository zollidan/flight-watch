#include <stdio.h>
#include "fokker_f28_constants.h"

// Примерная формула расчета топлива
double calculate_fuel_F28_MK1000(const double distance_nm) {

    if (distance_nm > F28_MK4000_MAX_RANGE_NM)
    {
        printf("Expected distance is more than maximum.\n");
        return -1;
    }

    const double time_hours = distance_nm / F28_MK1000_CRUISE_ECON_SPEED_KIAS;
    const double fuel_needed_kg = time_hours * F28_MK1000_CRUISE_ECON_FLOW_KGH;

    if (fuel_needed_kg > F28_MK1000_FUEL_CAPACITY_KG) 
    {
        printf("Expected fuel is more than capacity.\n");
        return -1;
    }

    return fuel_needed_kg;
}

// Примерная формула расчета топлива
double calculate_fuel_F28_MK4000(const double distance_nm) {

    if (distance_nm > F28_MK4000_MAX_RANGE_NM)
    {
        printf("Expected distance is more than maximum.\n");
        return -1;
    }

    const double time_hours = distance_nm / F28_MK4000_CRUISE_FLOW_KGH;
    const double fuel_needed_kg = time_hours * F28_MK4000_CRUISE_FLOW_KGH;

    if (fuel_needed_kg > F28_MK4000_FUEL_CAPACITY_KG) 
    {
        printf("Expected fuel is more than capacity.\n");
        return -1;
    }

    return fuel_needed_kg;
}
