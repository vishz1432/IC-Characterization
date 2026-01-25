* NMOS analysis
.lib "/home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice" tt
.include "/home/vishalvlsi/share/pdk/sky130A/libs.ref/sky130_fd_pr/spice"
.temp 25

Vd   1   0   DC 1.8
Vid  1   d   DC 0
Vg   g   0   DC 0

* NMOS: D G S B
X1 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=1

.control
run
save all

*Uncomment these 2 lines for ID vs VGS Curve

*dc vg 0 1.8 0.001 vd 0 1.8 0.1
*plot I(vid) xlabel "VGS (V)" ylabel "ID (A)" title "ID vs VGS"

* Uncomment these 2 lines for ID vs VDS Curve

dc vd 0 1.8 0.001 vg 0 1.8 0.1
plot I(vid) xlabel "VDS (V)" ylabel "ID (A)" title "ID vs VDS"
.endc

.end

