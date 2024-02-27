`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2024 08:48:53 AM
// Design Name: 
// Module Name: Register_file
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

//module N_bit_register #(parameter N = 32)(
//    input load,
//    input clk,
//    input rst,
//    input [N-1:0] D,
//    output [N-1:0] Q
//    );
    
module Register_file(
    input clk,
    input rst,
    input [4:0] read_reg_1_indx,
    input [4:0] read_reg_2_indx,
    input [4:0] write_reg_indx,
    input [31:0] write_data,
    input reg_write, // if 1, write_data into write_reg_indx
    output [31:0] read_reg_1_data,
    output [31:0] read_reg_2_data
);

    // Instantiate 32 N-bit registers and put them inside an array of 32 elements
    reg [31:0] registers[31:0];
    
    // Initialize registers to 0 on reset
    integer i;
    
    always @(posedge rst) begin
        for (i = 0; i < 32; i = i + 1) begin
            registers[i] <= 0;
        end
    end
    
    // Handle write operation on the positive edge of the clock
    always @(posedge clk) begin
        if (reg_write) begin
            // Write write_data into register at write_reg_indx
            // Ensure that register 0 is not writable (common in many architectures)
            //if (write_reg_indx != 0) begin
                registers[write_reg_indx] <= write_data;
            //end
        end
    end
    
    // Assign read_reg_1_data and read_reg_2_data to the register of index read_reg_1_indx and read_reg_2_indx
    // These are combinational logic, directly mapping the outputs to the register array
    assign read_reg_1_data = (read_reg_1_indx == 0) ? 0 : registers[read_reg_1_indx];
    assign read_reg_2_data = (read_reg_2_indx == 0) ? 0 : registers[read_reg_2_indx];

endmodule
