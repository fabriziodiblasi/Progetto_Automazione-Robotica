clc();
clear();

%Parametri legge oraria
p_0 = 0.0; %posizione iniziale
p_f = 10.0; %posizione finale
v_0 = 0.0; %velocità iniziale
v_f = 0.0; %velocità finale
a_max = 1.0; %accelerazione massima
tempo = 10.0; %tempo di esecuzione

%generazione legge
%[p,F] = polinomiale_3(tempo,[p_0,v_0,p_f,v_f]);
%[p,F] = parabolica(tempo,[p_0,v_0,p_f,v_f]);
%[p,F] = cicloidale(tempo,[p_0,p_f]);
[p,F] = trapezoidale_mod([tempo/7,tempo/7,tempo/7,tempo/7,tempo/7,tempo/7,tempo/7],[p_0,v_0,a_max]);

%plot
subplot(4,1,1)
plot(p,F(1,:))
xlabel("Tempo[s]")
ylabel("Posizione[m]")
subplot(4,1,2)
plot(p,F(2,:))
xlabel("Tempo[s]")
ylabel("Velocità[m/s]")
subplot(4,1,3)
plot(p,F(3,:))
xlabel("Tempo[s]")
ylabel("Accelerazione[m/s^2]")
subplot(4,1,4)
plot(p,F(4,:))
xlabel("Tempo[s]")
ylabel("Jerk[m/s^3]")