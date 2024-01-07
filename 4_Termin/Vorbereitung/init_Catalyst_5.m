%%%% Initialization template

%% Parameters
% Parameter 1
B_M1 = 1.89e-5; %kgm²
C_M2 = 1.89e-5; %kgm²
C_M3 = 1.89e-5; %kgm²
B_s1 = 0.1030; %kgm²
A_s2 = 0.0036; %kgm²
B_s2 = 0.0159; %kgm²
C_s2 = 0.0170; %kgm²
A_s3 = 0.0021; %kgm²
B_s3 = 0.0180; %kgm²
C_s3 = 0.0583; %kgm²
g = 9.81; %m/s²
m2 = 1.866; %kg
m3 = 2.173; %kg
i = 72;
s2 = 0.125; %m
s3 = 0.131; %m
l2 = 0.25; %m
l3 = 0.25; %m
params = [B_M1 C_M2 C_M3 B_s1 A_s2 B_s2 C_s2 A_s3 B_s3 C_s3 g m2 m3 i s2 s3 l2 l3];
clear B_M1 C_M2 C_M3 B_s1 A_s2 B_s2 C_s2 A_s3 B_s3 C_s3 g m2 m3 i s2 s3 l2 l3

%% Initial conditions
% First-Order Dynamic system 1
x1_ic = zeros(6,1);
