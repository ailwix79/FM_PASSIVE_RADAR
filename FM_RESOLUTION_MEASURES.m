% RESOLUTION MEASURES
B = 10e3:1e3:1e6;
T = 0.01:0.01:1;
Fc = linspace(88e6,108e6,3);

figure;
plot(B*1e-3,(3e8./B)*1e-3)
grid on
xlabel("Bandwidth (kHz)")
ylabel("Range Resolution (Km)")
title("Range Resolution vs Bandwidth")

figure;
hold on;
plot(T*1e3,(3e8./(Fc(1).*T)).*3.6)
plot(T*1e3,(3e8./(Fc(2).*T)).*3.6)
plot(T*1e3,(3e8./(Fc(3).*T)).*3.6)
grid on
ylim([0 200])
xlabel("Integration Time (ms)")
ylabel("Velocity Resolution (Km/h)")
title("Speed Resolution vs Integration Time")
legend(num2str(Fc(1)*1e-6),num2str(Fc(2)*1e-6),num2str(Fc(3)*1e-6))