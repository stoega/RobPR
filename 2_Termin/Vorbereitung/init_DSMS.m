%%%% Initialization template

%% Parameters
close all; clear;
% Parameter 1
ig = 100;
c = 1;          %Nm/rad
s = 0.208;      %m
ms = .106;      %kg
CA = .0039;     %kgm²
CM = 1.05e-4;   %kmg²

Ts = 1e-2;  % sample time
Te = 20;    % end time

A = [0 0 1 0; 0 0 0 1; 0 0.1e1 / CM / ig ^ 2 * c 0 0; 0 -(CM * ig ^ 2 + ms * s ^ 2 + CA) / CM / ig ^ 2 / (ms * s ^ 2 + CA) * c 0 0;];
B = [0; 0; 0.1e1 / CM / ig; -0.1e1 / CM / ig;];
C = diag([1, 1, 1, 1]);
D = zeros(size(C,1),size(B,2));

% initial state
x0 = [0;0;0;0];

% for the Maple-generated m-function
params = [ig c s ms CA CM];
x1_ic = zeros(4,1);

% PD control parameters
%Kp = 500;               % proportional control gain
%Kd = 50;                % derivative control gain
%K  = [Kp Kd];
