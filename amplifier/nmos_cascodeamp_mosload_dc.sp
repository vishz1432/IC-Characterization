******************** Cascode Amplifier with resistive load ********************
******************** DC ANALYSIS **********************************************

.title Cascode Amplifier with NMOS Driver and Resistive Load

.lib "/home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice" tt


.global gnd vdd
.temp 27

* NMOS transistors
xmn1 Dn1 in gnd gnd sky130_fd_pr__nfet_01v8 w=5 l=2 m=4
xmn2 Out Gn2 Dn1 gnd sky130_fd_pr__nfet_01v8 w=5 l=2 m=4

* PMOS load (acting as resistive load)
xmp1 Out Gp1 Ds1 vdd sky130_fd_pr__pfet_01v8_lvt w=5 l=2 m=14

* Biasing and load elements
Vcm vdd Ds1 dc 0
Cl out gnd 10p

* Supplies and bias voltages
Vsup vdd gnd dc 1.8
Vbn2 Gn2 gnd dc 1.3283
Vbp1 Gp1 gnd dc 0.998

* Input DC sweep source
Vin in gnd dc 0.84

* DC sweep
.dc Vin 0 1.8 0.001

.control
run
set color0=white
plot v(Out) v(Dn1)
plot v(Out)
plot v(Dn1)
plot i(Vcm)
plot deriv(v(out))
.endc

.end

