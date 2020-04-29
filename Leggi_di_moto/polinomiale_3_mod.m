function [p,F]=polinomiale_3_mod(T,NPunti,Q0)
    
    f_0 = Q0(1); %posizione iniziale
    df_0 = Q0(2); %velocità iniziale
    f_T = Q0(3); %posizione finale
    df_T = Q0(4); %velocità finale

    a_0 = f_0;
    a_1 = df_0;
    a_2 = (3 * (f_T - f_0) - T * (2 * df_0 + df_T)) / T^2;
    a_3 = - ( 2 * (f_T - f_0) - T * (df_0 + df_T) ) / T^3;
    
    p = [0:T/NPunti:T];
    f  = a_0 + a_1* p + a_2 * p.*p + a_3 * p.*p.*p; %posizione
    df = a_1 + 2 * a_2 * p + 3 * a_3 * p.*p;  % velocita'
    ddf = 2 * a_2 + 6 * a_3 * p; % accelerazione
    dddf =  6 * a_3*ones(size(ddf)) ; % jerk
    F = [f;df;ddf;dddf];