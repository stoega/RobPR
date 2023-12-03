%%%% Initialization template
clear

%% Parameters
% Sim params
Te = 5;    %sim time
Ts = 1e-3;  %step resoultion
% Parameter 1
m1 = 1.2;           % kg
m2 = 0.0725;        % kg
l1 = 0.3;           % m
l2 = 0.25;          % m
s1 = 0.225;         % m
s2 = 0.125;         % m
C_1_S = 0.002;      % kgm²
g = 9.81;           % m/s²
ig = 100;
C_M_S = 1.05e-4;    % kgm²     
params = [m1 m2 l1 l2 s1 s2 C_1_S g ig C_M_S];
clear m1 m2 l1 l2 s1 s2 C_1_S g ig C_M_S

%% Initial conditions
% First-Order Dynamic system 1
x1_ic = zeros(4,1);
