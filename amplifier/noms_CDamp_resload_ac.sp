******************* Common Drain Amplifier with resistive load *******************
******************* AC ANALYSIS *************************************************



.title Common Drain Amplifier with Resistive Load

.lib "/home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice" tt

.global gnd vdd
.temp 27

xmn1 Dn1 in out gnd sky130_fd_pr__nfet_01v8 w=5 l=2 m=4
Rs  out gnd 5k
*RL Out Gnd 8
Vcm vdd Dn1 dc 0
Cl  out gnd 10p

vsup vdd gnd dc 1.8
Vin  in gnd dc 1.5 ac 1 sin(1.438 1m 100k)

*.dc Vbn1 0 1.8 0.01
.ac dec 10 1 10G

.control
run
set color0=white
plot v(out)
*plot vdb(out)
plot ph(out)*(180/pi)
.endc

.end

