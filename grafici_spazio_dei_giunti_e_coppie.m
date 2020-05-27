function [q_traj_tt, q_traj_pp, q_traj_vv, q_traj_aa] = grafici_spazio_dei_giunti_e_coppie(puma560_model,q_start, q_stop, NPunti)
    
    joint_acc_max = [1.47,0.37,-0.449,1.74e-12,0.073,-1.475];

    for i=1:6
        [p,F] = trapezoidale_mod([0.05, 0.4, 0.05, 2, 0.05, 0.4, 0.05],300,[q_start(i), 0.0, 0.0, joint_acc_max(i)])
        %[p,F] = legge_moto_trapezoidale([0.5, 2.0, 0.5],q_stop(i), q_start(i), 10);
        q_traj_pp(i,:)=F(1,:);
        q_traj_vv(i,:)=F(2,:);
        q_traj_aa(i,:)=F(3,:);
        q_traj_jj(i,:)=F(4,:);
    end
    
    figure('Name','Grafici Spazio dei giunti'),
    q_traj_tt =p;
    subplot(4,1,1)
    plot(q_traj_tt,q_traj_pp)
    xlabel("tempo [s]")
    ylabel("posizione [m]")

    subplot(4,1,2)
    plot(q_traj_tt,q_traj_vv)
    xlabel("tempo [s]")
    ylabel("velocit? [rad/s]")

    subplot(4,1,3)
    plot(q_traj_tt,q_traj_aa)
    xlabel("tempo [s]")
    ylabel("accelerazione [rad/s^2]")


    subplot(4,1,4)
    plot(q_traj_tt,q_traj_jj)
    xlabel("tempo [s]")
    ylabel("jerk [rad/sec^3]")

    legenda = legend({'J1','J2','J3','J4','J5','J6',})
    newPosition=[0.95,0.4,0.025,0.2]
    set(legenda, 'Position',newPosition)
    
    
    for i=1:length(q_traj_pp)
        tau(:,i) = puma560_model.rne(q_traj_pp(:,i)', q_traj_vv(:,i)', q_traj_aa(:,i)');
    end
    
    
    size(q_traj_tt)
    size(tau)

    %Plot
    figure('Name', 'grafico delle coppie');
    subplot(1,1,1)
    plot(q_traj_tt,tau);
    xlabel("Tempo[s]");
    ylabel("Coppia [N*m]");

    l = legend({'J1','J2','J3','J4','J5','J6'});
    newPosition = [0.95 0.4 0.025 0.2];
    set(l, 'position', newPosition);

    
    
end