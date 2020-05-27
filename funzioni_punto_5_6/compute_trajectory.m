function [trajectory_p,trajectory_v] = compute_trajectory( q_start, q_stop, step_time, NPunti)
            T = [0.05, 0.4, 0.05, 2, 0.05, 0.4, 0.05]
            for i=1:6
                %[p,F]= legge_moto_trapezoidale([0.5, 2.0, 0.5],q_stop, q_start, NPunti);
                [p,F] = trapezoidale_mod(T,300,[q_start, 0.0, 0.0, 0.6560]);
                q_traj_p(i,:) = F(1,:);
                q_traj_v(i,:) = F(2,:);
            end
            q_traj_t = p;
            trajectory_p = clean_and_resample(step_time, q_traj_t, q_traj_p);
            trajectory_v = clean_and_resample(step_time, q_traj_t, q_traj_v);


end