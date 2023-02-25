function [PTDF,B_G_NODE,B_D_NODE,B_G_producer,B_E_NODE,B_E_producer] = get_all_matrix(data)
%% 计算PTDF
B = zeros(data.bus_num,data.bus_num);
B_inv = zeros(data.bus_num,data.bus_num);
X = zeros(data.branch_num,data.bus_num);
for i = 1:data.branch_num
    B(data.branch(i,1),data.branch(i,2)) = -1/data.branch(i,3);
    B(data.branch(i,2),data.branch(i,1)) = -1/data.branch(i,3);
    B(data.branch(i,1),data.branch(i,1)) = 1/data.branch(i,3) + ...
        B(data.branch(i,1),data.branch(i,1));
    B(data.branch(i,2),data.branch(i,2)) = 1/data.branch(i,3) + ...
        B(data.branch(i,2),data.branch(i,2));
    X(i,data.branch(i,1)) = 1/data.branch(i,3);
    X(i,data.branch(i,2)) = -1/data.branch(i,3);
end
B_inv(1:data.bus_num-1,1:data.bus_num-1) = ...
    (B(1:data.bus_num-1,1:data.bus_num-1))^(-1);
PTDF = X*B_inv;

%% 计算B_G_NODE
B_G_NODE = zeros(data.bus_num,data.G_num);
for i = 1:data.G_num
    B_G_NODE(data.G(i,1),i) = 1;
end

%% 计算B_D_NODE
B_D_NODE = zeros(data.bus_num,data.D_num);
for i = 1:data.D_num
    B_D_NODE(data.D_bus(i,1),i) = 1;
end

%% 计算B_G_producer
B_G_producer = zeros(data.producer_num,data.G_num);
for i = 1:data.G_num
    B_G_producer(data.G(i,2),i) = 1;
end

%% 计算B_E_NODE
B_E_NODE = zeros(data.bus_num,data.E_num);
for i = 1:data.E_num
    B_E_NODE(data.E(i,1),i) = 1;
end

%% 计算B_G_producer
B_E_producer = zeros(data.producer_num,data.E_num);
for i = 1:data.E_num
    B_E_producer(data.E(i,2),i) = 1;
end