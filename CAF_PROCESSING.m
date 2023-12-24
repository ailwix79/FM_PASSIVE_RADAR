% CAF PROCESSING
% CAF Calculation based on cross correlation and Doppler brute forcing
clear all; clc; close all;

% RADAR parameters
T = 1;

% File load and time axis creation
A = 1;
[s,Fs] = audioread('tones.wav');
x = A*s(:,1);
x = x(1:Fs*T);
N = length(x);
t = linspace(0,T,length(x))';

% FM modulation
Fm = 20e3;
Fc = 100e6;
freqdev = 75e3;
B = 2*(Fm+freqdev);
beta = freqdev/Fm;
modulating_signal = sin(2*pi*Fm*t);
x_ref = sin(2*pi*(Fc+freqdev.*modulating_signal.*x).*t);

% Delay and Doppler declaration
delay = round(N*rand);
doppler = 600*rand;

% Add delay to eco signal
x_eco = [zeros(delay,1) ; x_ref];
x_eco = x_eco(1:N,:);
x_eco = x_eco.*exp(1j*2*pi*doppler*t);

% Cross ambiguity function
L = 2;
lfft = 2^nextpow2(L*N);
range_bins = (1:N)/Fs;
freq_bins = 1:600;
CAF = zeros(N,600);
w = chebwin(N);

for b=1:600
    corr_range = ifft(fft(x_eco).*conj(fft(x_ref.*exp(1j*2*pi*b*t))));
    CAF(:,b) = corr_range(1:N);
end

figure;
a1 = axes();
surf(a1,freq_bins,range_bins,20*log10(abs(CAF)));
ylabel(a1,'Delay (s)','Interpreter','Latex')
xlabel(a1,'Doppler shift (Hz)','Interpreter','Latex')
zlabel(a1,'Power Level (dB)','Interpreter','Latex')
title(a1,['Doppler = ',num2str(doppler),' Hz, Delay = ',num2str(delay/Fs),' s, T = ',num2str(T),' s'],'Interpreter','Latex')
shading interp
colormap jet
