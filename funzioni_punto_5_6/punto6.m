function punto6(x_e_start, x_e_stop, puma560_model, NPunti)

    step_time=0.01;
    %[trajectory_p,trajectory_v] = legge_moto_trapezoidale([0.5, 2.0, 0.5],q_stop, q_start, NPunti);
    T(:,:,1) = transl(x_e_start(1,1:3)); 
    T(:,:,2) = transl(x_e_stop(1,1:3));
    new_pos_start = [0.10, -0.45, -0.15, 0, 0, 0];
    T(:,:,3) = transl(new_pos_start(1,1:3));

    q_start = ikine(puma560_model,  T(:,:,1), [zeros(1,6)]); 
    q_stop = ikine(puma560_model,  T(:,:,2), [zeros(1,6)]); 
    
    new_joint_start_pos = ikine(puma560_model,  T(:,:,3), [zeros(1,6)]);

    [trajectory_p, trajectory_v, trajectory_a] = compute_trajectory(q_start, q_stop, step_time, NPunti);
    


    K_p = [3, 2, 0.165, 0.567, 0.34, 0.234];
    K_d = [0.00020, 0.00010, 0.00010, 0.0003, 0.00008, 0.0003];

    simulator = puma560VrepSimulator()

    simulator.setq(new_joint_start_pos);
    pause(0.5);
    e_i = zeros(1,6)
    t=0;
    q_history = [];
    
    for i=1:length(trajectory_p(:, 1))
        q = simulator.getq();
        q_d = trajectory_p(i, 2:7); 

        dq = simulator.getdq();
        dq_d = trajectory_v(i, 2:7);

        e_p = q_d - q;

        e_d = dq_d - dq;

        tau_dyn = K_p .* e_p + K_d .* e_d + trajectory_a(i, 2:7);

        Mt_dyn = puma560_model.inertia(q) * tau_dyn';

        n = puma560_model.coriolis(q, dq) * dq' + puma560_model.inertia(q) * dq' + puma560_model.gravload(q)';

        tau = Mt_dyn + n;

        simulator.set_torque(tau', step_time);

        q_history = [q_history; q];

        t = t + step_time;
        time(i) = t;
    end
%     for i=1:length(trajectory_p(:,1))
% 
%         q = simulator.getq();
% 
%         q_d = trajectory_p(i, 2:7);
%         q_d_d = trajectory_a(i,2:7);
% 
%         dq = simulator.getdq();
%         dq_d= trajectory_v(i, 2:7);
% 
%         e_p = q_d - q;
% 
%         e_d= (dq_d - dq)/step_time;
% 
%         %e_i = e_i + e_p .*step_time;
% 
%         tau_dyn = K_p .* e_p + K_d.*e_d + q_d_d;% + K_i .*e_i;
%         
%         n_q_q_dot = (puma560_model.coriolis(q(i,:),e_d) .* e_d)' ...
%                 + puma560_model.friction(e_d) .* e_d ...
%                 + puma560_model.gravload(q(i,:));
% 
%         T = (puma560_model.inertia(q(i,:)) * tau_dyn')' + n_q_q_dot;
%     
%         %Simulazione
%         if(i > 10)
%             simulator.set_torque(T);
%         end
% 
%         q_history = [ q_history; q];
% 
%         t = t+ step_time;
% 
%         time(i)=t;
% 
%     end
    
    figure('Name', 'Grafici Controllore PID dinamica inversa');
    for i=1:6
        subplot(6,1,i)
        plot(time, q_history(:,i), time, trajectory_p(:,i+1));
        xlabel("tempo s")
        ylabel("posizione rad")
        title(strcat("joint", num2str(i)));
        legend({"Real", "desire"})

    end
end