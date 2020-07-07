////////////////////////////////////////////////////////////////////////////////////////////////////
// Design Name: Baud Rate Generator
// Engineer: kiran
// Refence: counter = (clk/baud rate) => (100Mhz/BR)
////////////////////////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps

module baud_rate(clk, rst, baud_clk);

    input  wire clk;
    input  wire rst;
    output reg  baud_clk;
    
    reg [13:0] count;
    
//    reg [13:0] br = 14'h28b4;            //9600
    reg [13:0] br = 14'h37F;           //115200

    always@(posedge clk or posedge rst)
        begin
            if(rst) begin
                count = 0;    
            end else begin
                if(count == br)
                    count = 0;
                else
                    count = count + 1;
            end
        end
    
    always@(posedge clk)
        begin
            if(count < br/2) 
                baud_clk <= 0;
            else
                baud_clk <= 1;
        end
     
endmodule
