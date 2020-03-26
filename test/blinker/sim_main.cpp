#include <iostream>
#include <verilated.h>

#include "Vblinker.h"

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    Vblinker* top = new Vblinker;

    vluint64_t main_time = 0;
    vluint64_t cycle = 0;

    bool led = false;

    top->rst = 1;
    top->clk = 0;

    while (!Verilated::gotFinish() && cycle < 1000000000 /*10 seconds*/) { 
        if (main_time > 10) {
            top->rst = 0;
        }

        top->clk = !top->clk;

        top->eval(); 

        if (led != top->led) {
            if (led)
                std::cout << "ON  @ " << std::dec << cycle << std::endl;
            else 
                std::cout << "OFF @ " << std::dec << cycle << std::endl;
        }

        led = top->led;
        ++main_time;
        cycle = main_time / 2;
    }
    delete top;
    exit(0);
}
