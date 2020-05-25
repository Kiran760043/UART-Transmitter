////////////////////////////////////////////////////////////////////////////////////////////////////
// Design Name: UART Transmitter protocol
// Engineer: kiran
////////////////////////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps


module uart_tx(clk,rst,busy,Dout);

    input  wire clk;
    input  wire rst;
    
    output reg busy;
    output reg Dout;
    
    reg [0:6]data = 7'b1110001;
    
    reg evenodd = 1'b0;
    wire parity;
    
    
    localparam idle  = 2'h0,
               start = 2'h1,
               trans = 2'h2,
               stop  = 2'h3;
               
    reg [1:0]state;
    reg [1:0]nxt_state;
    
    reg [7:0]dval;
    reg [3:0]count;
    reg trig;
    
    assign parity = (^data) ^ evenodd;              //parity generator
    
    always@(posedge clk,posedge rst)
        begin
            if (rst) begin
                state <= idle;
            end else begin
                state <= nxt_state;
            end
        end
    
    always@(posedge clk, posedge rst)
        begin
            if (rst) begin
                count <= 0;
            end else begin
                if(trig) begin
                    count <= count + 1;
                end else 
                    count <= 0;
            end
        end
        
     always@(data,parity,count,state)
        begin
            busy      <= 0;
            trig      <= 0;
            dval      <= {parity,data[0:6]};
            nxt_state <= state;
            case(state)
                idle :  begin
                            Dout      <= 1;
                            nxt_state <= start; 
                        end
                start:  begin
                            Dout      <= 0;
                            busy      <= 1;
                            nxt_state <= trans;
                        end
                trans:  begin
                            Dout      <= dval[count];
                            busy      <= 1;
                            if (count == 7) begin
                                trig <= 0;
                                nxt_state <= stop;
                            end else begin
                                trig <= 1;
                                nxt_state <= trans;
                            end                          
                        end
                stop :  begin
                            Dout      <= 1;
                            busy      <= 0;
                            nxt_state <= idle;
                        end
            endcase
        end
endmodule
