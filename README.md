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
- 






  
