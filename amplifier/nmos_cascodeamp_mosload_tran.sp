**************** Cascode Amplifier with resistive load ****************
**************** TRANSIENT ANALYSIS *********************************

.title Cascode Amplifier with NMOS Driver and Resistive Load

.lib "/home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice" tt

.global gnd vdd
.temp 27

xmn1 Dn1 in  gnd gnd sky130_fd_pr__nfet_01v8 w=5 l=2 m=4
xmn2 Out Gn2 Dn1 gnd sky130_fd_pr__nfet_01v8 w=5 l=2 m=4
xmp1 Out Gp1 Ds1 vdd sky130_fd_pr__pfet_01v8_lvt w=5 l=2 m=14

Vcm vdd Ds1 dc 0
Cl out gnd 10p

vsup vdd gnd dc 1.8
Vbn2 Gn2 gnd dc 1.3283
Vbp1 Gp1 gnd dc 0.998
Vin in gnd dc 0.84 ac 1 sin(0.84 1m 1k)

.tran 1u 10m

.control
run
set color0=white
plot v(out)
plot v(in)
.endc

.end

