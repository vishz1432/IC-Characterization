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

### 2.4.1 Transient Analysis:
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


### 2.4.2 AC Analysis 

```
* CR Charging Circuit with Pulse Input
.lib "/home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice" tt
.temp 25

V1       in     0           AC 1
XC1      in     out         sky130_fd_pr__cap_mim_m3_1  w=1 l=1
XR1      out    0       0   sky130_fd_pr__res_high_po_0p35  l=3.5

.ac dec 10 1meg 10e13

.control
run
plot vdb(out)
.endc

.end
```
### Output:
<img width="1899" height="1003" alt="Screenshot 2026-01-15 193340" src="https://github.com/user-attachments/assets/5021500a-3b01-4abf-84e0-2d11033411ef" />


# 3. MOSFET Circuits
- A MOSFET (Metal-Oxide-Semiconductor Field-Effect Transistor) is a three-terminal active device used for switching and amplification. Its current is controlled by the voltage applied to the gate terminal.
- The MOSFET operates in three regions: cutoff, linear, and saturation, depending on gate-source (VGS) and drain-source (VDS) voltages.
- In the Skywater SKY130 PDK, MOSFETs like ```sky130_fd_pr__nfet_01v8``` (NMOS) and ```sky130_fd_pr__pfet_01v8``` (PMOS) are commonly used.
   These are essential in digital logic, analog amplifiers, and switching applications.


## 3.1 NMOS Analysis
- A NMOS (N-type MOSFET) is a majority-carrier device where current flows between the drain and source when a positive voltage is applied to the gate. It acts as a voltage-controlled current source.
- The drain current (ID) depends on the gate-to-source voltage (VGS), and its behavior changes across three regions:
    - Cutoff: VGS < Vth, ID ≈ 0
    - Linear: VGS > Vth and VDS < VGS − Vth
    - Saturation: VDS ≥ VGS − Vth

- The ID-VGS curve shows how the drain current increases with gate voltage (at constant VDS), helping identify the threshold voltage (Vth), where the transistor starts conducting. This curve is essential for characterizing the device and is often used in DC sweep simulations.
- In the Skywater SKY130 PDK, NMOS devices like sky130_fd_pr__nfet_01v8 are used in logic gates, analog blocks, and current sources.


```
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

* Uncomment these 2 lines for ID vs VGS Curve
*dc vg 0 1.8 0.001 vd 0 1.8 0.1
*plot I(vid) xlabel "VGS (V)" ylabel "ID (A)" title "ID vs VGS"

* Uncomment these 2 lines for ID vs VDS Curve
*dc vd 0 1.8 0.001 vg 0 1.8 0.1
*plot I(vid) xlabel "VDS (V)" ylabel "ID (A)" title "ID vs VDS"
.endc

.end
```
### Output(ID-VGS):
<img width="601" height="434" alt="Screenshot 2026-01-15 205213" src="https://github.com/user-attachments/assets/0e08a054-56c0-4263-9470-c01d2f395ea1" />


### (ID-VDS):
<img width="606" height="438" alt="image" src="https://github.com/user-attachments/assets/9459f17a-2cba-495f-ade9-b42f97862c9a" />


| Temperature | FF (V) | TT (V) | SS (V) |
|------------|--------|--------|--------|
| -40 °C | 0.49 | 0.539 | 0.579 |
| 25 °C  | 0.52 | 0.55  | 0.579 |
| 125 °C | 0.407 | 0.439 | 0.46  |


# 2. Inverter Schematic #

  <img width="600" height="550" alt="Screenshot 2026-01-07 203329" src="https://github.com/user-attachments/assets/db3ad126-0885-464f-8d9b-8ea2a42d87d9" />


### key Points ###

- Technology: SKY130 (1.8 V low-Vt devices)
- Transistors Used: pfet_01v8_lvt (PMOS), nfet_01v8_lvt (NMOS)
- Simulation Tools: Xschem (schematic) + Ngspice (simulation)
- Input: Pulse source (0 → 1.8 V)
- Output: Clean digital inversion with sharp transition near VDD/2

 ## 2.1. Regions of Operations 


   <img width="651" height="317" alt="Screenshot 2026-01-07 112216" src="https://github.com/user-attachments/assets/fbc9d67d-d95b-4156-98c6-c69f23c1b2b4" />



## 2.2. DC Analysis 

**Objective:-**
- Obtain the Voltage Transfer Characteristic (VTC).
- Determine switching threshold and noise margins.

 **Method:**       The input voltage is swept from 0 V to 1.8 V while monitoring the output voltage.

 **Key Observations:** 
 - Sharp transition region.
 - Switching threshold near VDD/2.
 - Proper rail‑to‑rail output swing.


## VTC Curve : - Before using Tool

<img width="464" height="370" alt="Screenshot 2026-01-07 112049" src="https://github.com/user-attachments/assets/72ef79a3-1d14-4dbf-b35e-6e692c00a6a7" />


## Spice File : 
```bash
* CMOS Inverter DC Simulation – SKY130

.lib "/home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice" tt
.temp 25

VDD vdd 0 1.8
VIN in  0 0

XM1 out in 0   0   sky130_fd_pr__nfet_01v8 W=0.42 L=0.15
XM2 out in vdd vdd sky130_fd_pr__pfet_01v8 W=1.26 L=0.15

.dc VIN 0 1.8 0.01

.control
run
plot v(in) v(out)
.endc

.end
```

## Simulation :

<img width="1002" height="626" alt="Screenshot 2026-01-08 125647" src="https://github.com/user-attachments/assets/d8efdc2d-e641-45d4-97c3-44e379e4baf7" />

## 2.3 Transient Analysis

**Objective:-**
- Measure rise time and fall time.
- Estimate propagation delay.

**Method:** A pulse input is applied, and the output waveform is observed under capacitive loading.
**key Observation:**
- Clean digital inversion.
- Sub‑nanosecond rise and fall times.
- Delay increases with load capacitance.


## Spice File :
```bash
* CMOS Inverter Transient Simulation – SKY130

.lib "/home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice" tt
.temp 25

* Supply Voltage
VDD vdd 0 DC 1.8

* Input Pulse
VIN in 0 PULSE(0 1.8 2n 0.1n 0.1n 100n 200n)

* CMOS Inverter
XM1 out in 0   0   sky130_fd_pr__nfet_01v8 W=1.26 L=0.15
XM2 out in vdd vdd sky130_fd_pr__pfet_01v8 W=1.26 L=0.15

* Load Capacitance
Cload out 0 100f

* Transient Analysis
.tran 0.1n 500n

.control
run
plot v(in) v(out)
.endc

.end
```
## Simulation :
<img width="1002" height="650" alt="Screenshot 2026-01-08 131301" src="https://github.com/user-attachments/assets/7abe5c0a-ac61-40e8-aa1f-d552316a8b88" />



## 2.4 AC Analysis

**Objective:**
- Analyze small‑signal frequency response.
- Determine inverter gain and bandwidth.

**Method:**  Small‑signal AC analysis is performed with a capacitive load at the output.

**Key Observations:**
- High gain at low frequencies.
- Roll‑off at higher frequencies due to parasitics.


## Spice File :

```bash
* CMOS Inverter AC Feedthrough Response (Rising Plot)

.lib "/home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice" ss
.temp 125

* Supply (AC grounded)
VDD vdd 0 DC 1.8 AC 0

* Input with AC excitation ONLY (no DC bias)
VIN in 0 DC 0 AC 1

* CMOS inverter
XM1 out in vdd vdd sky130_fd_pr__pfet_01v8_lvt W=7 L=0.35
XM2 out in 0   0   sky130_fd_pr__nfet_01v8_lvt W=7 L=0.15

* Load capacitance
 out 0 100f

* AC sweep
.ac dec 10 1Meg 10e13

.control
run
plot vdb(out)
.endc

.end
```

## Simulation :

<img width="1002" height="650" alt="image" src="https://github.com/user-attachments/assets/eee5fde2-451d-49e6-af0a-73f1e3b83ab2" />

## 2.4. Static Power Analysis

**Objective:**
- Estimate leakage power in steady‑state conditions.

**Method:**
DC operating‑point analysis is used to measure supply current when the inverter input is at logic ‘0’ and logic ‘1’.

**Key Observation**
- Static power is extremely low.
- Leakage current dominates static consumption.

## Spice File :
```bash
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
```
## Simulation :
<img width="802" height="600" alt="image" src="https://github.com/user-attachments/assets/e2be81eb-14f0-4698-9dcc-fa6bd97c783a" />

### Output Value :
<img width="535" height="390" alt="Screenshot 2026-01-08 164741" src="https://github.com/user-attachments/assets/6f0597ff-e477-48fd-9cce-e6e629544da3" />


## 2.5. Dynamic Power Analysis

**Objective:**
- Calculate average power during switching activity.

**Method:** Average supply current is measured during transient simulation and multiplied by supply voltage.

**Key Observation**
- Dynamic power increases with switching frequency.
- Load capacitance significantly affects power consumption.

## Spice File :
```bash
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
```
## Simulation :
<img width="923" height="731" alt="image" src="https://github.com/user-attachments/assets/abcb3be6-bd7b-44f6-9c92-c777cb89d365" />

### Values :
- i(avg) = -1.040382e-05 from= 0.000000e+00 to= 2.400000e-07
- rise_time = 1.105302e-09 targ= 7.625172e-08 trig= 7.514641e-08
- fall_time = 1.073558e-09 targ= 4.883824e-09 trig= 3.810266e-09
- delay_time = 7.061907e-08 targ= 7.561907e-08 trig= 5.000000e-09
- vmax = 1.801978e+00 at= 1.328000e-09
- vmin = -1.456401e-04 at= 1.900300e-07
- Power = -1.87269e-05

<img width="702" height="558" alt="Screenshot 2026-01-08 165910" src="https://github.com/user-attachments/assets/3b535753-16cc-48b1-b893-7d021e92edbd" />



<img width="702" height="550" alt="Screenshot 2026-01-08 165845" src="https://github.com/user-attachments/assets/f91ee96a-e69a-4259-aa42-e1b2dfdc076e" />

### Theory & Derivation :

![WhatsApp Image 2026-01-08 at 5 10 48 PM](https://github.com/user-attachments/assets/67723532-6c64-4dd8-aa6c-f8e331880a17)


## 2.6. Inverter Fanout Analysis 

- Fanout Analysis evaluates how driving multiple identical inverter loads affects an inverter’s timing performance. As fanout increases, the effective capacitive load at the output rises, causing longer rise/fall times and increased propagation delay due to limited drive strength.

**Objective:**
Study the effect of multiple inverter loads on delay.

**Method:**  The inverter output is connected to several identical inverter inputs, and timing degradation is measured.

**Key Observations:**
- Rise/fall times increase with fanout.
- Propagation delay increases as load increases.

## Spice File :

```bash
* FANOUT
.lib "/home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice" ss
.temp 125

Vdd Vdd 0 1.8
Vin In 0 PULSE(0 1.8 0 10n 10n 60n 120n)

XM1 Out In Vdd Vdd sky130_fd_pr__pfet_01v8_lvt w=7 l=.35
XM2 Out In 0   0   sky130_fd_pr__nfet_01v8_lvt w=7 l=.15

XM11 Out1 Out Vdd Vdd sky130_fd_pr__pfet_01v8_lvt w=7 l=.35
XM21 Out1 Out 0   0   sky130_fd_pr__nfet_01v8_lvt w=7 l=.15

XM12 Out2 Out Vdd Vdd sky130_fd_pr__pfet_01v8_lvt w=7 l=.35
XM22 Out2 Out 0   0   sky130_fd_pr__nfet_01v8_lvt w=7 l=.15

XM13 Out3 Out Vdd Vdd sky130_fd_pr__pfet_01v8_lvt w=7 l=.35
XM23 Out3 Out 0   0   sky130_fd_pr__nfet_01v8_lvt w=7 l=.15

XM14 Out4 Out Vdd Vdd sky130_fd_pr__pfet_01v8_lvt w=7 l=.35
XM24 Out4 Out 0   0   sky130_fd_pr__nfet_01v8_lvt w=7 l=.15

.tran 0.1n 240n
.op

.control
run
meas tran rise_time  TRIG v(out) VAL=0.18 RISE=1  TARG v(out) VAL=1.62 RISE=1
meas tran fall_time  TRIG v(out) VAL=1.62 FALL=1 TARG v(out) VAL=0.18 FALL=1
meas tran delay_time TRIG v(in)  VAL=0.9  RISE=1 TARG v(out) VAL=0.9  RISE=1
meas tran vmax MAX v(out)
meas tran vmin MIN v(out)
.endc

.end
```
## Simulation :
<img width="702" height="550" alt="image" src="https://github.com/user-attachments/assets/82421285-375c-4794-8eab-6bec814f7162" />

## Output 
- rise_time = 1.373773e-09 targ= 7.662521e-08 trig= 7.525144e-08
- fall_time = 1.396628e-09 targ= 5.307938e-09 trig= 3.911310e-09
- delay_time = 7.116898e-08 targ= 7.616898e-08 trig= 5.000000e-09
- vmax = 1.801976e+00 at= 1.213500e-07
- vmin = -1.311942e-04 at= 7.015000e-08

# 3. Amplifier 


## 3.1  Single Stage Amplifier 
- Common Source configuration.
  - Resistive Load .
  - Mosfet Load or Diode Load .
  - Mosfet in Saturation.
  - Source degenration.
- Common Gate Configuration (Current Gain).
- Common Drain Configuration.(source follower Config).(Buffer).
- Cascode Configuration Amplifier.

### For Checking We will Do 
1. DC Analysis.
2. AC Analysis.
   - Gain
   - Output resistance.
   - Input resistance.
   - Input swing.
   - Output swing.

### 3.1.1(A) Common Source Amplifier with Resistive Load.
![WhatsApp Image 2026-01-21 at 8 53 04 PM](https://github.com/user-attachments/assets/3fa01a7a-d4c6-47df-aac1-a7144b57d520)

## Specification For Designing:

| Parameter | Description | Value |
|---------|------------|-------|
| VDD | Supply Voltage | 1.8 V |
| Technology Node | Process | 130 nm |
| Vbias | Bias Voltage | 1.8 V |
| VDS | Drain–Source Voltage | 0.9 V |
| VGS | Gate–Source Voltage | 1.0 V |
| Vt | Threshold Voltage | 0.55 V |
| W | Transistor Width | 10 µm |
| L | Transistor Length | 2 µm |
| CL | Load Capacitance | 10 pF |
| RD | Drain Resistance | 10 kΩ |
| KP (μnCox) | Transconductance Parameter | 220 µA/V² |
| λ | Channel Length Modulation | 0.05 V⁻¹ |
| gm | Transconductance | Extracted from AC analysis |
| ro | Output Resistance | Extracted from AC analysis |
| Av | Voltage Gain | Extracted from AC analysis |
| BW | Bandwidth | >= 2 MHz |
| UGB | Unity Gain Bandwidth | >= 10 MHz |

### Spice Code

```

.title CS Amplifier with NMOS Driver and Resistive Load

.lib /home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt

.global gnd
.temp 27

XM1 out in gnd gnd sky130_fd_pr__nfet_01v8 w=10 l=2 m=2
RD  avdd out 7.7K
CL  out gnd 10p

*vgs in gnd dc 0.9 ac -1
vsup avdd gnd dc 1.8
Vin  in gnd dc 0.9 ac -1 sin(0 1m 1000)

.op
.dc vgs 0 1.8 0.01
.ac dec 20 1 1G
.tran 20u 1n

.control
run
set color0=white
print v(out)
plot v(in) v(out)
plot db20(v(out)/v(in))
plot ph(v(out)/v(in))
.end
.endc
```

### 3.1.2(B) Common Source Amplifier Using Diode Load
<img width="606" height="468" alt="image" src="https://github.com/user-attachments/assets/b753c156-d9a6-414e-9f64-b54845768800" />


***Small Signal Analysis***

<img width="578" height="305" alt="Screenshot 2026-02-02 115616" src="https://github.com/user-attachments/assets/ce3b3df9-e5ca-4977-a1c5-2961b7a3134a" />

- Gain : -gm1 (ron // 1/gm2)
- Rin : infinity
- Rout : 1/gm2


### 3.1.3 (C) Design of CS Amplifier With Current Source Load 

<img width="551" height="405" alt="image" src="https://github.com/user-attachments/assets/4466fa49-a8bb-4a79-bfdd-f58f2ef540e8" />


- Gain : -gm (ro1 // ro2)
- Rout : (ro1 // ro2) which is approx 100kohm
- UGB : gm/2picl  , which is less than 10 mhz.

Using Some Specification We will design the Circuit.\

### DC Analysis :

```
**************** Common Source Amplifier with N-Channel MOSFET and Current Source Load ****************
**************** DC ANALYSIS ****************

.title CS Amplifier with NMOS Driver and PMOS Current Source Load

.lib /home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt

.global gnd vdd
.temp 27

* NMOS driver
xm1 out in gnd gnd sky130_fd_pr__nfet_01v8 w=7 l=2 m=2

* Current source NMOS bias
xm2 Dp2 Gn2 gnd gnd sky130_fd_pr__nfet_01v8 w=7 l=2 m=2

* PMOS load (current mirror)
xmp1 Dp1 Dp2 vdd vdd sky130_fd_pr__pfet_01v8_lvt w=7 l=2 m=6
xmp2 Dp2 Dp2 vdd vdd sky130_fd_pr__pfet_01v8_lvt w=7 l=2 m=6

* Bias voltages
Vcm1 Dp1 out dc 0
Vcm2 Dp2 Dn2 dc 0

* Load capacitance
Cl out gnd 10p

* Supply
vsup vdd gnd dc 1.8

* Input
Vin in gnd dc 0.9 ac 1 sin(0.9 1m 100k)

* Bias for current source
Vbn1 Gn2 gnd dc 0.9

* DC sweep

*.dc Vbn1 0 1.8 0.01
.dc Vin 0 1.8 0.01

.control
run
set color0=white
plot v(out) v(Dp2)
plot i(Vcm1) i(Vcm2)
print abs(v(Dp2))
.endc

.end
```
<img width="502" height="342" alt="image" src="https://github.com/user-attachments/assets/aaaa6685-42ea-415f-807a-c34ff7d98994" />

<img width="502" height="342" alt="image" src="https://github.com/user-attachments/assets/41268990-7d2f-4292-b472-f07b69db4a25" />


### AC Analysis:

```
**************** Common Source Amplifier with N-Channel MOSFET and Current Source Load ****************
**************** AC ANALYSIS ****************

.title CS Amplifier with NMOS Driver and PMOS Current Source Load

.lib /home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt

.global gnd vdd
.temp 27

* NMOS driver
xm1 out in gnd gnd sky130_fd_pr__nfet_01v8 w=7 l=2 m=2

* NMOS current source bias
xm2 Dn2 Gn2 gnd gnd sky130_fd_pr__nfet_01v8 w=7 l=2 m=2

* PMOS current mirror load
xmp1 Dp1 Dp2 vdd vdd sky130_fd_pr__pfet_01v8_lvt w=7 l=2 m=6
xmp2 Dp2 Dp2 vdd vdd sky130_fd_pr__pfet_01v8_lvt w=7 l=2 m=6

* Bias voltages
Vcm1 Dp1 out dc 0
Vcm2 Dp2 Dn2 dc 0

* Load capacitance
Cl out gnd 10p

* Supply voltage
vsup vdd gnd dc 1.8

* Input source (AC small signal = 1)
Vin in gnd dc 0.9 ac 1 sin(0.9 1m 100k)

* Bias for current source
Vbn1 Gn2 gnd dc 0.9

* -------- AC SWEEP --------
.ac dec 20 1 1G

.control
run
set color0=white

plot v(in) abs(v(out)) xlabel 'Frequency' ylabel 'Gain(mag)'
plot abs(v(out))/v(in) xlabel 'Frequency' ylabel 'Gain(mag)'
plot vdb(out) xlabel 'Frequency' ylabel 'Gain(dB)'
plot ph(out)*(180/pi) xlabel 'Frequency' ylabel 'Phase(Deg)'

print vdb(out)

.endc

.end
```
<img width="707" height="543" alt="image" src="https://github.com/user-attachments/assets/71fac3f4-2e87-4a00-bb62-6da0b7cab3a7" />
<img width="702" height="540" alt="image" src="https://github.com/user-attachments/assets/f4457234-bf4d-482f-a5b7-458cddb57a23" />
<img width="702" height="538" alt="image" src="https://github.com/user-attachments/assets/a36fbbe9-e25d-40cc-8714-48db54ff2c6c" />
<img width="703" height="533" alt="image" src="https://github.com/user-attachments/assets/0029b27e-e0d7-42e7-99d1-d8625ae55f4b" />

### Transient Analysis :
```
**************** Common Source Amplifier with N-Channel MOSFET and Current Source Load ****************
**************** TRANSIENT ANALYSIS **********************


.title CS Amplifier with NMOS Driver and PMOS Current Source Load

.lib /home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt

.global gnd vdd
.temp 27

* NMOS driver
xm1 out in gnd gnd sky130_fd_pr__nfet_01v8 w=7 l=2 m=2

* NMOS current source bias
xm2 Dn2 Gn2 gnd gnd sky130_fd_pr__nfet_01v8 w=7 l=2 m=2

* PMOS current mirror load
xmp1 Dp1 Dp2 vdd vdd sky130_fd_pr__pfet_01v8_lvt w=7 l=2 m=6
xmp2 Dp2 Dp2 vdd vdd sky130_fd_pr__pfet_01v8_lvt w=7 l=2 m=6

* Bias voltages
Vcm1 Dp1 out dc 0
Vcm2 Dp2 Dn2 dc 0

* Load capacitance
Cl out gnd 10p

* Supply voltage
vsup vdd gnd dc 1.8

* Input signal
Vin in gnd dc 0.9 ac 1 sin(0.9 1m 10k)

* Bias for current source
Vbn1 Gn2 gnd dc 0.9

* -------- TRANSIENT ANALYSIS --------
.tran 1n 1000u
.control
run
set color0=white
plot v(in)
plot v(out)

.endc

.end
```
<img width="931" height="691" alt="image" src="https://github.com/user-attachments/assets/5de0bfa8-1025-41e3-a88b-088a1187f9a2" />

<img width="931" height="692" alt="image" src="https://github.com/user-attachments/assets/4de0f94b-75eb-4356-a381-b598b71972ed" />


### 3.1.4 (D) CS Amplifier With Source Degenrated Resistor 

<img width="737" height="576" alt="image" src="https://github.com/user-attachments/assets/b0a32fbd-b404-4a63-9e28-3f61de3ccb02" />


- Gm : -gm roRd / ro + Rs + gmroRs + Rd
- Rout : ro // Rd
- UGB : 1/2pi RoutCL , which is 6.30 MHz
- BW : 2.03 MHz

### DC Analysis :

```
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

* Voltage monitor (for current measurement)
Vcm net1 out dc 0

* Load capacitance
Cl out gnd 10p

* Supply voltage
vsup vdd gnd dc 1.8

* Input voltage
Vin in gnd dc 0.85 ac 1 sin(0.9 1m 100k)

* -------- DC SWEEP --------

*.dc Vbn1 0 1.8 0.01
.dc Vin 0 1.8 0.01

.control
run
set color0=white

plot v(out) v(Sn1)
plot i(Vcm)
plot deriv(v(out))
.endc
.end
```
<img width="698" height="535" alt="image" src="https://github.com/user-attachments/assets/7d151686-ef7f-461c-a84b-c9ed3ba89fdc" />

<img width="702" height="540" alt="image" src="https://github.com/user-attachments/assets/8ea55c49-c768-4122-bb58-6a2fea1f06d7" />

<img width="701" height="540" alt="image" src="https://github.com/user-attachments/assets/f879069c-38f7-410e-af16-3ebd8cabf748" />

### AC Analysis :

```
**************** Common Source Amplifier with Resistive Load and Source Degeneration Resistance ****************
**************** AC ANALYSIS *************


.title Source Degenerated CS Amplifier with NMOS Driver and Resistive Load

.lib /home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt

.global gnd vdd
.temp 27

* NMOS transistor
xm1 out in Sn1 gnd sky130_fd_pr__nfet_01v8 w=5 l=2 m=4

* Load and source resistances
Rd vdd net1 8k
Rs Sn1 gnd 0.8k

* Voltage monitor
Vcm net1 out dc 0

* Load capacitance
Cl out gnd 10p

* Supply voltage
vsup vdd gnd dc 1.8

* Input voltage (AC small-signal = 1)
Vin in gnd dc 0.85 ac 1 sin(0.9 1m 100k)

* -------- AC SWEEP --------
.ac dec 10 1 10meg

.control
run
set color0=white

plot abs(v(out))
plot vdb(out)
plot ph(out)*(180/pi)

.endc

.end
```
<img width="692" height="535" alt="image" src="https://github.com/user-attachments/assets/3c5c4750-fbd5-4d1b-9d14-dcb94b924dea" />

<img width="705" height="540" alt="image" src="https://github.com/user-attachments/assets/c8218c06-b57e-43ce-9d97-9f19a5c9e4d2" />

<img width="706" height="541" alt="image" src="https://github.com/user-attachments/assets/a32cdc42-7da5-4b5d-bf16-3ac0c34f32c1" />


ON Using Extra 'RS' Value
```
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
```
<img width="698" height="536" alt="image" src="https://github.com/user-attachments/assets/925408d6-4bdd-4a63-915a-b42693068f3b" />

<img width="698" height="532" alt="image" src="https://github.com/user-attachments/assets/53ec86f8-638a-4f23-a6f5-65106557e163" />

<img width="698" height="535" alt="image" src="https://github.com/user-attachments/assets/379808ab-41f0-4b01-a3fb-ad2ff851dbfa" />


## 3.2 Common Drain or (Source Follower)

<img width="565" height="388" alt="Screenshot 2026-02-02 203032" src="https://github.com/user-attachments/assets/dd3c9037-f65c-4988-b7b1-3ef6f4742477" />

- Rout : 1/gm
- Rin : infinite
- Gain : gm(Rs // ro) / 1 + gm(Rs // ro)

### DC Analysis :
```
******************* Common Drain Amplifier with resistive load *******************
******************* DC ANALYSIS *************************************************



.title Common Drain Amplifier with Resistive Load

.lib "/home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice" tt

.global gnd vdd
.temp 27

xmn1 Dn1 in out gnd sky130_fd_pr__nfet_01v8 w=5 l=2 m=4
Rs  out gnd 5k
*RL  Out Gnd 8
Vcm vdd Dn1 dc 0
Cl  out gnd 10p

vsup vdd gnd dc 1.8
Vin  in gnd dc 1.5 ac 1 sin(1.438 1m 100k)

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
```
<img width="601" height="542" alt="image" src="https://github.com/user-attachments/assets/782e4ed4-1a76-4672-87a5-f349936796e8" />

<img width="601" height="543" alt="image" src="https://github.com/user-attachments/assets/598a53b2-a5e9-4a38-bee7-d5a657ec1543" />

<img width="603" height="543" alt="image" src="https://github.com/user-attachments/assets/7f7ecaeb-b843-4081-888c-542a04c4574a" />

### AC analysis :
```
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
```
<img width="706" height="542" alt="image" src="https://github.com/user-attachments/assets/915dd5a4-c210-464d-b3dd-e7530411876c" />

<img width="706" height="541" alt="image" src="https://github.com/user-attachments/assets/29744b4e-c171-469e-9aca-4ec68f61c674" />

### Transient Analysis:
```
****************** Common Drain Amplifier with resistive load *******************
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
Vin  in gnd dc 1.5 ac 1 sin(1.438 300m 100k)

.tran 10p 100u

.control
run
set color0=white
plot v(in) v(out)
.endc

.end
```
<img width="9905" height="681" alt="image" src="https://github.com/user-attachments/assets/f033a2ba-3a7c-4fbf-bdfc-999f514c12db" />

## Common Drain Using Mosfet Load 
```
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
```
<img width="699" height="537" alt="image" src="https://github.com/user-attachments/assets/b0bdf65d-61de-4a3b-99d4-3284b8a7d6e1" />

<img width="701" height="537" alt="image" src="https://github.com/user-attachments/assets/e38d14ce-a12b-43e6-9365-74a1b4b1522b" />

<img width="699" height="537" alt="image" src="https://github.com/user-attachments/assets/54030d3c-b491-4730-a252-161bb70253c3" />

## 3.3 Common Gate Amplifier 
<img width="572" height="575" alt="image" src="https://github.com/user-attachments/assets/69fa5f31-9eb9-45bc-82b3-634bd335e66a" />




- ro : 200 kohm
- Gm : -(gm + 1/ro)
   - 667micros
- Rout : (ro // Rd)
- Gain : gm (ro // Rd)
   - 5.16


### DC Analysis

```
******************* Common Gate Amplifier with N-Channel MOSFET and Resistive Load *******************


.title CG Amplifier with NMOS Driver and Resistive Load

.lib "/home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice" tt

.global gnd
.temp 27

xmn1 out Gn1 Sn1 gnd sky130_fd_pr__nfet_01v8 w=5 l=2 m=4
Rd  Rt1 out 8k
*Rs  Rt2 gnd 2k
Cl  out gnd 10p
Vcm vdd Rt1 dc 0

vsup vdd gnd dc 1.8
Vgs  Gn1 gnd dc 1.2
Vss  Sn1 Rt2 dc 0 ac 1 sin(0.2 10m 1k)

.dc Vgs 0 1.8 0.01
*.ac dec 10 1 1G
*.tran 20u 1n

.control
run
set color0=white
plot i(Vcm)
plot v(Sn1) v(out)
*plot db(out)
*plot ph((out)*180/pi)
.endc

.end
```
<img width="702" height="541" alt="image" src="https://github.com/user-attachments/assets/609f3a15-82b0-4159-94ed-4780b06740d5" />

<img width="702" height="547" alt="image" src="https://github.com/user-attachments/assets/6a7f9e90-461f-4302-ba98-da3a3b4b2d52" />

### AC Analysis :

```
******************* Common Gate Amplifier with N-Channel MOSFET and Resistive Load *******************

.title CG Amplifier with NMOS Driver and Resistive Load

.lib "/home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice" tt

.global gnd
.temp 27

xmn1 out Gn1 Sn1 gnd sky130_fd_pr__nfet_01v8 w=5 l=2 m=4
Rd  Rt1 out 8k
*Rs Rt2 gnd 2k
Cl  out gnd 10p
Vcm vdd Rt1 dc 0

vsup vdd gnd dc 1.8
Vgs  Gn1 gnd dc 1.08104
Vss  Sn1 gnd dc 0.2 ac 1 sin(0.2 10m 1k)

*.dc Vgs 0 1.8 0.01
.ac dec 10 1 1G
*.tran 20u 1n

.control
run
set color0=white
plot i(Vss) i(Vcm)
plot v(Sn1) v(Rt1) v(out)
plot db(out) db(Sn1)
plot ph(out)*(180/pi)
.endc

.end
```
<img width="698" height="536" alt="image" src="https://github.com/user-attachments/assets/efdf262f-f79b-4478-bf47-7a51fde02d7c" />

<img width="702" height="538" alt="image" src="https://github.com/user-attachments/assets/7812bd9e-2a6f-4c99-b161-f4b264faf328" />

<img width="700" height="532" alt="image" src="https://github.com/user-attachments/assets/b223fd81-091a-45b1-b390-f7f2d8da50b9" />

<img width="702" height="542" alt="image" src="https://github.com/user-attachments/assets/db1c3586-8f48-472a-ae15-f0167b8bb8f4" />

### Transient Analysis 
```
******************* Common Gate Amplifier – Transient Analysis *******************

.title CG Amplifier with NMOS Driver and Resistive Load

.lib "/home/vishalvlsi/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice" tt

.global gnd
.temp 27

xmn1 out Gn1 Sn1 gnd sky130_fd_pr__nfet_01v8 w=5 l=2 m=4
Rd  Rt1 out 8k
Cl  out gnd 10p
Vcm vdd Rt1 dc 0

vsup vdd gnd dc 1.8
Vgs  Gn1 gnd dc 1.0813
Vss  Sn1 gnd sin(0.2 10m 1k)

.tran 1u 10m

.control
run
set color0=white
plot v(Sn1) v(out)
.endc

.end
```
<img width="1841" height="1015" alt="image" src="https://github.com/user-attachments/assets/7ada3da2-231e-4e47-9ab9-dde8c31ced3a" />








## 3.4 Cascode Configuration amplifier (IN Single Stage)

<img width="563" height="498" alt="image" src="https://github.com/user-attachments/assets/ec4a1711-29d8-4a60-a4c2-689b4be67743" />

### Cascode Amplifier Gain Derivation

$$
Gain = - g_m R_{out}
$$

$$
g_m = \frac{I_{sc}}{V_{in}}
$$

$$
R_{out} = \text{Output Resistance}
$$


$$
V_{out} = - i_{out} R_D
$$

$$
i_{out} = - \frac{V_{out}}{R_D}
$$

$$
i_{out} = g_m V_{in} + \frac{V_s}{r_{o1}}
$$


$$
-\frac{V_{out}}{R_D} = g_m V_{in} + \frac{V_s}{r_{o1}}
$$

$$
V_s = V_{out} - ( i_{out} + g_{m2} V_s ) r_{o2}
$$

$$
V_s + g_{m2} r_{o2} V_s = V_{out} - i_{out} r_{o2}
$$

$$
V_s ( 1 + g_{m2} r_{o2} ) = V_{out} - i_{out} r_{o2}
$$

$$
V_s = \frac{V_{out} - i_{out} r_{o2}}{1 + g_{m2} r_{o2}}
$$

$$
V_s = \frac{V_{out} + \frac{V_{out} r_{o2}}{R_D}}{1 + g_{m2} r_{o2}}
$$


$$
V_s = \frac{V_{out} \left( 1 + \frac{r_{o2}}{R_D} \right)}{1 + g_{m2} r_{o2}}
$$


$$
\frac{V_{out}}{V_{in}} = - g_{m1} R_D
\left(
\frac{r_{o1} + g_{m2} r_{o1} r_{o2}}
{R_D + r_{o1} + r_{o2} + g_{m2} r_{o1} r_{o2}}
\right)
$$

$$
V_{out}
\left[
\frac{R_D + r_{o1} + r_{o2} + g_{m2} r_{o1} r_{o2}}
{R_D ( r_{o1} + g_{m2} r_{o1} r_{o2} )}
\right]
= - g_{m1} V_{in}
$$

### Final Voltage Gain (Cascode Amplifier)

$$
A_v = \frac{V_{out}}{V_{in}}
= - g_{m1} R_D
\left(
\frac{r_{o1} + g_{m2} r_{o1} r_{o2}}
{R_D + r_{o1} + r_{o2} + g_{m2} r_{o1} r_{o2}}
\right)
$$

### Advantage of Cascode 
1. Huge output impedance.
2. Gain is High.
3. Good PSRR (Power Supply rejection ratio).


### Disadvantage
1. No of transistor are more.
2. Design is too Complex (Biasing Voltage).
3. Swing (O/P) will be loss.




# Summary of MOSFET Amplifiers

| Amplifier        | $R_{in}$ | $R_{out}$ | Extra |
|-----------------|--------|---------|-------|
| Common Source  | $\infty$ | High | High voltage gain (Voltage amplification) |
| Common Drain   | $\infty$ | Low  | Voltage buffer (Voltage gain $\approx 1$) |
| Common Gate    | Low | High | Current buffer (Current gain $\approx 1$) |




































































  








   







  
