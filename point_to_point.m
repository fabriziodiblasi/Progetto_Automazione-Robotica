function point_to_point(q_start, q_stop, tempo_salita_discesa, tempo_totale)
    for i=1:6
        [p,F] = polinomiale_3(tempo, [q_start(i),0.0, q_stop(i),0.0]);
        q_traj_p(i,:)=F(1,:);
        q_traj_v(i,:)=F(2,:);
        q_traj_a(i,:)=F(3,:);
        q_traj_j(i,:)=F(4,:);
    end

    q_traj_t =p;

    subplot(4,1,1)
    plot(q_traj_t,q_traj_p)
    xlabel("tempo [s]")
    ylabel("posizione [m]")

    subplot(4,1,2)
    plot(q_traj_t,q_traj_v)
    xlabel("tempo [s]")
    ylabel("velocit? [rad/s]")

    subplot(4,1,3)
    plot(q_traj_t,q_traj_a)
    xlabel("tempo [s]")
    ylabel("accelerazione [rad/s^2]")


    subplot(4,1,4)
    plot(q_traj_t,q_traj_j)
    xlabel("tempo [s]")
    ylabel("jerk [rad/sec^3]")

    legenda = legend({'J1','J2','J3','J4','J5','J6',})
    newPosition=[0.95,0.4,0.025,0.2]
    set(legenda, 'Position',newPosition)

    run_simulation(0.1, q_traj_t, q_traj_p)
end
