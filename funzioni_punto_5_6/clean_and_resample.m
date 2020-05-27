function resampled_set_point_vector = clean_and_resample(step_time,q_traj_t,q_traj_p)

        % Rimozione punti multipli
            cleaned_set_point_vector = uniquetol([q_traj_t',q_traj_p'],'ByRows',true);

        % Ricampionamento per simulazione
            resampled_set_point_vector(:,1) = 0:step_time:q_traj_t(end);
            for i=1:size(resampled_set_point_vector,1)  
                for j=1:6
                    resampled_set_point_vector(i,j+1) = interp1(cleaned_set_point_vector(:,1), cleaned_set_point_vector(:,1+j), resampled_set_point_vector(i,1));
                end
            end

end