`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/19/2025 01:52:24 PM
// Design Name: 
// Module Name: vga_test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module vga_test(
    );
parameter V_Sync_pulse = 520;
parameter V_Display_time = 480;
parameter V_Pulse_width = 2;
parameter V_Front_porch = 10;
parameter V_Back_porch = 29;

parameter H_Sync_pulse = 799;
parameter H_Display_time = 640;
parameter H_Pulse_width = 96;
parameter H_Front_porch = 16;
parameter H_Back_porch = 48;

reg clk;
reg rst_n;

wire [9:0] h_counter;
wire [9:0] v_counter;
wire [1:0] r_clk25Mhz;
wire pixel_clk;

wire display_surface;

wire h_sync;
wire v_sync;

wire v_area_in;
wire v_area_out;
wire h_area_in;
wire h_area_out;

vga_640X400 #(
    .H_Sync_pulse(6),
    .H_Display_time(3),
    .H_Pulse_width(2),
    .H_Front_porch(1),
    .H_Back_porch(1),

    .V_Sync_pulse(7),
    .V_Display_time(4),
    .V_Pulse_width(2),
    .V_Front_porch(1),
    .V_Back_porch(1)
)
uut(
    .clk(clk),
    .rst_n(rst_n),
    .h_counter(h_counter),
    .v_counter(v_counter),
    .r_clk25Mhz(r_clk25Mhz),
    .pixel_clk(pixel_clk),
    .display_surface(display_surface),
    .v_sync(v_sync),
    .v_area_in(v_area_in),
    .v_area_out(v_area_out),
    .h_sync(h_sync),
    .h_area_in(h_area_in),
    .h_area_out(h_area_out)
);

initial begin
    clk = 0;
    rst_n = 1;
    #10
    rst_n = 0;
    #20
    rst_n = 1;
end

always #5 clk = ~clk;

endmodule
