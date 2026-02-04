******************* Common Gate Amplifier with N-Channel MOSFET and Resistive Load *******************

.title CG Amplifier with NMOS Driver and Resistive Load

.lib "/home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice" tt

.global gnd
.temp 27

xmn1 out Gn1 Sn1 gnd sky130_fd_pr__nfet_01v8 w=5 l=2 m=4
Rd  Rt1 out 8k
*Rs Rt2 gnd 2k
Cl  out gnd 10p
Vcm vdd Rt1 dc 0

vsup vdd gnd dc 1.8
Vgs  Gn1 gnd dc 1.08104
Vss  Sn1 gnd dc 0.2 ac 1 sin(0.2 10m 1k)

*.dc Vgs 0 1.8 0.01
.ac dec 10 1 1G
*.tran 20u 1n

.control
run
set color0=white
plot i(Vss) i(Vcm)
plot v(Sn1) v(Rt1) v(out)
plot db(out) db(Sn1)
plot ph(out)*(180/pi)
.endc

.end

