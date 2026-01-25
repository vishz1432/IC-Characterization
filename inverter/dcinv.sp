* CMOS Inverter DC Simulation – SKY130

.lib "/home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice" tt
.temp 25

VDD vdd 0 1.8
VIN in  0 0

XM1 out in 0   0   sky130_fd_pr__nfet_01v8 W=0.42 L=0.15
XM2 out in vdd vdd sky130_fd_pr__pfet_01v8 W=1.26 L=0.15

.dc VIN 0 1.8 0.01

.control
run
plot v(in) v(out)
.endc

.end

