clear; 

% data from verilog simulation
s=load("-ascii", "prng_dout.txt"); 
N = length(s);
s=s/(2^31)-1;       % normalize
x=conv(s, flip(s)); % autocorrelation

% 'rand' uses the Mersenne Twister with a period of 2^{19937}-1
s2=2*rand(1,N)-1;    % normalize
x2=conv(s, flip(s)); % autocorrelation


subplot(4,1,1);
plot(x, 'r*-');
title("autocorrelation of Verilog simulation");
subplot(4,1,2);
hist(s, 100);
title("historgram of Verilog simulation");

subplot(4,1,3);
plot(x2, 'r*-');
title("autocorrelation of Octave rand()");
subplot(4,1,4);
hist(s2, 100);
title("historgram of Octave rand()");

