`timescale 1ns / 1ps

module lfsr_tb ();

    localparam int Nsim = 100000;
    localparam int   W0 = 18; // up to 18x25 fits in a single DSP48
    localparam int   W1 = 25;
    localparam int   Wout = 32;
    localparam int   Init0_0 = 2;
    localparam int   Init1_0 = 1;   
    localparam int   Init0_1 = 3;
    localparam int   Init1_1 = 2;   

    logic[31:0] dout_0, dout_1;
    logic clk = 0; localparam clk_period = 10; always #(clk_period/2) clk = ~clk;

    prng #(.W0(W0), .W1(W1), .Wout(Wout), .Init0(Init0_0), .Init1(Init1_0)) uut0 (.clk(clk), .dout(dout_0));
    prng #(.W0(W0), .W1(W1), .Wout(Wout), .Init0(Init0_1), .Init1(Init1_1)) uut1 (.clk(clk), .dout(dout_1));

    int count = 0;
    always_ff @(posedge clk) begin
        count <= count + 1;
        $fwrite(fd, dout_0);
        $fwrite(fd, ", ");
        $fwrite(fd, dout_1);
        $fwrite(fd, "\n");
    end

    integer fd;
    initial begin
        fd = $fopen("../../../../prng_dout.txt", "w");
    end
        
    always_comb begin
        if (count == Nsim) begin
            $fclose(fd);
            $stop();
        end
    end

endmodule


/*
*/

