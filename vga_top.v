`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/19/2025 02:30:53 PM
// Design Name: 
// Module Name: vga_top
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


module vga_top(
    input clk,                  //clock
    input rst,                  //reset
    output reg [3:0] vgaRed,    //Red 
    output reg [3:0] vgaBlue,   //Blue
    output reg [3:0] vgaGreen,  //Green
    output Hsync,               //Hsync
    output Vsync                //Vsync
    );

wire clk_25mhz;

design_1_wrapper clk_25Mhz      //clocking wizard 100Mhz -> 25Mhz
   (
    .clk_in1_0 (clk),
    .clk_out1_0 (clk_25mhz),    
    .reset_0(rst)
    );

    wire display_on;            // represent display zone (640X480)
    wire rst_n = ~rst;          // negedge rst

    wire [9:0] h_count_wire;
    wire [9:0] v_count_wire;

    wire h_sync_n;
    wire v_sync_n;

    assign Hsync = ~h_sync_n;   // negative hsync
    assign Vsync = ~v_sync_n;   // negative vsync  

    vga_640X400 vga_inst(
        .clk(clk_25mhz),
        .rst_n(rst_n),
        .h_counter(h_count_wire),
        .v_counter(v_count_wire),
        .h_sync(h_sync_n),
        .v_sync(v_sync_n),
        .display_surface(display_on)
    );

    //we divide the screen into a 3X4 matrix

    parameter H_div = 160;      
    parameter V_div = 160;

    //radius circle

    parameter Circle_radius = 50;
    parameter Circle_radius_square = Circle_radius * Circle_radius;

    //

    parameter H_div_into_3 = H_div / 3;

    wire signed [9:0] x;
    wire signed [9:0] y;

    // intervals foe every section

    assign x = h_count_wire % H_div;
    assign y = v_count_wire % V_div;

    wire signed [9:0] x_minus_a;
    wire signed [9:0] y_minus_b;

    //                       ^ -y
    //                       |
    //                       |
    //               -x  --------- x
    //                       |
    //                       | y

    assign x_minus_a = x - (H_div / 2);
    assign y_minus_b = y - (V_div / 2);

    // Circle formula

    wire circle;

    // circle center coordonates (0,0)

    assign circle = ((x_minus_a * x_minus_a) + (y_minus_b * y_minus_b)) <= Circle_radius_square;

    wire v1;
    wire v2;
    wire v3;                                                        
                                                        
    assign v1 = (v_count_wire < V_div);                     
    assign v2 = (v_count_wire < V_div * 2);                 
    assign v3 = (v_count_wire < V_div * 3);                 
                                                            
    wire h1;                                                
    wire h2;                                                
    wire h3;                                                
    wire h4;                                                

    assign h1 = (h_count_wire < H_div);
    assign h2 = (h_count_wire < H_div * 2);
    assign h3 = (h_count_wire < H_div * 3);
    assign h4 = (h_count_wire < H_div * 4);

    //  circle center coordonates (-25,0)

    wire displaced_circle;

    assign displaced_circle = ( ((x_minus_a + 25) * (x_minus_a + 25)) + (y_minus_b * y_minus_b) ) <= Circle_radius_square;

    // square

    wire square_x;
    wire square_y;
    wire square;

    assign square_x = (x_minus_a > -60 && x_minus_a < 60);
    assign square_y = (y_minus_b > -60 && y_minus_b < 60);
    assign square = square_x && square_y;

    //rectangle

    wire rectangle_x;
    wire rectangle_y;
    wire rectangle;

    assign rectangle_x = (x_minus_a > -80 && x_minus_a < 80);
    assign rectangle_y = (y_minus_b > -40 && y_minus_b < 40);
    assign rectangle = rectangle_x && rectangle_y;

    //        | -y
    //   -x ----- +x
    //        |
    //       /|\    |1| > 0
    //      / | \   |2| > 1
    //     /  |  \  |3| > 2 etc

    wire signed [9:0] modulo_x;
    wire triangle;

    assign modulo_x = (x_minus_a[9]) ? -x_minus_a : x_minus_a;
    assign triangle = (y_minus_b > modulo_x) && (y_minus_b < 70);

    reg [3:0] vgaRed_next;
    reg [3:0] vgaGreen_next;
    reg [3:0] vgaBlue_next;

    always @(*) begin

        vgaRed_next = 4'b0000;
        vgaGreen_next = 4'b0000;
        vgaBlue_next = 4'b0000;

        if (display_on) begin
            
            if (v1) begin
                if (circle) begin
                    vgaRed_next = 4'b1111;
                end
            end

            else if (v2) begin
                if (h1) begin
                    if (circle && x_minus_a >= 0) begin
                    vgaRed_next = 4'b1111;
                    end
                end
                else if (h2) begin
                    if(circle && !displaced_circle) begin
                        vgaRed_next = 4'b1111;
                    end
                end
                else if(h3) begin 
                    if(x < H_div_into_3) begin
                        vgaRed_next = 4'b1111;
                    end
                    else if(x < H_div_into_3 * 2) begin
                        vgaBlue_next = 4'b1111;
                    end
                    else begin
                        vgaGreen_next = 4'b1111;
                    end
                end
                else begin
                    if(x < H_div_into_3) begin
                        vgaRed_next = 4'b1111;
                        vgaBlue_next = 4'b1111;
                    end
                    else if(x < H_div_into_3 * 2) begin
                        vgaBlue_next = 4'b1111;
                        vgaGreen_next = 4'b1111;
                    end
                    else begin
                        vgaGreen_next = 4'b1111;
                        vgaRed_next = 4'b1111;
                    end
                end
            end

            else begin
                if(h1) begin
                    if (circle) begin
                        vgaRed_next = 4'b1111;
                    end
                end 
                else if (h2) begin
                    if (square) begin
                        vgaRed_next = 4'b1111;
                    end
                end
                else if (h3) begin
                    if(rectangle) begin
                        vgaRed_next = 4'b1111;
                    end
                end
                else begin
                    if(triangle) begin
                        vgaRed_next = 4'b1111;
                    end
                end
            end
        end

    end

    always @(posedge clk_25mhz or negedge rst_n) begin
        if (!rst_n) begin
            vgaRed <= 4'b0000;
            vgaGreen <= 4'b0000;
            vgaBlue <= 4'b0000;
        end else begin
            vgaRed <= vgaRed_next;
            vgaGreen <= vgaGreen_next;
            vgaBlue <= vgaBlue_next;
        end
    end

endmodule
