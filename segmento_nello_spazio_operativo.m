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

    [p,F] = legge_moto_trapezoidale([t_salita, t_rettilineo_unif, t_discesa],x_e_i(1:3), x_e_f(1:3), NPunti);
%    
    figure;
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
    
    figure;
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
    q_targhet = ikine(puma560_model, T, [zeros(1,6)]);
    [num_samples,num_col] = size(q_targhet)


    T = (t_salita + t_rettilineo_unif + t_discesa )/num_samples * ones(1, num_samples-1)

    [q_traj_t, q_traj_p, t]= join_spline_interpolation(q_targhet, T);
    %posizione
    plot_interpolated_trajectory(q_traj_t, q_traj_p, t, q_targhet, "posizione");
    run_simulation(0.1, q_traj_t, q_traj_p)
    
    %velocità
    vel = zeros(num_samples,num_col);
    for col=1:num_col
        for row=1:num_samples-1
            vel(row,col) = (q_targhet(row+1,col)- q_targhet(row,col))/T(row);
        end
    end
    [time, q_v, t]= join_spline_interpolation(vel, T);
    plot_interpolated_trajectory(time, q_v, t, q_targhet, "velocita'");
    
    
    %accelerazione
    acc = zeros(num_samples,num_col);
    for col=1:num_col
        for row=1:num_samples-1
            acc(row,col) = (vel(row+1,col)- vel(row,col))/T(row);
        end
    end
    [time, q_a, t]= join_spline_interpolation(acc, T);
    plot_interpolated_trajectory(time, q_a, t, q_targhet, "accelerazione");
    

    
    
end

