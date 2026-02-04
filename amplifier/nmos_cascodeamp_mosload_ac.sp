**************** Cascode Amplifier with Mosload Load ****************
**************** AC ANALYSIS ****************************************

.title Cascode Amplifier (Mosload Load)

.lib "/home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice" tt

.global gnd vdd
.temp 27

* NMOS devices (cascode)
xmn1 Dn1 in  gnd gnd sky130_fd_pr__nfet_01v8 w=5 l=2 m=4
xmn2 Out Gn2 Dn1 gnd sky130_fd_pr__nfet_01v8 w=5 l=2 m=4

* Resistive load
Rload vdd Out 8k

* Small load capacitance
Cl out gnd 10p

* Supply and bias
Vdd  vdd gnd dc 1.8
Vbn2 Gn2 gnd dc 1.3283

* AC input (biased)
Vin in gnd dc 0.84 ac 1

* AC sweep
.ac dec 10 1 1G

.control
run
set color0=white
plot vdb(out)
plot ph(out)*180/pi
.endc

.end

