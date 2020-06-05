function [p,F]=parabolica(T,Q0)
    
    f_0 = Q0(1); %posizione iniziale
    df_0 = Q0(2); %velocità iniziale
    f_T = Q0(3); %posizione finale
    df_T = Q0(4); %velocità finale

    a_0 = f_0;
    a_1 = df_0;
    a_2 = - (4 * f_0 - 4 * f_T + 3 * T * df_0 + T * df_T) / (2 * T^2);
    b_0 = 2 * f_0 - f_T + (T * df_0) / 2 + (T * df_T) / 2;
    b_1 = - (4 * f_0 - 4 * f_T + T * df_0 + 2 * T * df_T) / T;
    b_2 = ( 4 * f_0 - 4 * f_T + T * df_0 + 3 * T * df_T) / (2 * T^2);

    NPunti = 1000; % Numero di punti per la stampa della traiettoria
    p1 = [0:T/NPunti:T/2];
    f1 = a_0 + a_1* p1 + a_2 * p1.*p1; %posizione
    df1 = a_1 + 2 * a_2 * p1; %velocita'
    ddf1 = 2 * a_2 * ones(size(df1)); %accelerazione
    dddf1 = zeros(size(df1)); %jerk
    
    p2 = [T/2 + T/NPunti:T/NPunti:T];
    f2  = b_0 + b_1* p2 + b_2 * p2.*p2; %posizione
    df2 = b_1 + 2 * b_2 * p2; %velocita'
    ddf2 = 2 * b_2 * ones(size(df2)); %accelerazione
    dddf2 = zeros(size(df2)); %jerk
    
    p = [p1,p2];
    f = [f1,f2];
    df = [df1,df2];
    ddf = [ddf1,ddf2];
    dddf = [dddf1,dddf2];

    F = [f;df;ddf;dddf];