%manipolatore seriale con 6 giunti rotoidali
clear();
clc();

%parametri DH del puma 560
%? pi/2 0 ? ? ? 2 ? ? 2 ? ? ? 2  0   alpha
%? 0 0.4323 0 0 0 0
%? 0 0 0 0 0 0
%? 0 0 0.1501 0.4331 0 0

alpha = [pi/2, 0.0, -pi/2, pi/2, -pi/2, 0.0 ];
a = [0.0, 0.4323, 0.0,  0.0,  0.0,  0.0];
theta = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
d = [0.0,  0.0,  0.1501,  0.4331,  0.0,  0.0];

m =[0, 17.4, 4.8, 0.82, 0.34,0.09];

r_x =[0, -0.3638, -0.0203, 0, 0, 0];
r_y=[0, 0.0060 ,-0.0141, 0.0190, 0, 0];
r_z=[0, 0.2275, 0.0700, 0, 0, 0.0320];

I_xx=[0, 0.1300, 0.0660, 0.0018, 0.0003, 0.00015];
I_yy=[0.3500, 0.5240, 0.0860, 0.0013, 0.0004, 0.00015];
I_zz=[0, 0.5390, 0.0125, 0.0018, 0.0003, 0.00004];


puma560_model = load_puma560_model();

% X = 4
% %q(1) = [0 0 0 0 0 0]
% q_1 = [0,0,0,0,0,0];
% %q(2) = [0 0 ? ?/? 0 0 0]
% q_2 = [0,0,-pi/4,0,0,0];
% %q(3) = [0 ?/? ? ? 0 0 0]
% q_3 = [0,pi/4,-pi,0,0,0];
% %q(4) = [0 ?/4 ? ? 0 ?/? 0]
% q_4 = [0,pi/4,-pi,0,pi/4,0];
% %q(5) = [0 0 ? ?/2 ?/6 0 ? ?/?]
% q_5 = [0,0,-pi/2,pi/6,0,-pi/4];
% %q(6) = [0 ? ?/? 0 0 ? ?/4 0]
% q_6 = [0,-pi/4,0,0,-pi/4,0];


Q= [ 0,0,0,0,0,0;...
     0,0,-pi/4,0,0,0;...
     0,pi/4,-pi,0,0,0;...
     0,pi/4,-pi,0,pi/4,0;...
     0,0,-pi/2,pi/6,0,-pi/4;...
     0,-pi/4,0,0,-pi/4,0];


%cinematica diretta tramite CORKE e calcolata manualmente
for row=1:6
    for col=1:6
        A = calcolo_matrice_trasformazione(alpha(col), Q(row,col), d(col), a(col));
        if col == 1
            T = A;
        elseif col>1
            T = T * A;
        end
    end
    T %matrice calcolata manualmente sostituendo i vettori di giunto al posto del parametro theta
    fkine(puma560_model, Q(row,:)) %matrici della cinematica diretta calcolate con il toolbox di corke
end

%PIANIFICAZIONE DELLA TRAIETTORIA CON PROFILO DI VELOCITA' TRAPEZOIDALE
% ORIENTAMENTI DEFINITI SECONDO LA CONVENZIONE RPY

p_i = [0.05, -0.45, -0.05, 0, 0, 0]; %punto inziale

p_f = [0.60, 0.15, 0.05, 0, 0, 0]; % punto finale

%parametri della legge di moto trapezoidale

tempo_totale = 3; %secondi
tempo_acc_dec = 0.5; %durata della rampa di salita e di discesa

%MOTO PUNTO PUNTO
segmento_nello_spazio_operativo(p_i, p_f, puma560_model)





