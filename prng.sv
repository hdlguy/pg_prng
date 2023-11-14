// a simple fast prng with good statistics
module prng (
    input   logic       clk,
    output  logic[31:0] dout
);

    localparam int W0 = 18;
    localparam int W1 = 25;
    localparam int Wout = 32;

    logic [W0-1:0] din0=1, dout0;
    logic [W1-1:0] din1=1, dout1;
    
    lfsr #(.WIDTH(W0)) lfsr0 (.datain(din0), .dataout(dout0));
    lfsr #(.WIDTH(W1)) lfsr1 (.datain(din1), .dataout(dout1));

    logic signed [W0+W1-1:0] prod;
    assign prod = $signed(din0) * $signed(din1); // use 18x25 DSP48 multiplier

    int count = 0;
    logic signed [47:0] acc=0;
    always_ff @(posedge clk) begin
        din0 <= dout0;
        din1 <= dout1;
        count <= count + 1;
        acc <= $signed(prod);
    end

    logic[Wout-1:0] dout;
    assign dout = acc[Wout-1:0];

endmodule


/*
*/

