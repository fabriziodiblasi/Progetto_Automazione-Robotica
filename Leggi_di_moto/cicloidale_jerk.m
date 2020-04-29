    function [p,F] = cicloidale_jerk(T,Q0)
        f_0 = Q0(1); %posizione iniziale
        df_0 = Q0(2); %velocità iniziale
        ddf_0 = Q0(3); %accelerazione iniziale
        ddf_T = Q0(4); %accelerazione finale
        
        NPunti = 1000; % Numero di punti per la stampa della traiettoria  
        p = [0:T/NPunti:T];
        f_a = pi^2 * p.*p + 2 * T^2 * (1 - cos(pi * p / T));
        f_b =  pi^2 * p.*p - 2 * T^2 * (1 - cos(pi * p / T));
        f =  (f_a * ddf_0 + f_b * ddf_T) / (4 * pi^2) + df_0 * p + f_0;
        df = ((T * sin(pi * p / T) * (ddf_0 - ddf_T)) / pi + p * (ddf_0 + ddf_T)) / 2 + df_0;
        ddf = ddf_0 + (-1 + cos(pi * p / T)) * (ddf_0 - ddf_T) / 2;
        dddf = pi * sin(pi * p / T) * (ddf_T - ddf_0) / (2 * T);
        F = [f;df;ddf;dddf];