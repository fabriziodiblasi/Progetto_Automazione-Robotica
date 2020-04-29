function [p,F]=trapezoidale_mod(T,Q0)     
    T_1 = T(1); %intervalli di tempo
    T_2 = T(2);
    T_3 = T(3);
    T_4 = T(4);
    T_5 = T(5);
    T_6 = T(6);
    T_7 = T(7);
    
    f_0 = Q0(1); %posizione iniziale
    df_0 = Q0(2); %velocità iniziale
    ddf_0 = 0.0; %accelerazione iniziale
    ddf_T = Q0(3); %accelerazione massima
    
    [p1,F1] = cicloidale_jerk(T_1,[f_0,df_0,ddf_0,ddf_T]);
    [p2,F2] = moto_unif_acc(T_2,[F1(1,end),F1(2,end),F1(3,end)]);     p2 = p2 + T_1;
    [p3,F3] = cicloidale_jerk(T_3,[F2(1,end),F2(2,end),F2(3,end),ddf_0]);   p3 = p3 + T_1 + T_2;
    [p4,F4] = moto_unif_acc(T_4,[F3(1,end),F3(2,end),F3(3,end)]);   p4 = p4 + T_1 + T_2 + T_3;
    [p5,F5] = cicloidale_jerk(T_5,[F4(1,end),F4(2,end),F4(3,end),-ddf_T]);   p5 = p5 + T_1 + T_2 + T_3 + T_4;
    [p6,F6] = moto_unif_acc(T_6,[F5(1,end),F5(2,end),F5(3,end)]);   p6 = p6 + T_1 + T_2 + T_3 + T_4 + T_5;
    [p7,F7] = cicloidale_jerk(T_7,[F6(1,end),F6(2,end),F6(3,end),ddf_0]);   p7 = p7 + T_1 + T_2 + T_3 + T_4 + T_5 + T_6;
    
    p = [p1,p2,p3,p4,p5,p6,p7];
    F = [F1,F2,F3,F4,F5,F6,F7];


        

        