Constraints_bids = cell(1,data.producer_num);
for i = 1:data.producer_num
    Constraints_bids{1,i} = [];
    for g = 1:data.G_num
        if B_G_producer(i,g) == 0
            Constraints_bids{1,i} = ...
                [Constraints_bids{1,i};
                b_g_t(g,:) == b_g_t_new(g,:)];
            Constraints_bids{1,i} = ...
                [Constraints_bids{1,i};
                u_P_g_RO(g,1) == u_P_g_RO_new(g,1)];
        end
    end
    clear g;
    for e = 1:data.E_num
        if B_E_producer(i,e) == 0
            Constraints_bids{1,i} = ...
                [Constraints_bids{1,i};
                b_e_t(e,:) == b_e_t_new(e,:)];
            Constraints_bids{1,i} = ...
                [Constraints_bids{1,i};
                u_P_e_RO(e,1) == u_P_e_RO_new(e,1)];
            Constraints_bids{1,i} = ...
                [Constraints_bids{1,i};
                u_P_e_invest(e,:) == u_P_e_invest_new(e,:)];
        end
    end
    clear e;
end
clear i;