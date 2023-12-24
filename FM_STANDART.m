% FM Stereo Standart modulation
clear all; clc; close all;
[x,fs] = audioread('tones.wav');

N = size(x,1);
T = N/fs;
t = linspace(0,T,N).';
f = -fs/2:fs/N:fs/2-fs/N;
f_cut = 5e3;
A = 2;

x_sum = lowpass(x(:,1) + x(:,2),f_cut,fs);
x_dif = lowpass(x(:,1) - x(:,2),f_cut,fs); 

s = x_sum.*exp(1j*2*pi*1e4*t);

figure;
plot(f,20*log10(abs(fftshift(fft(s)))));
grid on;