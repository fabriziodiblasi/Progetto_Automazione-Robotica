function segmento_nello_spazio(x_e_i, x_e_f)
    % dal testo sappiamo che:
    % tratto di salita = 0.5 secondi
    % tratto rettilineo =  1 secondo
    % tratto di discesa = 0.5 secondi

    t_salita = 0.5;
    t_rettilineo_unif = 1;
    t_discesa = 0.5;
  
    %legge_trapezoidale_scaricata(10,3,7)

    [p,F] = legge_moto_trapezoidale([t_salita, t_rettilineo_unif, t_discesa],x_e_i(1:3), x_e_f(1:3));
%     
    subplot(4,1,1)
    plot(p,F(1,:))
    xlabel("tempo [s]")
    ylabel("posizione [m]")
    
    subplot(4,1,2)
    plot(p,F(2,:))
    xlabel("tempo [s]")
    ylabel("velocità [m/s]")
    
    subplot(4,1,3)
    plot(p,F(3,:))
    xlabel("tempo [s]")
    ylabel("accelerazione [m/s2]")
    
    
    
    
    
end

