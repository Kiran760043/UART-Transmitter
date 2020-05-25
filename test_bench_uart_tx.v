////////////////////////////////////////////////////////////////////////////////////////////////////
// Design Name: UART Transmitter protocol
// Engineer: kiran
// Note: For simulation purposes Baudrate is not used for Transmission
////////////////////////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps


module test_bench_uart_tx();

    //inputs for DUT
        reg clk;
        reg rst;
    //outputs from DUT
        wire busy;
        wire Tx;
        
//        wire b_clk;
        
//        baud_rate BR  (.clk(clk), .rst(rst), .baud_clk(b_clk));
        
        uart_tx   DUT (.clk(clk),.rst(rst),.busy(busy),.Dout(Tx));
        
        always #5 clk = ~clk;
        
        initial 
            begin
                clk = 0;
                rst = 1;
                #20;
                rst = 0;
                #110;
                $finish;
            end


endmodule
