function segmento_nello_spazio(x_e_i, x_e_f, puma560_model)
    % dal testo sappiamo che:
    % tratto di salita = 0.5 secondi
    % tratto rettilineo =  2 secondi
    % tratto di discesa = 0.5 secondi

    t_salita = 0.5;
    t_rettilineo_unif = 2;
    t_discesa = 0.5;
    
    NPunti = 5;
  
    %legge_trapezoidale_scaricata(10,3,7)
    s_posizione_start=0;
    s_posizione_end = norm(x_e_f(1:3)-x_e_i(1:3));

    [p,F] = legge_moto_trapezoidale([t_salita, t_rettilineo_unif, t_discesa],s_posizione_end, s_posizione_start, NPunti);
    [p_mod,F_mod] = trapezoidale_mod([0.05, 0.4, 0.05, 2, 0.05, 0.4, 0.05],300,[0.0, 0.0, 0.0, 0.6560]);

    figure('Name','Leggi di moto sx: legge custom, dx = legge canonica'); 
    %figure;
    subplot(4,2,1)
    plot(p,F(1,:))
    xlabel("tempo [s]")
    ylabel("posizione [m]")
    
    subplot(4,2,2)
    plot(p_mod,F_mod(1,:))
    xlabel("tempo [s]")
    ylabel("posizione [m]")
    ylim([0.0, 1.0])
    
    subplot(4,2,3)
    plot(p,F(2,:))
    xlabel("tempo [s]")
    ylabel("velocità [m/s]")
    
    subplot(4,2,4)
    plot(p_mod,F_mod(2,:))
    xlabel("tempo [s]")
    ylabel("velocità [m/s]")
    ylim([0.0, 0.4])
    
    subplot(4,2,5)
    plot(p,F(3,:))
    xlabel("tempo [s]")
    ylabel("accelerazione [m/s2]")
    
    subplot(4,2,6)
    plot(p_mod,F_mod(3,:))
    xlabel("tempo [s]")
    ylabel("accelerazione [m/s2]")
    
    
    
%     subplot(4,1,4)
%     plot(p,F(4,:))
%     xlabel("tempo [s]")
%     ylabel("Jerk [m/s3]")
    s_posizione_start=0;
    s_posizione_end=norm(x_e_f(1:3)-x_e_i(1:3));
    
    
    
    for i=1:size(F,2)
        x_e(i,1:3)=x_e_i(1:3)+(F(1,i)/norm(x_e_f(1:3)- x_e_i(1:3))) * (x_e_f(1:3)-x_e_i(1:3));
    end
    

    for i=1:size(x_e,1)
        Frames{i} = transl(x_e(i,1:3));
    end
    
    plot_frames(Frames);
    hold on;
    scatter3(x_e(2:end,1),x_e(2:end,2),x_e(2:end,3), 'ob');
    scatter3(x_e(1,1),x_e(1,2),x_e(1,3), 'or');
    xlabel('x[m]')
    ylabel('y[m]')
    zlabel('z[m]')
    xlim([-1.0, 1.0])
    ylim([-1.0, 1.0])
    zlim([-1.0, 1.0])
    
    %creo il vettore delle matrici di trasformazione
    
    T(:,:,1)=transl(x_e(1,1:3)); 
    for i=2:size(x_e,1)
        T(:,:,i)=transl(x_e(i,1:3)); 

    end
    
    q_targhet = ikine(puma560_model, T, [zeros(1,6)])

    [num_samples,num_col] = size(q_targhet)


    T = (t_salita + t_rettilineo_unif + t_discesa )/num_samples * ones(1, num_samples-1)

    [q_traj_t, q_traj_p, t]= join_spline_interpolation(q_targhet, T);
    %posizione
    plot_interpolated_trajectory(q_traj_t, q_traj_p, t, q_targhet, "posizione");
    run_simulation(0.1, q_traj_t, q_traj_p)
    
    %GRAFICI PUNTO 3 ED ESECUZIONE DEL PUNTO 4
    NPunti=300
    [q_traj_tt, q_traj_pp, q_traj_vv, q_traj_aa] = grafici_spazio_dei_giunti_e_coppie(puma560_model,q_targhet(1,:), q_targhet(num_samples, :), NPunti);
    
    
    
    new_q_start = [0.10, -0.45, -0.15, 0, 0, 0]
    new_q_stop = x_e_f
    
    esegui_punto_5_6(new_q_start, new_q_stop, puma560_model, NPunti)
    
%     for i=1:length(q_traj_pp)
%         tau(:,i) = puma560_model.rne(q_traj_pp(:,i)', q_traj_vv(:,i)', q_traj_aa(:,i)');
%     end
%      
%     
% 
%     %Plot
%     figure;
%     subplot(1,1,1)
%     plot(q_traj_tt,tau);
%     xlabel("Tempo[s]");
%     ylabel("Coppia [N*m]");
% 
%     l = legend({'J1','J2','J3','J4','J5','J6'});
%     newPosition = [0.95 0.4 0.025 0.2];
%     set(l, 'position', newPosition);
%     
    
    
end

