classdef puma560VrepSimulator < handle
    properties
        %DH
            d = [0, 0, 0.1501, 0.4331, 0, 0];
            a = [0, 0.4323, 0, 0, 0, 0];
            alpha = [ pi/2, 0, -pi/2, pi/2, -pi/2, 0];
            offset = [0.00000, 0.00000, 0.00000, 0.00000, 0.00000, 0.00000];
            m = [0, 17.4, 4.8, 0.82, 0.34, 0.09];
            r_x = [0, -0.3638, -0.0203, 0, 0, 0];
            r_y = [0, 0.006, -0.0141, 0.0190, 0, 0];
            r_z = [0, 0.2275, 0.07, 0, 0, 0.0320];
            I_xx = [0, 0.13, 0.066, 0.0018, 0.0003, 0.00015];
            I_yy = [0.35, 0.5240, 0.086, 0.0013, 0.0004, 0.00015];
            I_zz = [0, 0.5390, 0.0125, 0.0018, 0.0003, 0.00004];
        %Model
            arm_model;
        %VRep
            vrep;
            clientID;
            handle;    
            arm_speed = zeros(1,6);
    end
    
    methods
        function obj = puma560VrepSimulator()   
            for i=1:6  
                 L(i) = Revolute('d', obj.d(i), 'a', obj.a(i), 'alpha', obj.alpha(i), 'offset', obj.offset(i), ...
                    'm', obj.m(i), 'r', [obj.r_x(i), obj.r_y(i), obj.r_z(i)], 'I', [obj.I_xx(i), obj.I_yy(i), obj.I_zz(i)]);
            end
            obj.arm_model = SerialLink(L);
            [obj.vrep, obj.clientID] = connectToVrep();
            obj.handle = getJointsHandle(obj.vrep, obj.clientID, 6, 'j');
            obj.setq([0,0,0,0,0,0]);
            enable_joint_streaming(obj);     
        end
     
        function setq(obj,q)
            for i=1:6
                obj.vrep.simxSetJointPosition(obj.clientID,obj.handle(i),q(i),obj.vrep.simx_opmode_oneshot);
            end  
        end
        
        function set_torque(obj, T, step_time) 
            q = obj.getq();
            dq = obj.arm_speed;          
            ddq = obj.arm_model.accel(q ,dq, T);          
            obj.arm_speed = obj.arm_speed + ddq' * step_time;
            q = q + obj.arm_speed * step_time;
            setq(obj,q);    
        end
        
        function q = getq(obj) 
            for i=1:6
                [~,q(i)] = obj.vrep.simxGetJointPosition(obj.clientID, obj.handle(i), obj.vrep.simx_opmode_streaming);
            end
        end
        
        function dq = getdq(obj)
            dq = obj.arm_speed; 
        end
        
        function enable_joint_streaming(obj)
            for i=1:6
                obj.vrep.simxGetJointPosition(obj.clientID, obj.handle(i), obj.vrep.simx_opmode_streaming);
                while(obj.vrep.simxGetJointPosition(obj.clientID, obj.handle(i), obj.vrep.simx_opmode_buffer) ~= obj.vrep.simx_return_ok)
                end
            end
        end
            
    end
end