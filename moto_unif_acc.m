   function [p,F] = moto_unif_acc(T,Q0)     
        f_0 = Q0(1); %posizione iniziale
        df_0 = Q0(2); %velocità iniziale
        ddf_0 = Q0(3); %accelerazione
        
        NPunti = 1000; % Numero di punti per la stampa della traiettoria
        p = [0:T/NPunti:T];
        f  = f_0 + df_0 * p + 0.5 * ddf_0 * p.* p; %posizione
        df = df_0 + ddf_0 * p;  % velocita'
        ddf = ddf_0 * ones(size(df)); % accelerazione
        dddf =  zeros(size(df)) ; % jerk
        F = [f;df;ddf;dddf];