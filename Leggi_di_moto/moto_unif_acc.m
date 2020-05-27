   function [p,F] = moto_unif_acc(T,NPunti,Q0)     
    f_0 = Q0(1); %posizione iniziale
    df_0 = Q0(2); %velocit? iniziale
    ddf_0 = Q0(3); %accelerazione iniziale

    p = [0:T/NPunti:T];
    f  = f_0 + df_0 * p + 0.5 * ddf_0 * p.* p; %posizione
    df = df_0 + ddf_0 * p;  % velocita'
    ddf = ddf_0 * ones(size(df)); % accelerazione
    dddf =  zeros(size(df)) ; % jerk
    F = [f;df;ddf;dddf];