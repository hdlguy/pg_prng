`timescale 1ns / 1ps

module lfsr_tb ();

    localparam int Nsim = 1000000;
    localparam W  = 18;
    localparam W0 = W-0;
    localparam W1 = W-1;
    localparam W2 = W-2;

    logic [W0-1:0] din0=1, dout0=1;
    logic [W1-1:0] din1=1, dout1=1;
    logic [W2-1:0] din2=1, dout2=1;
    
    logic clk = 0; localparam clk_period = 10; always #(clk_period/2) clk = ~clk;

    lfsr #(.WIDTH(W0)) lfsr0 (.datain(din0), .dataout(dout0));
    lfsr #(.WIDTH(W1)) lfsr1 (.datain(din1), .dataout(dout1));
    lfsr #(.WIDTH(W2)) lfsr2 (.datain(din2), .dataout(dout2));

    int count = 0;
    logic signed [W-1:0] dout=0;
    always_ff @(posedge clk) begin
        din0 <= dout0;
        din1 <= dout1;
        din2 <= dout2;
        count <= count + 1;
        dout <= $signed(din0[W0-1:1]) + $signed(din1[0 +: W1]) + $signed(din2[0 +: W2]);
        $fwrite(fd, dout);
        $fwrite(fd, ", ");
    end


    integer fd;
    initial begin
        fd = $fopen("../../../../lfsr_dout.txt", "w");
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

