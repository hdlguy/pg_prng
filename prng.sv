// a simple fast prng with good statistics
module prng #(
    parameter int   W0 = 18, // up to 18x25 fits in a single DSP48
    parameter int   W1 = 25,
    parameter int   Wout = 32,
    parameter int   Init0 = 1,
    parameter int   Init1 = 1    
) (
    input   logic               clk,
    output  logic[Wout-1:0]     dout
);
    
    logic [W0-1:0] din0 = Init0, dout0;
    logic [W1-1:0] din1 = Init1, dout1;
    
    lfsr #(.WIDTH(W0)) lfsr0 (.datain(din0), .dataout(dout0));
    lfsr #(.WIDTH(W1)) lfsr1 (.datain(din1), .dataout(dout1));

    logic signed [W0+W1-1:0] prod;
    assign prod = $signed(din0) * $signed(din1); // DSP48 multiplier

    logic signed [47:0] acc=0;
    always_ff @(posedge clk) begin
        din0 <= dout0;
        din1 <= dout1;
        acc <= $signed(prod);
    end

    logic[Wout-1:0] dout;
    assign dout = acc[Wout-1:0];

endmodule


/*
*/

