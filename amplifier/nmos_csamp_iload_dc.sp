**************** Common Source Amplifier with N-Channel MOSFET and Current Source Load ****************
**************** DC ANALYSIS ****************

.title CS Amplifier with NMOS Driver and PMOS Current Source Load

.lib /home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt

.global gnd vdd
.temp 27

* NMOS driver
xm1 out in gnd gnd sky130_fd_pr__nfet_01v8 w=7 l=2 m=2

* Current source NMOS bias
xm2 Dp2 Gn2 gnd gnd sky130_fd_pr__nfet_01v8 w=7 l=2 m=2

* PMOS load (current mirror)
xmp1 Dp1 Dp2 vdd vdd sky130_fd_pr__pfet_01v8_lvt w=7 l=2 m=6
xmp2 Dp2 Dp2 vdd vdd sky130_fd_pr__pfet_01v8_lvt w=7 l=2 m=6

* Bias voltages
Vcm1 Dp1 out dc 0
Vcm2 Dp2 Dn2 dc 0

* Load capacitance
Cl out gnd 10p

* Supply
vsup vdd gnd dc 1.8

* Input
Vin in gnd dc 0.9 ac 1 sin(0.9 1m 100k)

* Bias for current source
Vbn1 Gn2 gnd dc 0.9

* DC sweep

*.dc Vbn1 0 1.8 0.01
.dc Vin 0 1.8 0.01

.control
run
set color0=white
plot v(out) v(Dp2)
plot i(Vcm1) i(Vcm2)
print abs(v(Dp2))
.endc

.end

