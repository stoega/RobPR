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

% kinetic energy:       T = m/2 * q_dot^2
% potential energy:     V = c/2 * q^2
% damping:              R = d/2 * q_dot^2

% Lagrange:             d/dt (dT/dq_dot)' - (dT/dq)' + (dV/dq)' + (dR/dq_dot)' = Q
% equation of motion:   m*q_ddot + d*q_dot + c*q = Q

% generalized force Q is system input u
%                       m*q_ddot + d*q_dot + c*q = u

close all; clear;

run init_DSMS;

t_vec = 0:Ts:Te;    % time vector

%% simulation: state space, force on / force off
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

% state space system
sys_ss = ss(A, B, C, D);

% system input
u_vec = zeros(size(t_vec));
u_vec(t_vec>=1 & t_vec<=10) = 10;

% initial state
x0 = [0;0];

% simulation
x_ss = lsim(sys_ss,u_vec,t_vec,x0);

% visualization
figure(1)
subplot(3,1,1)
plot(t_vec, u_vec, 'LineWidth', 2)
grid on
xlabel('time in s')
ylabel('u')
set(gca, 'FontSize', 16)
subplot(3,1,2)
plot(t_vec, x_ss(:,1), 'LineWidth', 2)
hold on
plot(t_vec, x_ss(:,2), 'LineWidth', 2)
hold off
grid on
xlabel('time in s')
ylabel('x')
legend('q','q_{dot}')
set(gca, 'FontSize', 16)
subplot(3,1,3)
plotDSMS(x_ss(1:20:end,:))


%% simulation: state space, square input signal
u_vec = zeros(size(t_vec));

amplitude = 5;
period = 5;
pulsewidth = 0.2;

samples = round(period/Ts);
samples_on = round(pulsewidth*samples);

for k = 1:floor(Te/period)
    u_vec(k*samples-samples+1:k*samples-samples+samples_on) = amplitude;
end

% initial state
x0 = [0;0];

% simulation
x_ss = lsim(sys_ss,u_vec,t_vec,x0);

% visualization
figure(2)
subplot(3,1,1)
plot(t_vec, u_vec, 'LineWidth', 2)
grid on
xlabel('time in s')
ylabel('u')
set(gca, 'FontSize', 16)
subplot(3,1,2)
plot(t_vec, x_ss(:,1), 'LineWidth', 2)
hold on
plot(t_vec, x_ss(:,2), 'LineWidth', 2)
hold off
grid on
xlabel('time in s')
ylabel('x')
legend('q','q_{dot}')
set(gca, 'FontSize', 16)
subplot(3,1,3)
plotDSMS(x_ss(1:20:end,:))


%% simulation: ODE45, PD control
% error e = qd - q ... difference between desired and actual position
% u = Kp*e + Kd*e_dot = Kp*(qd - q) + Kd*(q_dot_d - q_dot) = [Kp Kd]*(xd - x)

xd = [ 0.5; 0];         % desired state: position 1, velocity 0

% simulation
[t,x_PD] = ode45(@(t,x)sysdyn(x,m,c,d,K*(xd-x)),t_vec,x0);
u_PD = K*(xd-x_PD');

% visualization
figure(3)
subplot(3,1,1)
plot(t, x_PD(:,1), 'LineWidth', 2)
hold on
plot(t, x_PD(:,2), 'LineWidth', 2)
plot(t, xd(1)*ones(size(t)), 'k--', 'LineWidth', 2)
hold off
grid on
xlabel('time in s')
ylabel('x')
l1 = legend('q','q_{dot}', 'q_d');
title(l1, 'PD control')
set(gca, 'FontSize', 16)
subplot(3,1,2)
plot(t_vec, u_PD, 'LineWidth', 2)
grid on
xlabel('time in s')
ylabel('u')
ylim([-40 40])
set(gca, 'FontSize', 16)
subplot(3,1,3)
plotDSMS(x_PD(1:20:end,:))


