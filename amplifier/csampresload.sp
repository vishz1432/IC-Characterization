* NgspiceCode for the CS AMPLIFIER with Resitive Load


.title CS Amplifier with NMOS Driver and Resistive Load

.lib /home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt

.global gnd
.temp 27

XM1 out in gnd gnd sky130_fd_pr__nfet_01v8 w=7 l=2 m=2
RD  avdd out 8K
CL  out gnd 10p

*vgs in gnd dc 0.9 ac -1
vsup avdd gnd dc 1.8
Vin  in gnd dc 0.9 ac -1 sin(0 1m 1000)

*.op
*.dc vgs 0 1.8 0.01
.ac dec 20 1 1G
*.tran 20u 1n

.control
run
set color0=white
print v(out)
plot v(in) v(out)
plot db20(v(out)/v(in))
plot ph(v(out)/v(in))
.end
.endc
