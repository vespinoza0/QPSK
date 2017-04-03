clear all

n_bit=1e6;                  % number of bits
s=randi([0 1],n_bit,1);
%s_bipolar = s*2-1;          % change binary sequence to -1 and +1
Is= s(1:2:end);   %makes I data first bit & skips 
Qs= s(2:2:end);   %makes Q data second bit & skips
IsPolar = Is*2-1;   %makes I data first bit & skips 
QsPolar = Qs*2-1;   %makes Q data second bit & skips
s_bipolar = IsPolar + QsPolar; %qpsk 
%noise = randn(n_bit,1)*sqrt(0.5); %Gaussian noise with variance 0.5 
EbN0_dB = 1:1:10;

for i = 1:1:10;         % EbN0_dB = i
   EbN0 = 10.^(i/10);     % Eb/N0 in linear scale 
    %%s_bipolar = s*2-1;          % change binary sequence to -1 and +1
    noise = randn(n_bit,1)*sqrt(0.5); %Gaussian noise with variance 0.5 
    %(note: sigma^2=N0/2)
    x = s_bipolar * sqrt(EbN0) + noise; % noisy signal received at receiver 
    s_est = (x>0);              % make binary decision 
    err_bits = sum(abs(s_est-s)); % compute the number of error bits
    ber = err_bits/n_bit;        % simulated BER     
    ber_theo = qfunc(sqrt(2*EbN0)); % BER computed from theoretical expression
    %disp(ber_theo)
    %disp(ber)
    j = i*10;
    berVector(i) = ber;
    theoVector(i) = ber_theo;
    EbN0_dBVector = 0;
end 

semilogy (EbN0_dB,berVector,EbN0_dB,theoVector) 