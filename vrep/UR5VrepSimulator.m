classdef UR5VrepSimulator < handle
    properties
        %DH
            d = [0.089159,  0.00000,  0.00000,  0.10915,  0.09465,  0.0823];
            a = [0.00000, -0.42500, -0.39225,  0.00000,  0.00000,  0.0000];
            alpha = [ 1.570796327, 0, 0, 1.570796327, -1.570796327, 0 ];
            offset = [0.00000, 0.00000, 0.00000, 0.00000, 0.00000, 0.00000];
            m = [2.00, 3.00, 2.50, 2.00, 2.00, 1.0];
            r_x = [-0.0000000528, -0.0164, -0.00159,0.00559,0.0086,-0.00472];
            r_y = [-0.0000000402, -0.00001015, 0.0000046,0.00001167,-0.0000163,0.00001229];
            r_z = [0.00117, 0.00889, 0.0265, 0.06065, -0.00616, -0.00472];
            I_xx = [0.001054, 0.00145, 0.0286, 0.0276, 0.00117, 0.001477];
            I_yy = [0.001054, 0.00287, 0.0296, 0.0278, 0.0000198, 0.00244];
            I_zz = [0.001, 0.002415, 0.002085, 0.00114, 0.0018, 0.00196];
        %Model
            arm_model;
        %VRep
            vrep;
            clientID;
            handle;
    end
    
    methods
        function obj = UR5VrepSimulator()   
            for i=1:6  
                 L(i) = Revolute('d', obj.d(i), 'a', obj.a(i), 'alpha', obj.alpha(i), 'offset', obj.offset(i), ...
                    'm', obj.m(i), 'r', [obj.r_x(i), obj.r_y(i), obj.r_z(i)], 'I', [obj.I_xx(i), obj.I_yy(i), obj.I_zz(i)]);
            end
            obj.arm_model = SerialLink(L);
            [obj.vrep, obj.clientID] = connectToVrep();
            obj.handle = getJointsHandle(obj.vrep, obj.clientID, 6, 'UR5_joint');
            obj.setq([0,0,0,0,0,0]);
            enable_joint_streaming(obj);     
        end
     
        function setq(obj,q)
            for i=1:6
                obj.vrep.simxSetJointPosition(obj.clientID,obj.handle(i),q(i),obj.vrep.simx_opmode_oneshot);
            end   
        end
        
        function q = getq(obj) 
            for i=1:6
                [returnCode,q(i)] = obj.vrep.simxGetJointPosition(obj.clientID, obj.handle(i), obj.vrep.simx_opmode_streaming);
            end
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