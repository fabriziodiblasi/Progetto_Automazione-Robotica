function [vrep, clientID] = connectToVrep()
    vrep = remApi('remoteApi');
    vrep.simxFinish(-1);
    clientID = vrep.simxStart('127.0.0.1',19997,true,true,5000,5);
    if (clientID>-1)
        disp('Connected to remote API server');
        [res,objs]=vrep.simxGetObjects(clientID,vrep.sim_handle_all,vrep.simx_opmode_oneshot_wait);
        if (res==vrep.simx_return_ok)
            fprintf('The remote API is working!\n');
        else
            fprintf('Remote API function call returned with error code: %d\n',res);
        end
    else
        disp('Failed connecting to remote API server');
    end
end