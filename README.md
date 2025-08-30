VGA Test Pattern Generator in Verilog for Basys 3

📝 General Description

This project demonstrates how to generate a static test pattern for a VGA display using a Digilent Basys 3 FPGA board. The project is written in Verilog and produces a video signal at a 640x480 pixel resolution.

The goal is to display an image composed of various geometric shapes and color bars to test and validate the functionality of a VGA controller. The generated image is divided into a 4x3 grid, with each cell containing a distinct graphic element.

🖼️ Output Image

The image below shows the exact output this project produces on a monitor connected to the Basys 3 board.

(Here you can insert a screenshot of your VGA output)

✨ Main Features

640x480 VGA Controller: Generates Hsync and Vsync signals for the 640x480 @ 60Hz resolution standard.

Static Image: The project displays a fixed image, which is ideal for testing colors and geometry.

Test Matrix: The screen is divided into a 4-column, 3-row grid to organize the test elements.

Geometric Shapes: Procedurally draws various shapes, including:

Circles

A crescent moon (achieved by overlapping two circles)

A semicircle

A square

A rectangle

A triangle

Color Bars: Generates primary (Red, Green, Blue) and secondary (Cyan, Magenta, Yellow) color bars to test the display's color gamut.

📁 Project Structure

The project is composed of the following key files:

1. vga_top.v
This is the top-level module that integrates the entire design.

Instantiates a Clocking Wizard to generate the 25 MHz clock required for 640x480 VGA timing.

Instantiates the vga_640X400 controller to get the synchronization signals.

Contains the logic to draw each shape and color bar based on the current pixel coordinates (h_count_wire, v_count_wire).

2. vga_640X400.v
This sub-module is responsible exclusively for generating the VGA timings.

Implements counters to generate the horizontal and vertical sync pulses.

Defines parameters for the front porch, back porch, and pulse width according to the 640x480 standard.

3. Basys3_Master.xdc
This is the essential constraints file that maps the ports from vga_top.v to the physical pins of the Basys 3 board.

Assigns the input clock to pin W5.

Assigns the reset button to pin U18.

Assigns the color (vgaRed, vgaGreen, vgaBlue) and sync (Hsync, Vsync) outputs to the VGA connector pins.

4. vga_test.v
A simulation module (testbench) used to verify the functionality of the vga_640X400 module in a Verilog simulator before implementing on hardware.

🛠️ Requirements
Required Hardware
A Digilent Basys 3 development board

A monitor with a VGA input

A VGA Cable

Required Software
Xilinx Vivado Design Suite

Un cablu VGA

Software Necesar
Xilinx Vivado Design Suite: Proiectul utilizează un fișier de constrângeri (.xdc) și un IP de ceas (Clocking Wizard), specifice acestui software.           
![img3](https://github.com/user-attachments/assets/e10b2e94-e924-4287-90c9-dbaaa807ef73)

Simulation:
<img width="1275" height="678" alt="image" src="https://github.com/user-attachments/assets/07640a6c-7cae-4610-8f4b-e868492ead0e" />

