`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/19/2025 12:49:58 PM
// Design Name: 
// Module Name: vga_640X400
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


module vga_640X400 #(

parameter V_Sync_pulse = 520,
parameter V_Display_time = 480,
parameter V_Pulse_width = 2,
parameter V_Front_porch = 10,
parameter V_Back_porch = 29,

parameter H_Sync_pulse = 799,
parameter H_Display_time = 640,
parameter H_Pulse_width = 96,
parameter H_Front_porch = 16,
parameter H_Back_porch = 48

)(
    input clk,
    input rst_n,
    output reg [1:0]r_clk25Mhz,
    output pixel_clk,
    output h_sync,
    output v_sync,
    output reg [9:0] h_counter,
    output reg [9:0] v_counter,
    output display_surface,
    output v_area_in,
    output v_area_out,
    output h_area_in,
    output h_area_out
 );

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        r_clk25Mhz <= 0;
    end
    else begin
    r_clk25Mhz <= r_clk25Mhz + 1;
    end    
end

assign pixel_clk = (r_clk25Mhz == 0) ? 1 : 0;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        h_counter <= 0;
    end
    else if (h_counter == H_Sync_pulse) begin
        h_counter <= 0;
    end
    else begin
        h_counter <= h_counter + 1;
    end
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        v_counter <= 0;
    end
    else if(h_counter == H_Sync_pulse) begin
            if (v_counter == V_Sync_pulse) begin
                v_counter <= 0;
            end
            else begin 
                v_counter <= v_counter + 1;
            end
    end
end

assign h_sync = (h_counter >= H_Display_time + H_Front_porch) && (h_counter < H_Display_time + H_Front_porch + H_Pulse_width);
assign v_sync = (v_counter >= V_Display_time + V_Front_porch) && (v_counter < V_Display_time + V_Front_porch + V_Pulse_width);

assign display_surface = (h_counter < H_Display_time) && (v_counter < V_Display_time);

assign v_area_in = (v_counter < V_Display_time);
assign v_area_out = (v_counter >= V_Display_time);

assign h_area_in = (h_counter < H_Display_time );
assign h_area_out = (h_counter >= H_Display_time);

endmodule
