Objs_for_each_player = cell(1,data.producer_num);
for i = 1:data.producer_num
    Objs_for_each_player{1,i} = 0;
    for g = 1:data.G_num
        if B_G_producer(i,g) == 1
            Objs_for_each_player{1,i} = Objs_for_each_player{1,i} + ...
                P_g_t(g,:)*data.G(g,4)*data.dT';
            Objs_for_each_player{1,i} = Objs_for_each_player{1,i} - ...
                data.RO_rou*u_P_g_RO(g,1)*data.G(g,5);
            Objs_for_each_player{1,i} = Objs_for_each_player{1,i} + ...
                z_g_t_rou_G(g,:)*data.G(g,5)*data.dT';
        else
            Objs_for_each_player{1,i} = Objs_for_each_player{1,i} + ...
                (b_g_t_new(g,:).*P_g_t(g,:))*data.dT';
            Objs_for_each_player{1,i} = Objs_for_each_player{1,i} + ...
                (data.G(g,5)*tao_g_t_max(g,:))*data.dT';
        end
    end
    clear g;
    for e = 1:data.E_num
        if B_E_producer(i,e) == 1
            Objs_for_each_player{1,i} = Objs_for_each_player{1,i} + ...
                P_e_t(e,:)*data.E(e,4)*data.dT';
            Objs_for_each_player{1,i} = Objs_for_each_player{1,i} - ...
                data.RO_rou*sum(u_e_k_RO_invest(e,:)*data.E(e,5)/data.E_discrete_num);
            Objs_for_each_player{1,i} = Objs_for_each_player{1,i} + ...
                sum(z_e_t_k_rou_E(e,:,:)*(data.E(e,5)/data.E_discrete_num),3)*data.dT';
            Objs_for_each_player{1,i} = Objs_for_each_player{1,i} + ...
                data.E(e,6)*sum(u_P_e_invest(e,:)*data.E(e,5)/data.E_discrete_num);
        else
            Objs_for_each_player{1,i} = Objs_for_each_player{1,i} + ...
                (b_e_t_new(e,:).*P_e_t(e,:))*data.dT';
            Objs_for_each_player{1,i} = Objs_for_each_player{1,i} + ...
                sum(data.E(e,5)/data.E_discrete_num*w_e_t_k_E(e,:,:),3)*data.dT';
        end
    end
    clear e;
    for d = 1:data.D_num
        Objs_for_each_player{1,i} = Objs_for_each_player{1,i} - ...
            (data.voll*P_d_t(d,:))*data.dT';
        Objs_for_each_player{1,i} = Objs_for_each_player{1,i} + ...
            (tao_d_t_max(d,:).*data.D_P(d,:))*data.dT';
    end
    clear d;
    for f = 1:data.congestion_num
        Objs_for_each_player{1,i} = Objs_for_each_player{1,i} + ...
            (data.branch(data.congestion_id(f),4)*(mu_f_t_max(f,:)+mu_f_t_min(f,:)))*data.dT';
    end
    clear f;
end
clear i;