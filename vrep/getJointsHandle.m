function joints = getJointsHandle(vrep, clientID, jNum, prefix)
    joints=zeros(1,jNum);
    for i=1:jNum
        [returnCode,joints(i)]=vrep.simxGetObjectHandle(clientID,strcat(prefix,num2str(i)),vrep.simx_opmode_oneshot_wait);        
    end    
end