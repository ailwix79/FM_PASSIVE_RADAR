% MEDIDAS SEÑAL FM
clear all;

A = 1e5;
[s,Fs] = audioread('tones.wav');
x = A*s(:,1);
T = length(x)/Fs;
t = linspace(0,T,length(x))';

Fm = 20e3;
Fc = 100e6;
freqdev = 75e3;
B = 2*(Fm+freqdev);
beta = freqdev/Fm;
modulating_signal = sin(2*pi*Fm*t);
xmod = sin(2*pi*(Fc+freqdev.*modulating_signal.*x).*t);

PRF = 1/T;
[afmagdel,doppler] = ambgfun(xmod,Fs,PRF,"Cut","Doppler");
[afmagdop,delay] = ambgfun(xmod,Fs,PRF,"Cut","Delay");

range_resolution = (3e8/B)*1e-3;
velocity_resolution = (3e8/(Fc*T))*3.6;

figure;
sgtitle("FM signal ambiguity function analysis")
subplot(2,1,1)
plot(delay,20*log10(afmagdel),'r')
yline(-1*10*log10(B*T))
ylim([-120 10])
grid on;
title("Delay")
xlabel("Delay (seconds)")
ylabel("Normalised Power level (dB)")

subplot(2,1,2)
plot(doppler,20*log10(afmagdop),'b')
yline(-1*10*log10(B*T))
ylim([-120 10])
grid on;
title("Doppler shift")
xlabel("Doppler frequency (Hz)")
ylabel("Normalised Power level (dB)")