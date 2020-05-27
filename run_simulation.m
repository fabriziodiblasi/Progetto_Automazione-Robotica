function run_simulation(step_time, q_traj_t, qtraj_p)
    traj_table = clean_and_resample(step_time,q_traj_t, qtraj_p);
    %simulator = UR5VrepSimulator();
    simulator = puma560VrepSimulator();
    for i=1:size(traj_table,1)
        simulator.setq(traj_table(i,2:7));
        pause(step_time)
    end
end