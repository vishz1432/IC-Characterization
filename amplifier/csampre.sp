* Common Source Amplifier - AC Analysis (SKY130)

.lib "/home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice" tt
.lib "/home/vishalvlsi/share/pdk/sky130A/libs.ref/sky130_fd_pr/spice/sky130_fd_pr__nfet_01v8.pm3.spice" tt

.temp 25

* Supply
VDD     vdd     0       1.8

* Gate bias + AC input
VIN     g       0       DC 0.8  AC 1

* Drain resistor (ideal)
RD      vdd     d       10k

* NMOS (L, W, mult REQUIRED)
XM1     d       g       0   0   sky130_fd_pr__nfet_01v8  L=0.18u W=5u mult=1

* AC analysis
.ac dec 10 1 10G

.control
run
plot vdb(d)
.endc

.end

