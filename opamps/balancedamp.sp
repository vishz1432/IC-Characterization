AVLSI_2025.title Balanced Amplifier
.lib /home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.global vdd gnd
.temp 27


* NMOS bias / differential stage
xmn0 Dn1 Dn9 gnd gnd sky130_fd_pr__nfet_01v8 w=5 l=2 m=2
xmn1 Dn2 in  Dn1 gnd sky130_fd_pr__nfet_01v8 w=5 l=2 m=8
xmn2 Dn3 in  Dn1 gnd sky130_fd_pr__nfet_01v8 w=5 l=2 m=8
xmn3 Dn2 Dn2 Sp3 vdd sky130_fd_pr__pfet_01v8 w=5 l=2 m=5
xmn4 Dn3 Dn3 vdd vdd sky130_fd_pr__pfet_01v8 w=5 l=2 m=5


* Output stage
xmn6 vout Dn3 Sp5 vdd sky130_fd_pr__pfet_01v8 w=5 l=2 m=80
xmn5 Dn7  Dn2 Sp4 vdd sky130_fd_pr__pfet_01v8 w=5 l=2 m=80
xmn7 Dn7  Dn7 gnd gnd sky130_fd_pr__nfet_01v8 w=5 l=2 m=16
xmn8 vout Dn7 gnd gnd sky130_fd_pr__nfet_01v8 w=5 l=2 m=16
xmn9 Dn9  Dn9 gnd gnd sky130_fd_pr__nfet_01v8 w=5 l=2 m=2


* Load
Cl vout gnd 10p


* Bias current source
Isup vdd Dn9 dc 50u


* Common-mode control voltages
Vcm0 vdd Sp3 dc 0
Vcm1 vdd Sp4 dc 0
Vcm2 vdd Sp5 dc 0


* Supply and input
Vsup vdd gnd dc 1.8
Vin  in  gnd dc 1.2


* DC sweep
.dc Vin 0 1.8 0.01


.control
run
plot V(in) V(Dn7) V(Dn3) V(Dn2) V(Dn1)
plot I(Vcm0) I(Vcm1) I(Vcm2)
.endc

.end

