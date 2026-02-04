**************** Common Source Amplifier with Resistive Load and Source Degeneration Resistance ****************
**************** DC ANALYSIS ****************

.title Source Degenerated CS Amplifier with NMOS Driver and Resistive Load

.lib /home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt

.global gnd vdd
.temp 27

* NMOS transistor
xm1 out in Sn1 gnd sky130_fd_pr__nfet_01v8 w=5 l=2 m=4

* Load and source resistances
Rd vdd net1 8k
Rs Sn1 gnd 0.8k

* Voltage monitor (for current)
Vcm net1 out dc 0

* Load capacitance
Cl out gnd 10p

* Supply voltage
vsup vdd gnd dc 1.8

* Input voltage
Vin in gnd dc 0.85 ac 1 sin(0.9 1m 100k)

* -------- DC SWEEP --------

*.dc Vbn1 0 1.8 0.01
.dc Vin 0 1.8 0.01 Rs 0 0.8k 0.2k

.control
run
set color0=white

plot v(out) v(Sn1)
plot i(Vcm)
plot deriv(v(out))

.endc

.end

