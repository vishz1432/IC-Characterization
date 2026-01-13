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








   







  
