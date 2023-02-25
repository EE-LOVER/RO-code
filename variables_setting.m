[PTDF_all,B_G_NODE,B_D_NODE,B_G_producer,B_E_NODE,B_E_producer] = ...
    get_all_matrix(data);
PTDF = PTDF_all(data.congestion_id,:);

if RO_rou_iter == 1
    u_P_g_RO_record = zeros(data.G_num,1);
    u_P_e_RO_record = zeros(data.E_num,1);
    b_g_t_record = data.G(:,4)*ones(1,data.T_num);
    b_e_t_record = data.E(:,4)*ones(1,data.T_num);
    u_P_e_invest_record = zeros(data.E_num,1);
    u_P_g_RO_new = zeros(data.G_num,1);
    u_P_e_RO_new = zeros(data.E_num,1);
    b_g_t_new = data.G(:,4)*ones(1,data.T_num);
    b_e_t_new = data.E(:,4)*ones(1,data.T_num);
    u_P_e_invest_new = zeros(data.E_num,data.E_discrete_num);
else
    u_P_g_RO_record = save_P_g_RO{K_iter,RO_rou_iter-1};
    u_P_e_RO_record = save_P_e_RO{K_iter,RO_rou_iter-1};
    b_g_t_record = save_b_g_t{K_iter,RO_rou_iter-1};
    b_e_t_record = save_b_e_t{K_iter,RO_rou_iter-1};
    u_P_e_invest_record = save_P_e_invest{K_iter,RO_rou_iter-1};
    u_P_g_RO_new = save_P_g_RO{K_iter,RO_rou_iter-1};
    u_P_e_RO_new = save_P_e_RO{K_iter,RO_rou_iter-1};
    b_g_t_new = save_b_g_t{K_iter,RO_rou_iter-1};
    b_e_t_new = save_b_e_t{K_iter,RO_rou_iter-1};
    u_P_e_invest_new = save_P_e_invest{K_iter,RO_rou_iter-1};
end

%% 原变量
%报价变量/RO参与量/容量投资
b_g_t = sdpvar(data.G_num,data.T_num,'full');
b_e_t = sdpvar(data.E_num,data.T_num,'full');
u_P_g_RO = binvar(data.G_num,1,'full');
u_P_e_RO = binvar(data.E_num,1,'full');
u_P_e_invest = binvar(data.E_num,data.E_discrete_num,'full');
%下层变量(现货市场)
P_g_t = sdpvar(data.G_num,data.T_num,'full');
P_e_t = sdpvar(data.E_num,data.T_num,'full');
P_d_t = sdpvar(data.D_num,data.T_num,'full');

lambda_t = sdpvar(1,data.T_num,'full');
tao_g_t_min = sdpvar(data.G_num,data.T_num,'full');
tao_g_t_max = sdpvar(data.G_num,data.T_num,'full');
tao_e_t_min = sdpvar(data.E_num,data.T_num,'full');
tao_e_t_max = sdpvar(data.E_num,data.T_num,'full');
tao_d_t_min = sdpvar(data.D_num,data.T_num,'full');
tao_d_t_max = sdpvar(data.D_num,data.T_num,'full');
mu_f_t_max = sdpvar(data.congestion_num,data.T_num,'full');
mu_f_t_min = sdpvar(data.congestion_num,data.T_num,'full');
%% 互补均衡约束大M法辅助01变量
u_tao_g_t_min = binvar(data.G_num,data.T_num,'full');
u_tao_g_t_max = binvar(data.G_num,data.T_num,'full');
u_tao_e_t_min = binvar(data.E_num,data.T_num,'full');
u_tao_e_t_max = binvar(data.E_num,data.T_num,'full');
u_tao_d_t_min = binvar(data.D_num,data.T_num,'full');
u_tao_d_t_max = binvar(data.D_num,data.T_num,'full');
u_mu_f_t_max = binvar(data.congestion_num,data.T_num,'full');
u_mu_f_t_min = binvar(data.congestion_num,data.T_num,'full');
%% 目标函数线性化变量
% 非线性函数

u_g_t_rou_G = binvar(data.G_num,data.T_num,'full');
y_g_t_rou_G = sdpvar(data.G_num,data.T_num,'full');
z_g_t_rou_G = sdpvar(data.G_num,data.T_num,'full');

u_e_t_rou_E = binvar(data.E_num,data.T_num,'full');
u_e_k_RO_invest = binvar(data.E_num,data.E_discrete_num,'full');
y_e_t_rou_E = sdpvar(data.E_num,data.T_num,'full');
z_e_t_k_rou_E = sdpvar(data.E_num,data.T_num,data.E_discrete_num,'full');

w_e_t_k_E = sdpvar(data.E_num,data.T_num,data.E_discrete_num,'full');

%final_market_clearing;