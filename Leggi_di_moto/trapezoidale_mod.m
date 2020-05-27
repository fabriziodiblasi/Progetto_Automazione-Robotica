function [p,F]=trapezoidale_mod(T,NPunti,Q0)     
    T_1 = T(1); %intervalli di tempo
    T_2 = T(2);
    T_3 = T(3);
    T_4 = T(4);
    T_5 = T(5);
    T_6 = T(6);
    T_7 = T(7);
    
    NPunti = floor(NPunti / 7);
    
    f_0 = Q0(1); %posizione iniziale
    df_0 = Q0(2); %velocit? iniziale
    ddf_0 = Q0(3); %accelerazione iniziale
    ddf_T = Q0(4); %accelerazione massima
    
    [p1,F1] = cicloidale_jerk(T_1,NPunti,[f_0,df_0,ddf_0,ddf_T]);
    [p2,F2] = moto_unif_acc(T_2,NPunti,[F1(1,end),F1(2,end),F1(3,end)]);     p2 = p2 + T_1;
    [p3,F3] = cicloidale_jerk(T_3,NPunti,[F2(1,end),F2(2,end),F2(3,end),ddf_0]);   p3 = p3 + T_1 + T_2;
    [p4,F4] = moto_unif_acc(T_4,NPunti,[F3(1,end),F3(2,end),F3(3,end)]);   p4 = p4 + T_1 + T_2 + T_3;
    [p5,F5] = cicloidale_jerk(T_5,NPunti,[F4(1,end),F4(2,end),F4(3,end),-ddf_T]);   p5 = p5 + T_1 + T_2 + T_3 + T_4;
    [p6,F6] = moto_unif_acc(T_6,NPunti,[F5(1,end),F5(2,end),F5(3,end)]);   p6 = p6 + T_1 + T_2 + T_3 + T_4 + T_5;
    [p7,F7] = cicloidale_jerk(T_7,NPunti,[F6(1,end),F6(2,end),F6(3,end),ddf_0]);   p7 = p7 + T_1 + T_2 + T_3 + T_4 + T_5 + T_6;
    
    p = [p1,p2,p3,p4,p5,p6,p7];
    F = [F1,F2,F3,F4,F5,F6,F7];

    function [p,F] = cicloidale_jerk(T,NPunti,Q0)
        f_0 = Q0(1); %posizione iniziale
        df_0 = Q0(2); %velocit? iniziale
        ddf_0 = Q0(3); %accelerazione iniziale
        ddf_T = Q0(4); %accelerazione finale
        
        p = [0:T/NPunti:T];
        f_a = pi^2 * p.*p + 2 * T^2 * (1 - cos(pi * p / T));
        f_b =  pi^2 * p.*p - 2 * T^2 * (1 - cos(pi * p / T));
        f =  (f_a * ddf_0 + f_b * ddf_T) / (4 * pi^2) + df_0 * p + f_0;
        df = ((T * sin(pi * p / T) * (ddf_0 - ddf_T)) / pi + p * (ddf_0 + ddf_T)) / 2 + df_0;
        ddf = ddf_0 + (-1 + cos(pi * p / T)) * (ddf_0 - ddf_T) / 2;
        dddf = pi * sin(pi * p / T) * (ddf_T - ddf_0) / (2 * T);
        F = [f;df;ddf;dddf];


        

        