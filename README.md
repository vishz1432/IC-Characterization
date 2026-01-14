# IC-Characterization

This repository provides a step-by-step guide to Analog IC Characterization, starting from MOS device fundamentals and progressing to amplifier and op-amp analysis. It bridges theory and practice through hands-on simulations using NGSpice, Xschem, and the SKY130 PDK, covering key DC, AC, transient, and PVT performance parameters.

## What is Analog IC Characterization ?

Analog IC (Integrated Circuit) Characterization is the process of evaluating and measuring the electrical performance of an analog circuit under various conditions. This involves testing key parameters such as gain, offset, bandwidth, noise, power consumption, input/output impedance, temperature stability, and process variation sensitivity.

Characterization is carried out using tools like Ngspice, Spectre, HSPICE, Eldo (Simulation) and Xschem (Schematic) providing a complete framework for accurate simulation and analysis of analog circuits.

Characterization is usually performed post-design (pre- and post-fabrication) to ensure the circuit behaves as intended across different corners:
- Process Corners: Variations in manufacturing (e.g., TT, FF, SS).
- Voltage Corners: Operating at min/max supply voltages.
- Temperature Corners: Measuring across temperature range (e.g., -40°C to 125°C).

```bash
IC-Characterization/
│
├── 00_Introduction/
│   └── Overview of IC characterization
│
├── 01_Device_Physics/
│   └── MOSFET fundamentals and theory
│
├── 02_MOSFET_DC_Characterization/
│   ├── ID-VGS characteristics
│   ├── ID-VDS characteristics
│   ├── Threshold voltage extraction
│   └── Channel length modulation
│
├── 03_Small_Signal_Parameters/
│   ├── gm extraction
│   ├── ro extraction
│   └── Intrinsic gain (gm·ro)
│
├── 04_Basic_CMOS_Circuits/
│   ├── CMOS inverter DC analysis
│   ├── Noise margin
│   └── Transient response
│
├── 05_AC_Analysis/
│   ├── Frequency response
│   ├── Gain & bandwidth
│   └── Poles and zeros
│
├── 06_Noise_Analysis/
│   ├── Thermal noise
│   ├── Flicker (1/f) noise
│   └── Input-referred noise
│
├── 07_Single_Stage_Amplifiers/
│   ├── Common Source amplifier
│   ├── Common Gate amplifier
│   └── Source Follower
│
├── 08_Differential_Amplifiers/
│   └── Differential pair characterization
│
├── 09_OpAmp_Characterization/
│   ├── DC gain
│   ├── GBW
│   ├── CMRR & PSRR
│   └── Slew rate
│
└── README.md
```


 # 1.Tools and PDK Setup

 ## 1.1 Tools Required

 For the simulation of circuits we will need the following tools.
 - Spice netlist simulation -[Ngspice](https://ngspice.sourceforge.io/).
 - Schematic Editor - [Xschem](https://xschem.sourceforge.io/stefan/index.html)

### Ngspice ###


<img width="200" height="80" alt="image" src="https://github.com/user-attachments/assets/8f2c2a5f-52c2-417e-883c-3446eb12e916" />


[Ngspice](https://ngspice.sourceforge.io/devel.html) is the open source spice simulator for electric and electronic circuits. Ngspice is an open project, there is no closed group of developers.

[Ngspice User Manual](https://ngspice.sourceforge.io/docs/ngspice-html-manual/manual.xhtml).Complete reference manual in HTML format.

### Xschem ###

<img width="200" height="80" alt="image" src="https://github.com/user-attachments/assets/831fb715-0a88-4c82-811f-ce6a320eb3e9" />

[Xschem](https://xschem.sourceforge.io/stefan/)is an open-source schematic capture tool for VLSI and electronics. It is designed to be lightweight, fast, and capable of handling large hierarchical circuits while remaining user-friendly.

[Xschem Reference Manual](https://xschem.sourceforge.io/stefan/xschem_man/xschem_man.html).Complete reference manual.


## 1.2 PDK Required ##

A process design kit (PDK) is a set of files used within the semiconductor industry to model a fabrication process for the design tools used to design an integrated circuit. The PDK is created by the foundry defining a certain technology variation for their processes. It is then passed to their customers to use in the design process.

The PDK is [Google Skywater 130 nm PDK](https://skywater-pdk.readthedocs.io/en/main/).


<img width="455" height="190" alt="image" src="https://github.com/user-attachments/assets/2afe1e47-67b5-48d4-a2b8-02763c6b650a" />

[All Details](https://skywater-pdk.readthedocs.io/en/main/rules/device-details.html).All basic details of PDK.


## 1.3 Install and Setup EDA Tools ##

### Windows Subsystem for Linux (WSL) for Open Source EDA tools ###

Windows Subsystem for Linux (WSL) is a feature of Windows that allows you to run a Linux environment on your Windows machine, without the need for a separate virtual machine or dual booting. With native X11 (graphics) support on WSL2, the latest WSL, in Winodws 10 version 2004+ (Build 19041+) or Windows 11, you can now run GUI apps including all the open-source EDA tools.

Now we will share instructions for installing WSL2 on Winodws 10/11 and install the EDA tools on a Ubuntu 24.04 distribution.

## 1.4 Install and Setup EDA Tools

## Windows Subsystem for Linux (WSL) for Open Source EDA tools

Windows Subsystem for Linux (WSL) is a feature of Windows that allows you to run a Linux environment on your Windows machine, without the need for a separate virtual machine or dual booting. With native X11 (graphics) support on WSL2, the latest WSL, in Winodws 10 version 2004+ (Build 19041+) or Windows 11, you can now run GUI apps including all the open-source EDA tools.

Now we will share instructions for installing WSL2 on Winodws 10/11 and install the EDA tools on a Ubuntu 24.04 distribution.

## Install WSL
- Prerequisites: Winodws 10 version 2004+ (Build 19041+) or Windows 11.
- If you have a previous WSL installed without your knowledge or, you've installed in from the Microsoft Store, it's best you uninstall it using the Windows "Add/remove Programs" app and/or ```bash wsl --uninstall ```.
- Open PowerShell or Windows Command Prompt in ADMINISTRATOR mode by right-clicking and selecting "Run as administrator".
- In the PowerShell type ```bash wsl --list --online ```.
  - This will list all the available distributions online.
- To install a particular distribution (Distro) say Ubuntu-24.04 (The name has to be exactly as printed in the above command):
   - ```bash wsl --install -d Ubuntu-24.04 ```
- It's important to update the WSL now by typing the following in the Powershell:
   - wsl --update.
- And shut it down:```bash wsl --shutdown```.Note: it will automatically start when the WSL distro selected from the Windows menu.

## Launching Ubuntu 24.04.

- ```bash Press Windows Key → select Ubuntu 24.04.```
- Update the system
  ```bash sudo apt update && sudo apt upgrade -y ```
- Clone the Github Repository
```bash
 cd ~
git clone https://github.com/IC Characterization.
```
- Copy & make install scripts executable
```bash
cp ~/IC Characterization/install*.sh .
 chmod +x install*.sh
```
- Install dependencies & EDA tools
   ```bash
   ./install-libs.sh
   ./install-eda.sh
   ```
- Add EDA environment variables
  ```bash
   cat ~/IC Characterization/bashrc-eda >> ~/.bashrc
  source ~/.bashrc
  ```
- Setup Xschem initialization
   ```bash
   cp ~/share/xschemrc ~/.xschem/xschemrc
   ```
- Then type this command:
   ```bash
   tree -L 2
   ```


# 2. Linear Elements

## 2.1 Resistors
- A resistor is a passive electrical component that resists the flow of electric current, producing a voltage drop across its terminals according to Ohm's Law: ```bash V = I * R ```.
- The resistance R of a material depends on its physical properties and geometry, given by the formula: ```bash R = ρL / A```.
- In the Skywater SKY130 PDK, multiple resistor types are available for analog and digital IC design, offering different resistance values, temperature characteristics.

### Types of Resistors available :
- ``` bash sky130_fd_pr__res_high_po.model ```  has base models with 0.35u, 0.69u, 1.41u, 2.85u, 5.73u as bin width (fixed) with changable lengths.
- ``` bash sky130_fd_pr__res_xhigh_po.model``` also has base models with 0.35u, 0.69u, 1.41u, 2.85u, 5.73u as bin width (fixed) with changable lengths.
- ``` bash sky130_fd_pr__res_generic_nd.model ``` is a Generic N-diff type resister.
- ``` bash sky130_fd_pr__res_generic_pd.model``` is a Generic P-diff type resister.

### Ngspice File:
```bash
Title: Resistor Simulation

.lib "/home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice" tt
.temp 25

Vin     in      0       DC 1.8
Vm      in      1       0V
X1      1       0       vdd   sky130_fd_pr__res_high_po_0p35 L=3.5
vsup    vdd     gnd     DC 1.8

.op

.control
run
print v(in)
print abs(i(Vm))
let RES = v(in)/abs(i(Vm))
print RES
.endc

.end
```
### Resistance calculation (manual check)
***R=VI***
=
1.8
4.048903
×
10
−
4
R=
I
V
	​

=
4.048903×10
−4
1.8
	​

𝑅
≈
4445.6
 
Ω
  
≈
  
4.45
 
𝑘
Ω
R≈4445.6 Ω≈4.45kΩ

### Output:
<img width="467" height="268" alt="image" src="https://github.com/user-attachments/assets/520694b6-9476-46ce-acd7-d6cb79baa5f0" />

## 2.2 Capacitors

- A capacitor is a passive electrical component that stores energy in the form of an electric field, defined by the relation: ```bash Q = C * V``` where ```C ```is the capacitance in Farads.
- The capacitance C of a parallel-plate capacitor depends on its physical structure and the material between the plates, given by the formula: ```C = εA / d```.
- In the Skywater SKY130 PDK, various capacitor types are available for use in analog, RF, and digital designs, each offering trade-offs in capacitance density, linearity, voltage rating, and temperature stability.


### Types of Capacitor available:

- ```sky130_fd_pr__cap_mim_m3_1.model``` is a Metal-Insulator-Metal (MIM) capacitor between Metal3 and Metal2, suitable for analog precision applications.
- ```sky130_fd_pr__cap_mim_m3_2.model``` is another MIM capacitor variant with different area usage and parasitic trade-offs.
- ```sky130_fd_pr__cap_mim_m2_1.model``` defines a MIM capacitor between Metal2 and Metal1 layers.
- ```sky130_fd_pr__cap_var_lvt.model``` is a MOS varactor (voltage-dependent capacitor) built using LVT NMOS structure, useful for RF tuning.
- ```sky130_fd_pr__cap_var_hvt.model``` is a similar varactor using HVT device for different threshold and leakage behavior.


```
* Capacitor Simulation – SKY130

.lib "/home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice" tt
.temp 25

* Apply DC voltage
V1 in 0 DC 1.8

* Zero-volt source to measure current
Vm in node 0

* MIM Capacitor
XC1 node 0 sky130_fd_pr__cap_mim_m3_1 w=1 l=1

.op

.control
run
print v(in)
print i(Vm)
.endc

.end
```
### output:
<img width="477" height="347" alt="image" src="https://github.com/user-attachments/assets/c7cacbbb-1c4d-4194-b60d-9e0854913023" />

## 2.3 RC Circuits

- An RC circuit is an electric circuit composed of resistors (R) and capacitors (C), which exhibit a time-dependent response to voltage or current changes. The fundamental time constant is defined as:
```τ = R * C```, where ```τ``` (tau) represents the time constant in seconds, indicating how quickly the circuit charges or discharges.

- In the Skywater SKY130 PDK, RC circuits are implemented using integrated resistors (e.g., ```sky130_fd_pr__res_high_po```) and capacitors (e.g., ```sky130_fd_pr__cap_mim_m3_1```). These are critical in analog and mixed-signal design applications such as filters, timing circuits, and analog front ends.


<img width="425" height="366" alt="image" src="https://github.com/user-attachments/assets/5b0a43bb-29ef-43a6-ae32-6c5a0b6cb6a4" />

### 2.3.1 Transient Analysis 
```
Title: RC Ckt Simulation using SKY130 model

.lib "/home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice" tt
.temp 25

Vin     in      0       PULSE(0 1.8 0 0 0 100p 200p)
XR1     in      out     0       sky130_fd_pr__res_high_po_0p35 l=3.5
XC1     out     0       sky130_fd_pr__cap_mim_m3_1 w=1 l=1

.tran 1p 300p

.control
run
plot v(in) v(out)
.endc

* Measure Time delays
.meas tran rise        TRIG V(out) VAL=0.18 RISE=1 TARG V(out) VAL=1.62 RISE=1
.meas tran fall        TRIG V(out) VAL=1.62 FALL=1 TARG V(out) VAL=0.18 FALL=1
.meas tran rise_delay  TRIG V(in)  VAL=0.9  RISE=1 TARG V(out) VAL=0.9  RISE=1
.meas tran fall_delay  TRIG V(in)  VAL=0.9  FALL=1 TARG V(out) VAL=0.9  FALL=1

* Measure Max Voltage
.meas tran VMAX MAX V(out)

.end
```
### Output:
<img width="635" height="465" alt="image" src="https://github.com/user-attachments/assets/46dbc60d-d1d2-4aaa-aae2-42e22e418ca4" />
<img width="702" height="537" alt="image" src="https://github.com/user-attachments/assets/d3cee4ad-6c01-458a-bf09-7e7a305753ad" />

### 2.3.2 AC Analysis 

### Ngspice File:
```
* RC circuit AC analysis
.lib "/home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice" tt
.temp 25

V1      in      0       AC 1
XR1     in      out     0       sky130_fd_pr__res_high_po_0p35 l=3.5
XC1     out     0       sky130_fd_pr__cap_mim_m3_1 w=1 l=1

* AC Simulation
.ac dec 10 1 15g

.control
run
.meas ac f3db WHEN VDB(out) = -3
plot vdb(out)
.endc

.end
```
### Output:
<img width="1862" height="668" alt="image" src="https://github.com/user-attachments/assets/f7758806-e918-4630-bcc4-925f201aa1c9" />

### Calculation of Cutoff Frequency (Hz)

| Temperature | HH (GHz) | TT (GHz) | LL (GHz) |
|-------------|----------|----------|----------|
| -40 °C | 7.32 | 10.05 | 16.91 |
| 25 °C  | 7.39 | 10.57 | 16.66 |
| 125 °C | 7.37 | 10.37 | 15.99 |


## 2.4 CR Circuits

- A Cr circuit is essentially the same as an RC circuit, but with the capacitor (C) placed before the resistor (R) in the signal path. While electrically the time constant remains the same, the circuit response differs, especially in transient analysis. The fundamental time constant is defined as:
```τ = R * C```, where ```τ ```(tau) represents the time constant in seconds, indicating how quickly the circuit charges or discharges.

- In the Skywater SKY130 PDK, CR circuits are implemented using integrated capacitors (e.g.,``` sky130_fd_pr__cap_mim_m3_1```) and resistors (e.g.,``` sky130_fd_pr__res_high_po```). These configurations are often used in differentiator circuits, pulse shaping, and AC coupling applications in analog and RF systems.


<img width="381" height="273" alt="image" src="https://github.com/user-attachments/assets/b315ef11-7f38-450d-b35d-f9570fbfa7b4" />

### Ngspice file:
```
* Title: CR Ckt Simulation using SKY130 model

.lib "/home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice" tt
.temp 25

Vin     in      0       PULSE(0 1.8 0 0 0 100p 200p)
XC1     in      out     sky130_fd_pr__cap_mim_m3_1 w=1 l=1
XR1     out     0       0       sky130_fd_pr__res_high_po_0p35 l=3.5

.tran 1p 300p

.control
run
plot v(in) v(out)
.endc

* Measure Time delays
.meas tran rise        TRIG V(out) VAL=0.14 RISE=1 TARG V(out) VAL=1.29 RISE=1
.meas tran fall        TRIG V(out) VAL=1.29 FALL=1 TARG V(out) VAL=0.14 FALL=1
.meas tran rise_delay  TRIG V(in)  VAL=0.7  RISE=1 TARG V(out) VAL=0.7  RISE=1
.meas tran fall_delay  TRIG V(in)  VAL=0.7  FALL=1 TARG V(out) VAL=0.7  FALL=1

* Measure Max Voltage
.meas tran VMAX MAX V(out)

.end
```
### Output:

<img width="556" height="367" alt="image" src="https://github.com/user-attachments/assets/115977b0-3138-4a59-9b3e-97e9542e7bc4" />

<img width="602" height="446" alt="image" src="https://github.com/user-attachments/assets/a4c0b145-fbb4-434b-b0b8-daeeda7fdbb8" />
















  








   







  
