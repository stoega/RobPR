%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    DAMPED SPRING MASS SYSTEM    %
%                                 %
%   |                             %
%   |     c     _______           %
%   |---^^^^---|       |          %
%   |     _    |   m   |----> u   %
%   |----|_----|_______|          %
%   |    d         |              %
%   |              |--> q         %
%                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all; clear;

m = 10;     % kg
c = 20;     % N/m
d = 10;     % Ns/m
g = 9.81;   % m/s^2

Ts = 1e-2;  % sample time
Te = 20;    % end time

% kinetic energy:       T = m/2 * q_dot^2
% potential energy:     V = c/2 * q^2
% damping:              R = d/2 * q_dot^2

% Lagrange:             d/dt (dT/dq_dot)' - (dT/dq)' + (dV/dq)' + (dR/dq_dot)' = Q
% equation of motion:   m*q_ddot + d*q_dot + c*q = Q

% generalized force Q is system input u
% equation of motion:   m*q_ddot + d*q_dot + c*q = u

% state vector      x = [q, q_dot]'
% dynamics          x_dot = A*x + B*u
% measured output   y = C*x + D*u
%
% x_dot_vec = [q_dot, q_ddot]' = [q_dot, u/m - d/m*q_dot - c/m*q]'
% y = x

A = [ 0 1 ; -c/m -d/m ];
B = [ 0 1/m ]';
C = diag([1, 1]);
D = zeros(size(C,1),size(B,2));

% initial state
x0 = [0;0];

% for the Maple-generated m-function
params = [m c d g];
x1_ic = zeros(2,1);

% PD control parameters
Kp = 500;               % proportional control gain
Kd = 50;                % derivative control gain
K  = [Kp Kd];



