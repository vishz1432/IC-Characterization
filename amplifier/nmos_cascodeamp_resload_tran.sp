******************* Cascode Amplifier with Resistive Load (Transient) *******************

.title Cascode Amplifier with NMOS Driver and Resistive Load - Transient Analysis

.lib "/home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice" tt

.global gnd vdd
.temp 27

xmn1 Dn1 in  gnd gnd sky130_fd_pr__nfet_01v8 w=5 l=2 m=4
xmn2 out Gn2 Dn1 gnd sky130_fd_pr__nfet_01v8 w=5 l=2 m=4

Rd  Rt1 out 8k
Cl  out gnd 10p
Vcm vdd Rt1 dc 0

vsup vdd gnd dc 1.8
Vb2  Gn2 gnd dc 1.3283

* Transient input (sine signal around bias point)
Vin in gnd dc 0.84 sin(0.84 1m 100k)

.tran 10n 100u

.control
run
set color0=white
plot v(in) v(out)
.endc

.end

