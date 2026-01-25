*  Dynamic power calculation of CMOS Inverter
.lib "/home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice" ss
.temp 125

Vdd Vdd 0 1.8
Vin In 0 PULSE(0 1.8 0 10n 10n 60n 120n)

XM1 Out In Vdd Vdd sky130_fd_pr__pfet_01v8_lvt w=7 l=.35
XM2 Out In 0   0   sky130_fd_pr__nfet_01v8_lvt w=7 l=.15

C1 out 0 1a

.tran 0.1n 240n              
.op

.control
run
plot V(in) V(Out)
plot abs(i(Vdd))

meas tran i(avg) AVG  i(Vdd)
meas tran rise_time  TRIG v(out) VAL=0.18 RISE=1  TARG v(out) VAL=1.62 RISE=1
meas tran fall_time  TRIG v(out) VAL=1.62 FALL=1  TARG v(out) VAL=0.18 FALL=1
meas tran delay_time TRIG v(in)  VAL=0.9  RISE=1  TARG v(out) VAL=0.9  RISE=1
meas tran vmax MAX v(out)
meas tran vmin MIN v(out)

let power = i(avg)*1.8
print power
.endc

.end

