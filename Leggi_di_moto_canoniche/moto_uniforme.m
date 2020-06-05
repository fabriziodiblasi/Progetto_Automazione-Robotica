    function [p,F] = moto_uniforme(T,Q0)
        f_0 = Q0(1); %posizione iniziale
        df_0 = Q0(2); %velocità iniziale
        
        NPunti = 1000; % Numero di punti per la stampa della traiettoria  
        p = [0:T/NPunti:T];
        
        f = f_0 + df_0 * p;
        df = ones(size(f)) * df_0;
        ddf = zeros(size(f));
        dddf = zeros(size(f));
        F=[f;df;ddf;dddf];