* CMOS Inverter Transient Simulation – SKY130

.lib "/home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice" tt
.temp 25

* Supply Voltage
VDD vdd 0 DC 1.8

* Input Pulse
VIN in 0 PULSE(0 1.8 2n 0.1n 0.1n 100n 200n)

* CMOS Inverter
XM1 out in 0   0   sky130_fd_pr__nfet_01v8 W=1.26 L=0.15
XM2 out in vdd vdd sky130_fd_pr__pfet_01v8 W=1.26 L=0.15

* Load Capacitance
Cload out 0 100f

* Transient Analysis
.tran 0.1n 500n

.control
run
plot v(in) v(out)
.endc

.end

