%%%% Initialization template

%% Parameters
% Parameter 1
ig = 100;
c = 1;
s = 0.208;
ms = 0.106;
C_A_S = 0.0039;
C_M_S = 1.05e-4;
d = 5;

%A = [0 0 1 0; 0 0 0 1; 0 0.1e1 / C_M_S / ig ^ 2 * c 0 0; 0 -(C_M_S * ig ^ 2 + ms * s ^ 2 + C_A_S) / C_M_S / ig ^ 2 / (ms * s ^ 2 + C_A_S) * c 0 0;];
%B = [0; 0; 0.1e1 / C_M_S / ig; -0.1e1 / C_M_S / ig;];
A = [0 0 1 0; 0 0 0 1; 0 0.1e1 / C_M_S / ig ^ 2 * c -0.1e1 / C_M_S / ig ^ 2 * d 0; 0 -(C_M_S * ig ^ 2 + ms * s ^ 2 + C_A_S) / C_M_S / ig ^ 2 / (ms * s ^ 2 + C_A_S) * c 0.1e1 / C_M_S / ig ^ 2 * d 0;];
B = [0; 0; 0.1e1 / C_M_S / ig; -0.1e1 / C_M_S / ig;];
C = eye(4);
D = [0; 0; 0; 0];

sys = ss(A, B, C, D);
Q = diag([100, 1, 1, 10]);
R = 10;

k = lqr(sys, Q, R)
cT = [1, 1, 0, 0];
V = 1/(-cT*inv(A-B*k)*B)

params = [ig c s ms C_A_S C_M_S d];
clear ig c s ms C_A_S C_M_S d

%% Initial conditions
% First-Order Dynamic system 1
x1_ic = zeros(4,1);
