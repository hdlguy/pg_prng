`timescale 1ns / 1ps

module lfsr_tb ();

    localparam int Nsim = 100000;
    localparam int   W0 = 18; // up to 18x25 fits in a single DSP48
    localparam int   W1 = 25;
    localparam int   Wout = 32;
    localparam int   Init0 = 2;
    localparam int   Init1 = 1;   

    logic[31:0] dout;
    logic clk = 0; localparam clk_period = 10; always #(clk_period/2) clk = ~clk;

    prng #(.W0(W0), .W1(W1), .Wout(Wout), .Init0(Init0), .Init1(Init1)) uut(.*);

    int count = 0;
    logic signed [47:0] acc=0;
    always_ff @(posedge clk) begin
        count <= count + 1;
        $fwrite(fd, dout);
        $fwrite(fd, ", ");
    end

    logic[31:0] dout;
    assign dout = acc[31:0];


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

