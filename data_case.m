function mpc = data_case_shanghai(K,RO_rou)
mpc.voll = 3000;
%% T_num dT
mpc.T_num = 5;
mpc.dT = [2210,3535,2985,25,5];
%% bus_num
mpc.bus_num = 27;
%% producer
mpc.producer_num = 10;
mpc.strategy_producer_id = [1,2,3,5,6,7,9,10];
mpc.order_id = [1,5,6,2,3,7,9,10];
%% G data
% Gnum
mpc.G_num = 10;
%	bus	producer epsilon a pmax
mpc.G = [
    1   1   0.0001 12 800;
	2   2   0.0001 10 1000;
	3   3   0.0001 10 1000;
    8   4   0.0001 0 1500;
	9   5   0.0001 12 800;
    11  6   0.0001 12 800;
	18  7   0.0001 10 1000;
    19  8   0.0001 0 1500;
	20  9   0.0001 8 1200;
    25  10   0.0001 8 1200;
];
%% E data
% Enum
% mpc.E_num = 4;
mpc.E_num = 8;
mpc.E_discrete_num = 5;
%	bus	producer a b pmax Investment_cost
% mpc.E = [
%     8   4   0.0001 30 2000 180000;
% 	18  7   0.0001 30 2000 180000;
% 	20  9   0.0001 30 2000 180000;
%     25  10   0.0001 30 2000 180000;
% ];
mpc.E = [
    1   1   0.0001 12 800 125000;
	2   2   0.0001 10 1000 160000;
	3   3   0.0001 10 1000 160000;
	9   5   0.0001 12 800 125000;
    11  6   0.0001 12 800 125000;
	18  7   0.0001 10 1000 160000;
	20  9   0.0001 8 1200 200000;
    25  10   0.0001 8 1200 200000;
];
%% D data
% Dnum
mpc.D_num = 15;
%	bus
mpc.D_bus = [
    4;5;6;7;10;12;14;15;16;17;22;23;24;26;27
    ];
mpc.D_P = [345;490;1000;160;960;230;150;150;425;350;850;780;760;135;130]*...
    [0.7 1 1.5 1.7 2];
%% branch data
% branchnum
mpc.branch_num = 31;
% mpc.congestion_num = 2;
% mpc.congestion_id = [7,17];
mpc.congestion_num = 31;
mpc.congestion_id = 1:31;
%	fbus	tbus   x    pmax
mpc.branch = [
	1	4	0.00126     4600;
    19	16	0.000045    3000;
    6	2	0.00049     4800;
    3	6	0.0005      4800;
    24	21	0.0021      1920;
    16	21	0.00402     2720;
    20	22	0.00048     3600;
    25	22	0.0005      3640;
    24	22	0.00207     1920;
    16	22	0.00402     2720;
    5	6	0.00108     2920;
    6	7	0.00111     3580;
    26	23	0.00059     1140;
    27	23	0.00066     1140;
    4	13	0.00521     2720;
    4	10	0.0052      2720;
    4	5	0.00128     5440;
    10	11	0.00109     4720;
    12	11	0.0007      3520;
    23	24	0.00036     2920;
    23	16	0.00178     5440;
    10	8	0.00039     5440;
    18	17	0.0007      2900;
    13	16	0.0038      3540;
    10	16	0.00375     3540;
    17	20	0.00112     2900;
    14	17	0.00056     1140;
    15	17	0.0006      1140;
    12	5	0.00057     3520;
    9	17	0.00168     1780;
    7	17	0.00166     1780;
];
%% RO市场信息
mpc.K = K;
mpc.RO_rou = RO_rou; 