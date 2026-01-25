*  AC analysis of CMOS inverter
.lib "/home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice" ss
.temp 125

Vdd Vdd 0 1.8
Vin In  0 1.8 ac  1

XM1 Out In Vdd Vdd sky130_fd_pr__pfet_01v8_lvt w=7 l=.35
XM2 Out In 0   0   sky130_fd_pr__nfet_01v8_lvt w=7 l=.15

C1 out 0 100f

.ac dec 10 1meg 10e13

.control
run
plot vdb(out)
.endc

.end

