#include <windows.h>
#include <tchar.h>
#include <stdio.h>
#include "SimConnect.h"

static HANDLE hSimConnect = NULL;

typedef struct {
    double latitude;
    double longitude;
    double altitude;
} AircraftData;


int main(void) {

    HRESULT hr;

    if (SUCCEEDED(SimConnect_Open(&hSimConnect, "SimConnect Example", NULL, 0, 0, 0))) {
        printf("SimConnect opened\n");
    }

    return 0;
}
