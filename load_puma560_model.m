function puma560_model = load_puma560_model()
    alpha = [pi/2, 0.0, -pi/2, pi/2, -pi/2, 0.0 ];
    a = [0.0, 0.4323, 0.0,  0.0,  0.0,  0.0];
    theta = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
    d = [0.0,  0.0,  0.1501,  0.4331,  0.0,  0.0];

    m =[0, 17.4, 4.8, 0.82, 0.34,0.09];

    r_x =[0, -0.3638, -0.0203, 0, 0, 0];
    r_y=[0, 0.0060 ,-0.0141, 0.0190, 0, 0];
    r_z=[0, 0.2275, 0.0700, 0, 0, 0.0320];

    I_xx=[0, 0.1300, 0.0660, 0.0018, 0.0003, 0.00015];
    I_yy=[0.3500, 0.5240, 0.0860, 0.0013, 0.0004, 0.00015];
    I_zz=[0, 0.5390, 0.0125, 0.0018, 0.0003, 0.00004];
    
    for i=1:6
        L(i) = Link('d', d(i), 'a', a(i), 'alpha', alpha(i), 'revolute', ...
        'm', m(i), 'r', [r_x(i),r_y(i),r_z(i)], ...
        'I', [I_xx(i),I_yy(i),I_zz(i)])
    end

    puma560_model = SerialLink(L, 'name','puma560_model');
end