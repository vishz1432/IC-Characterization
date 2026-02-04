******************* Common Drain Amplifier with MOSFET load *******************
******************* DC ANALYSIS **********************************************

.title Common Drain Amplifier with MOSFET Load

.lib "/home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice" tt

.global gnd vdd
.temp 27

xmn1 Dn1 in out gnd sky130_fd_pr__nfet_01v8 w=5 l=2 m=4
xmn2 out Gn2 gnd gnd sky130_fd_pr__nfet_01v8 w=5 l=2 m=4
*RL out gnd 10
Vcm vdd Dn1 dc 0
Cl  out gnd 10p

Vsup  vdd gnd dc 1.8
Vbias Gn2 gnd dc 0.85
Vin   in  gnd dc 1.5 ac 1 sin(1.8 1m 100k)

*.dc Vbn1 0 1.8 0.01
.dc Vin 0 1.8 0.01

.control
run
set color0=white
plot v(out)
plot i(Vcm)
plot deriv(v(out))
.endc

.end

