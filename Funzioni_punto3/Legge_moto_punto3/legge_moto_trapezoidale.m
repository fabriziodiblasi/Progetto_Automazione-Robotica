function [p,F]=legge_moto_trapezoidale(T,Qf, Qi, NPunti)     
    % Q(1) : posizione iniziale
    % Q(2) : posizione finale
    

    % T(1) : tempo moto salita
    % T(2) : tempo moto rettilineo_unif
    % T(3) : tempo moto discesa
   
    spazio_totale = Qf - Qi

    tempo_totale = T(1) + T(2) + T(3)
    
    velocita_media= spazio_totale/tempo_totale
    
    v_max = spazio_totale/ 2.5
    
    accelerazione = v_max / T(1)
    
  

    %posizione iniziale; %velocit? iniziale %accelerazione  
    [p1,F1] = moto_unif_acc_mod(T(1),[0.0,0.0,accelerazione] , NPunti);
    [p2,F2] = moto_unif_acc_mod(T(2),[F1(1,end),v_max,0], NPunti);     p2 = p2 + T(1);
    [p3,F3] = moto_unif_acc_mod(T(3),[F2(1,end),v_max,-accelerazione], NPunti);  p3 = p3 + T(1) + T(2);
    

    p = [p1,p2,p3];
    F = [F1, F2, F3];
    
end
