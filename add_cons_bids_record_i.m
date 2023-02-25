Constraints_bids_old = [];
for g = 1:data.G_num
    if B_G_producer(i,g) == 1
        Constraints_bids_old = ...
            [Constraints_bids_old;
            b_g_t(g,:) == b_g_t_record(g,:)];
        Constraints_bids_old = ...
            [Constraints_bids_old;
            u_P_g_RO(g,1) == u_P_g_RO_record(g,1)];
    end
end
clear g;
for e = 1:data.E_num
    if B_E_producer(i,e) == 1
        Constraints_bids_old = ...
            [Constraints_bids_old;
            b_e_t(e,:) == b_e_t_record(e,:)];
        Constraints_bids_old = ...
            [Constraints_bids_old;
            u_P_e_RO(e,1) == u_P_e_RO_record(e,1)];
        Constraints_bids_old = ...
            [Constraints_bids_old;
            u_P_e_invest(e,:) == u_P_e_invest_record(e,:)];
    end
end
clear e;