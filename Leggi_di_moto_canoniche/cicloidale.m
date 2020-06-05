function [p,F]=cicloidale(T,Q0)
    
    f_0 = Q0(1); %posizione iniziale
    f_T = Q0(2); %posizione finale

    NPunti = 1000; % Numero di punti per la stampa della traiettoria
    p = [0:T/NPunti:T];
    h = f_T - f_0;
    f = f_0 + h * (p / T - (sin((2 * p * pi) / T)) / (2 * pi)); %posizione
    
    
    
    
    df = h / T * (1 - cos((2 * p * pi) / T));  % velocita'
    ddf = (h / T^2) * 2 * pi * sin((2 * p * pi) / T) ; % accelerazione
    dddf = (h / T^3) * 4 * pi^2 * cos((2 * p * pi) / T); % Jerk

    F = [f;df;ddf;dddf];