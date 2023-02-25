Constraints_KKT = [];
for g = 1:data.G_num
    for t = 1:data.T_num
        Constraints_KKT = [Constraints_KKT;...
            b_g_t(g,t)+lambda_t(1,t)-...
            tao_g_t_min(g,t)+tao_g_t_max(g,t)+...
            B_G_NODE(:,g)'*PTDF'*mu_f_t_max(:,t)-...
            B_G_NODE(:,g)'*PTDF'*mu_f_t_min(:,t) == 0];
    end
end
clear g t;
for e = 1:data.E_num
    for t = 1:data.T_num
        Constraints_KKT = [Constraints_KKT;...
            b_e_t(e,t)+lambda_t(1,t)-...
            tao_e_t_min(e,t)+tao_e_t_max(e,t)+...
            B_E_NODE(:,e)'*PTDF'*mu_f_t_max(:,t)-...
            B_E_NODE(:,e)'*PTDF'*mu_f_t_min(:,t) == 0];
    end
end
clear e t;
for d = 1:data.D_num
    for t = 1:data.T_num
        Constraints_KKT = [Constraints_KKT;-data.voll-lambda_t(1,t)-...
            tao_d_t_min(d,t)+tao_d_t_max(d,t)-...
            B_D_NODE(:,d)'*PTDF'*mu_f_t_max(:,t)+...
            B_D_NODE(:,d)'*PTDF'*mu_f_t_min(:,t) == 0];
    end
end
clear d t;
Constraints_KKT = [Constraints_KKT;0 <= P_g_t];
Constraints_KKT = [Constraints_KKT;P_g_t <= (data.G(:,5))*ones(1,data.T_num)];
Constraints_KKT = [Constraints_KKT;0 <= P_e_t];
Constraints_KKT = [Constraints_KKT;P_e_t <= (sum(u_P_e_invest,2).*data.E(:,5)/data.E_discrete_num)*ones(1,data.T_num)];
Constraints_KKT = [Constraints_KKT;0 <= P_d_t];
Constraints_KKT = [Constraints_KKT;P_d_t <= data.D_P];
Constraints_KKT = [Constraints_KKT;sum(P_g_t,1) + sum(P_e_t,1) == sum(P_d_t,1)];
Constraints_KKT = [Constraints_KKT;PTDF*(B_G_NODE*P_g_t+B_E_NODE*P_e_t-...
    B_D_NODE*P_d_t) <= data.branch(data.congestion_id,4)*ones(1,data.T_num)];
Constraints_KKT = [Constraints_KKT;PTDF*(B_G_NODE*P_g_t+B_E_NODE*P_e_t-...
    B_D_NODE*P_d_t) >= -data.branch(data.congestion_id,4)*ones(1,data.T_num)];
Constraints_KKT = [Constraints_KKT;tao_g_t_min >= 0];
Constraints_KKT = [Constraints_KKT;tao_g_t_max >= 0];
Constraints_KKT = [Constraints_KKT;tao_e_t_min >= 0];
Constraints_KKT = [Constraints_KKT;tao_e_t_max >= 0];
Constraints_KKT = [Constraints_KKT;tao_d_t_min >= 0];
Constraints_KKT = [Constraints_KKT;tao_d_t_max >= 0];
Constraints_KKT = [Constraints_KKT;mu_f_t_min >= 0];
Constraints_KKT = [Constraints_KKT;mu_f_t_max >= 0];

Constraints_KKT = [Constraints_KKT;P_g_t <= M*u_tao_g_t_min];
Constraints_KKT = [Constraints_KKT;tao_g_t_min <= M*(1-u_tao_g_t_min)];
Constraints_KKT = [Constraints_KKT;data.G(:,5)*...
    ones(1,data.T_num) - P_g_t <= M*u_tao_g_t_max];
Constraints_KKT = [Constraints_KKT;tao_g_t_max <= M*(1-u_tao_g_t_max)];
Constraints_KKT = [Constraints_KKT;P_e_t <= M*u_tao_e_t_min];
Constraints_KKT = [Constraints_KKT;tao_e_t_min <= M*(1-u_tao_e_t_min)];
Constraints_KKT = [Constraints_KKT;(sum(u_P_e_invest,2).*data.E(:,5)/data.E_discrete_num)*ones(1,data.T_num) - ...
    P_e_t <= M*u_tao_e_t_max];
Constraints_KKT = [Constraints_KKT;tao_e_t_max <= M*(1-u_tao_e_t_max)];
Constraints_KKT = [Constraints_KKT;P_d_t <= M*u_tao_d_t_min];
Constraints_KKT = [Constraints_KKT;tao_d_t_min <= M*(1-u_tao_d_t_min)];
Constraints_KKT = [Constraints_KKT;data.D_P - P_d_t <= M*u_tao_d_t_max];
Constraints_KKT = [Constraints_KKT;tao_d_t_max <= M*(1-u_tao_d_t_max)];
Constraints_KKT = [Constraints_KKT;PTDF*(B_G_NODE*P_g_t+B_E_NODE*P_e_t-...
    B_D_NODE*P_d_t) + data.branch(data.congestion_id,4)*ones(1,data.T_num) <= M*u_mu_f_t_min];
Constraints_KKT = [Constraints_KKT;mu_f_t_min <= M*(1-u_mu_f_t_min)];
Constraints_KKT = [Constraints_KKT;-PTDF*(B_G_NODE*P_g_t+B_E_NODE*P_e_t-...
    B_D_NODE*P_d_t) + data.branch(data.congestion_id,4)*ones(1,data.T_num) <= M*u_mu_f_t_max];
Constraints_KKT = [Constraints_KKT;mu_f_t_max <= M*(1-u_mu_f_t_max)];