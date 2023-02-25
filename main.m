clear;
clc;
warning('off');
K_num = 21;
K_choose = 10:30;
RO_rou_num = 101;
RO_rou_choose = linspace(0,200000,RO_rou_num);

save_P_g_RO = cell(K_num,RO_rou_num);
save_P_e_RO = cell(K_num,RO_rou_num);
save_P_e_invest = cell(K_num,RO_rou_num);
save_b_g_t = cell(K_num,RO_rou_num);
save_b_e_t = cell(K_num,RO_rou_num);
save_LMP = cell(K_num,RO_rou_num);
save_rou_U = cell(K_num,RO_rou_num);
save_SM_income = cell(K_num,RO_rou_num);
save_fuel_cost = cell(K_num,RO_rou_num);
save_RO_income = cell(K_num,RO_rou_num);
save_RO_return = cell(K_num,RO_rou_num);
save_D_buy = cell(K_num,RO_rou_num);
save_D_voll = cell(K_num,RO_rou_num);
save_D_OF = cell(K_num,RO_rou_num);
save_D_RE = cell(K_num,RO_rou_num);
save_Strategy_convergence_error = cell(K_num,RO_rou_num);
save_D_total_cost = cell(K_num,RO_rou_num);
save_producer_total_income = cell(K_num,RO_rou_num);
save_judge_error = cell(K_num,RO_rou_num);
save_D_buy_sum = cell(K_num,RO_rou_num);
save_D_voll_sum = cell(K_num,RO_rou_num);
save_D_OF_sum = cell(K_num,RO_rou_num);
save_D_RE_sum = cell(K_num,RO_rou_num);
save_D_total_cost_sum = cell(K_num,RO_rou_num);
M_choose = [20000 40000 60000 80000 100000];
for K_iter = 1:K_num
    for RO_rou_iter = 1:RO_rou_num
        M_id = 1;
        save_Strategy_convergence_error{K_iter,RO_rou_iter} = 1;
        while save_Strategy_convergence_error{K_iter,RO_rou_iter} > 0 && M_id <= 5
            M = M_choose(M_id);
            disp(['K:',num2str(K_choose(K_iter)),' ',...
                'RO_rou:',num2str(RO_rou_choose(RO_rou_iter))]);
            data = data_case(K_choose(K_iter),RO_rou_choose(RO_rou_iter));
            dynamic_game_iteration;
            final_market_clearing;
            save_P_g_RO{K_iter,RO_rou_iter} = u_P_g_RO_new;
            save_P_e_RO{K_iter,RO_rou_iter} = u_P_e_RO_new;
            save_P_e_invest{K_iter,RO_rou_iter} = u_P_e_invest_new;
            save_b_g_t{K_iter,RO_rou_iter} = b_g_t_new;
            save_b_e_t{K_iter,RO_rou_iter} = b_e_t_new;
            save_LMP{K_iter,RO_rou_iter} = LMP;
            save_SM_income{K_iter,RO_rou_iter} = SM_income;
            save_fuel_cost{K_iter,RO_rou_iter} = fuel_cost;
            save_RO_income{K_iter,RO_rou_iter} = RO_income;
            save_RO_return{K_iter,RO_rou_iter} = RO_return;
            save_D_buy{K_iter,RO_rou_iter} = D_buy;
            save_D_OF{K_iter,RO_rou_iter} = D_OF;
            save_D_RE{K_iter,RO_rou_iter} = D_RE;
            save_D_total_cost{K_iter,RO_rou_iter} = D_total_cost;
            save_producer_total_income{K_iter,RO_rou_iter} = producer_total_income;
            save_D_voll{K_iter,RO_rou_iter} = D_voll;
            save_Strategy_convergence_error{K_iter,RO_rou_iter} = error_now;
            save_rou_U{K_iter,RO_rou_iter} = rou_U;
            save_judge_error{K_iter,RO_rou_iter} = judge_error;
            save_D_buy_sum{K_iter,RO_rou_iter} = sum(D_buy);
            save_D_voll_sum{K_iter,RO_rou_iter} = sum(D_voll);
            save_D_OF_sum{K_iter,RO_rou_iter} = sum(D_OF);
            save_D_RE_sum{K_iter,RO_rou_iter} = sum(D_RE);
            save_D_total_cost_sum{K_iter,RO_rou_iter} = sum(D_total_cost);
            M_id = M_id + 1;
        end
    end
end