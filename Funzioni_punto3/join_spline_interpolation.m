function [q_traj_t,q_traj_p, t] = join_spline_interpolation(q_targhet, T) 
    t(1) = 0;
    for i = 1:length(T)
        t(i+1) = sum ( T(1:i));
    end
    NPunti = 1000;
    p = 0:sum(T)/NPunti:sum(T);
    
    for i = 1:6
        F = spline(t,q_targhet(:,i),p);
        q_traj_p(i,:)=F(1,:);
    end
    q_traj_t =p;
    

end