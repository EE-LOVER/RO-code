variables_setting;
add_cons_KKT;
add_cons_each_player;
add_objs_each_player;
add_cons_bids;
error_allow = 0;
iter_num = 0;
max_iter_num = 10;
ops = sdpsettings('solver','gurobi','verbose',0,'gurobi.MIPGap',0);
judge_error = 0;
error_now = max([max(abs(u_P_g_RO_new-u_P_g_RO_record)./data.G(:,5)),...
    max(abs(u_P_e_RO_new-u_P_e_RO_record)./data.E(:,5)),...
    max(max(abs(b_g_t_new-b_g_t_record)./(2*data.G(:,4)))),...
    max(max(abs(b_e_t_new-b_e_t_record)./(2*data.E(:,4)))),...
    max(sum(abs(u_P_e_invest_new-u_P_e_invest_record),2)./data.E(:,5))]);
while (error_now > error_allow || iter_num < 1) && iter_num < max_iter_num
    u_P_g_RO_record = u_P_g_RO_new;
    u_P_e_RO_record = u_P_e_RO_new;
    u_P_e_invest_record = u_P_e_invest_new;
    b_g_t_record = b_g_t_new;
    b_e_t_record = b_e_t_new;
    iter_num = iter_num + 1;
    for i = data.order_id
        disp(['iter_at_present:',num2str(iter_num),' ','producer_id:',num2str(i)]);
        add_cons_bids_i;
        add_cons_bids_record_i;
        add_objs_each_player_i;
        sol2 = optimize([Constraints_KKT;Constraints_for_each_player{1,i};...
            Constraints_bids{1,i},Constraints_bids_old],Objs_for_each_player{1,i},ops);
        result2 = value(Objs_for_each_player{1,i});
        sol1 = optimize([Constraints_KKT;Constraints_for_each_player{1,i};...
            Constraints_bids{1,i}],Objs_for_each_player{1,i},ops);
        result1 = value(Objs_for_each_player{1,i});
        if sol1.problem == 0 && sol2.problem == 0
            if -result1 >= -1.0001*result2
                for g = 1:data.G_num
                    if B_G_producer(i,g) == 1
                        u_P_g_RO_new(g) = roundn(value(u_P_g_RO(g)),0);
                        b_g_t_new(g,:) = roundn(value(b_g_t(g,:)),0);
                    end
                end
                clear g;
                for e = 1:data.E_num
                    if B_E_producer(i,e) == 1
                        u_P_e_RO_new(e) = roundn(value(u_P_e_RO(e)),0);
                        u_P_e_invest_new(e) = roundn(value(u_P_e_invest(e)),0);
                        b_e_t_new(e,:) = roundn(value(b_e_t(e,:)),0);
                    end
                end
                clear e;
            else
                for g = 1:data.G_num
                    if B_G_producer(i,g) == 1
                        u_P_g_RO_new(g) = roundn(u_P_g_RO_record(g),0);
                        b_g_t_new(g,:) = roundn(b_g_t_record(g,:),0);
                    end
                end
                clear g;
                for e = 1:data.E_num
                    if B_E_producer(i,e) == 1
                        u_P_e_RO_new(e) = roundn(u_P_e_RO_record(e),0);
                        u_P_e_invest_new(e) = roundn(u_P_e_invest_record(e),0);
                        b_e_t_new(e,:) = roundn(b_e_t_record(e,:),0);
                    end
                end
                clear e;
            end
        else
            error('error');
        end
    end
    final_market_clearing;
    error_now = max([max(abs(u_P_g_RO_new-u_P_g_RO_record)./data.G(:,5)),...
        max(abs(u_P_e_RO_new-u_P_e_RO_record)./data.E(:,5)),...
        max(max(abs(b_g_t_new-b_g_t_record)./(2*data.G(:,4)))),...
        max(max(abs(b_e_t_new-b_e_t_record)./(2*data.E(:,4)))),...
        max(sum(abs(u_P_e_invest_new-u_P_e_invest_record),2)./data.E(:,5))]);
    disp(['  ','iter_done:',num2str(iter_num),' ','error:',num2str(error_now)]);
end
disp(['  ','Strategy_convergence_error:',num2str(error_now)]);