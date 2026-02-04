******************* Common Gate Amplifier – Transient Analysis *******************

.title CG Amplifier with NMOS Driver and Resistive Load

.lib "/home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice" tt

.global gnd
.temp 27

xmn1 out Gn1 Sn1 gnd sky130_fd_pr__nfet_01v8 w=5 l=2 m=4
Rd  Rt1 out 8k
Cl  out gnd 10p
Vcm vdd Rt1 dc 0

vsup vdd gnd dc 1.8
Vgs  Gn1 gnd dc 1.0813
Vss  Sn1 gnd sin(0.2 10m 1k)

.tran 1u 10m 

.control
run
set color0=white
plot v(Sn1) v(out)
.endc

.end

