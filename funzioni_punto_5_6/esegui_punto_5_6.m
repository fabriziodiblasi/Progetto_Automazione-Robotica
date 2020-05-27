function esegui_punto_5_6(x_e_start, x_e_stop, puma560_model, NPunti)

            step_time=0.01
            %[trajectory_p,trajectory_v] = legge_moto_trapezoidale([0.5, 2.0, 0.5],q_stop, q_start, NPunti);
            T(:,:,1) = transl(x_e_start(1,1:3)) 
            T(:,:,2) = transl(x_e_stop(1,1:3))

            q_start = ikine(puma560_model,  T(:,:,1), [zeros(1,6)]); 
            q_stop = ikine(puma560_model,  T(:,:,2), [zeros(1,6)]); 

            [trajectory_p,trajectory_v] = compute_trajectory(q_start, q_stop, step_time, NPunti)


            %parametri del controllore
            K_p=[2000,1500,1500,200,150,50]
            K_d=[20, 10, 10, 1.0, 0.8, 0.3]
            K_i=[100, 75, 75, 50, 25, 10]
            
            simulator = puma560VrepSimulator();

            simulator.setq(q_start);
            pause(0.5);
            e_i = zeros(1,6)
            t=0;
            q_history = [];
            for i=1:length(trajectory_p(:,1))

                q = simulator.getq();
                q_d = trajectory_p(i, 2:7);

                dq = simulator.getdq();
                dq_d= trajectory_v(i, 2:7);

                e_p = q_d - q;

                e_d= dq_d - dq;

                e_i = e_i + e_p .*step_time;

                tau = K_p .* e_p + K_d.*e_d + K_i .*e_i;

                simulator.set_torque(tau, step_time);

                q_history = [ q_history; q];

                t = t+ step_time;

                time(i)=t

            end

            figure;
            for i=1:6
                subplot(6,1,i)
                plot(time, q_history(:,i), time, trajectory_p(:,i+1));
                xlabel("tempo s")
                ylabel("posizione rad")
                title(strcat("joint", num2str(i)));
                legend({"Real", "desire"})

            end
end