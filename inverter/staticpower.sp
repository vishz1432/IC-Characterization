******INVERTER-STATIC******
.lib "/home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice" ss
.temp 125

.global VDD GND

** PMOS case **
VDD      VDD     GND     DC 1.8
VIN      in      GND     DC 0

XP1      out     in      VDD     VDD    sky130_fd_pr__pfet_01v8_lvt L=0.35 W=7
XM1      out     in      GND     GND    sky130_fd_pr__nfet_01v8_lvt L=0.15 W=7
C1       out     0       1a

** NMOS case **
Vns     n1      0       DC 1.8
V1      i1      0       DC 1.8

XP2     o1      i1      n1      n1     sky130_fd_pr__pfet_01v8_lvt L=0.35 W=7
XM2     o1      i1      0       0      sky130_fd_pr__nfet_01v8_lvt L=0.15 W=7
C2      o1      0       1a

.OP

.control
run
print abs(I(VDD))
print abs(I(Vns))
let static_power = ((I(VDD)) + (I(Vns))) * 1.8
print abs(static_power)
.endc
.end

