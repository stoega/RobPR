%%%% Initialization template
clear
%% Parameters
% Parameter 1
% Sim params
Te = 10;    %sim time
Ts = 1e-3;  %step resoultion
Ta = 1e-3;  %Sampling rate

% Parameter 1
m1 = 1.2;           % kg
m2 = 0.0725;        % kg
m3 = 0.0638;        %kg
l1 = 0.3;           % m
l2 = 0.25;          % m
l3 = 0.22;
s1 = 0.225;         % m
s2 = 0.125;         % m
s3 = 0.11;
C_1_S = 0.002;      % kgm²
g = 9.81;           % m/s²
ig = 100;
C_M_S = 1.05e-4;    % kgm² 
d0 = 5;
ds1 = 1e-3;
ds2 = 1e-3;
mP1 = 0.25;
mP2 = 0.18;
A_3_S = 1.6e-5;
B_3_S = 1.6e-5;

A = [0 0 0 1 0 0; 0 0 0 0 1 0; 0 0 0 0 0 1; 0 0.12e2 * l1 * g * (((l3 * mP2 + m3 * s3) ^ 2 * m2 / 0.12e2 + (mP1 + mP2 + m3) * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S)) * l2 ^ 2 + 0.2e1 * s2 * m2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * l2 + s2 ^ 2 * m2 * ((mP2 * l3 ^ 2 + m3 * s3 ^ 2 + A_3_S) * m2 + (l3 * mP2 + m3 * s3) ^ 2)) / ((l1 ^ 2 * (mP2 * l3 ^ 2 + m3 * s3 ^ 2 + A_3_S) * m2 ^ 2 + ((0.13e2 * l1 ^ 2 * (s3 - l3) ^ 2 * m3 + (ig ^ 2 * C_M_S + 0.13e2 * l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * l3 ^ 2 + 0.13e2 * A_3_S * l1 ^ 2) * mP2 + ((ig ^ 2 * C_M_S + 0.13e2 * l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * s3 ^ 2 + 0.13e2 * A_3_S * l1 ^ 2) * m3 + 0.13e2 * (C_1_S / 0.13e2 + l1 ^ 2 * mP1 + ig ^ 2 * C_M_S / 0.13e2 + m1 * s1 ^ 2 / 0.13e2) * A_3_S) * m2 + 0.12e2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * l2 ^ 2 - 0.24e2 * s2 * m2 * l1 ^ 2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * l2 + 0.12e2 * s2 ^ 2 * m2 * ((l1 ^ 2 * (s3 - l3) ^ 2 * m3 + (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * l3 ^ 2 + A_3_S * l1 ^ 2) * mP2 + ((ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * s3 ^ 2 + A_3_S * l1 ^ 2) * m3 + A_3_S * (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S))) 0.12e2 * m2 * l1 * g * (l3 * mP2 + m3 * s3) ^ 2 * (s2 ^ 2 - s2 * l2 + l2 ^ 2 / 0.12e2) / ((l1 ^ 2 * (mP2 * l3 ^ 2 + m3 * s3 ^ 2 + A_3_S) * m2 ^ 2 + ((0.13e2 * l1 ^ 2 * (s3 - l3) ^ 2 * m3 + (ig ^ 2 * C_M_S + 0.13e2 * l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * l3 ^ 2 + 0.13e2 * A_3_S * l1 ^ 2) * mP2 + ((ig ^ 2 * C_M_S + 0.13e2 * l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * s3 ^ 2 + 0.13e2 * A_3_S * l1 ^ 2) * m3 + 0.13e2 * (C_1_S / 0.13e2 + l1 ^ 2 * mP1 + ig ^ 2 * C_M_S / 0.13e2 + m1 * s1 ^ 2 / 0.13e2) * A_3_S) * m2 + 0.12e2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * l2 ^ 2 - 0.24e2 * s2 * m2 * l1 ^ 2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * l2 + 0.12e2 * s2 ^ 2 * m2 * ((l1 ^ 2 * (s3 - l3) ^ 2 * m3 + (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * l3 ^ 2 + A_3_S * l1 ^ 2) * mP2 + ((ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * s3 ^ 2 + A_3_S * l1 ^ 2) * m3 + A_3_S * (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S))) -0.12e2 * (((mP2 * l3 ^ 2 + m3 * s3 ^ 2 + A_3_S) * m2 / 0.12e2 + ((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * l2 ^ 2 + m2 * s2 ^ 2 * (mP2 * l3 ^ 2 + m3 * s3 ^ 2 + A_3_S)) * d0 / ((l1 ^ 2 * (mP2 * l3 ^ 2 + m3 * s3 ^ 2 + A_3_S) * m2 ^ 2 + 0.13e2 * ((l1 ^ 2 * (s3 - l3) ^ 2 * m3 + A_3_S * l1 ^ 2 + (C_1_S / 0.13e2 + l1 ^ 2 * mP1 + ig ^ 2 * C_M_S / 0.13e2 + m1 * s1 ^ 2 / 0.13e2) * l3 ^ 2) * mP2 + (A_3_S * l1 ^ 2 + (C_1_S / 0.13e2 + l1 ^ 2 * mP1 + ig ^ 2 * C_M_S / 0.13e2 + m1 * s1 ^ 2 / 0.13e2) * s3 ^ 2) * m3 + (C_1_S / 0.13e2 + l1 ^ 2 * mP1 + ig ^ 2 * C_M_S / 0.13e2 + m1 * s1 ^ 2 / 0.13e2) * A_3_S) * m2 + 0.12e2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * l2 ^ 2 - 0.24e2 * s2 * m2 * l1 ^ 2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * l2 + 0.12e2 * s2 ^ 2 * m2 * ((l1 ^ 2 * (s3 - l3) ^ 2 * m3 + (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * l3 ^ 2 + A_3_S * l1 ^ 2) * mP2 + ((ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * s3 ^ 2 + A_3_S * l1 ^ 2) * m3 + A_3_S * (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S))) -0.12e2 * l1 * ((((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * l2 + s2 * m2 * (mP2 * l3 ^ 2 + m3 * s3 ^ 2 + A_3_S)) * ds1 / ((l1 ^ 2 * (mP2 * l3 ^ 2 + m3 * s3 ^ 2 + A_3_S) * m2 ^ 2 + ((0.13e2 * l1 ^ 2 * (s3 - l3) ^ 2 * m3 + (ig ^ 2 * C_M_S + 0.13e2 * l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * l3 ^ 2 + 0.13e2 * A_3_S * l1 ^ 2) * mP2 + ((ig ^ 2 * C_M_S + 0.13e2 * l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * s3 ^ 2 + 0.13e2 * A_3_S * l1 ^ 2) * m3 + A_3_S * (ig ^ 2 * C_M_S + 0.13e2 * l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S)) * m2 + 0.12e2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * l2 ^ 2 - 0.24e2 * s2 * m2 * l1 ^ 2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * l2 + 0.12e2 * s2 ^ 2 * m2 * ((l1 ^ 2 * (s3 - l3) ^ 2 * m3 + (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * l3 ^ 2 + A_3_S * l1 ^ 2) * mP2 + ((ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * s3 ^ 2 + A_3_S * l1 ^ 2) * m3 + A_3_S * (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S))) 0.12e2 * (-m2 * (l3 * mP2 + m3 * s3) * l2 ^ 2 / 0.12e2 + (s2 * (l3 * mP2 + m3 * s3) * m2 + ((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * l2 + m2 * (l3 * (l3 - s2) * mP2 + s3 * (s3 - s2) * m3 + A_3_S) * s2) * l1 * ds2 / ((l1 ^ 2 * (mP2 * l3 ^ 2 + m3 * s3 ^ 2 + A_3_S) * m2 ^ 2 + ((0.13e2 * l1 ^ 2 * (s3 - l3) ^ 2 * m3 + (ig ^ 2 * C_M_S + 0.13e2 * l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * l3 ^ 2 + 0.13e2 * A_3_S * l1 ^ 2) * mP2 + ((ig ^ 2 * C_M_S + 0.13e2 * l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * s3 ^ 2 + 0.13e2 * A_3_S * l1 ^ 2) * m3 + A_3_S * (ig ^ 2 * C_M_S + 0.13e2 * l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S)) * m2 + 0.12e2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * l2 ^ 2 - 0.24e2 * s2 * m2 * l1 ^ 2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * l2 + 0.12e2 * s2 ^ 2 * m2 * ((l1 ^ 2 * (s3 - l3) ^ 2 * m3 + (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * l3 ^ 2 + A_3_S * l1 ^ 2) * mP2 + ((ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * s3 ^ 2 + A_3_S * l1 ^ 2) * m3 + A_3_S * (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S))); 0 0.12e2 * ((((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * l2 + s2 * m2 * (mP2 * l3 ^ 2 + m3 * s3 ^ 2 + A_3_S)) * (ig ^ 2 * C_M_S + l1 ^ 2 * m2 + l1 ^ 2 * m3 + l1 ^ 2 * mP1 + mP2 * l1 ^ 2 + m1 * s1 ^ 2 + C_1_S) * g / ((l1 ^ 2 * (mP2 * l3 ^ 2 + m3 * s3 ^ 2 + A_3_S) * m2 ^ 2 + ((0.13e2 * l1 ^ 2 * (s3 - l3) ^ 2 * m3 + 0.13e2 * (mP1 * l3 ^ 2 + A_3_S) * l1 ^ 2 + l3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * mP2 + (0.13e2 * (mP1 * s3 ^ 2 + A_3_S) * l1 ^ 2 + s3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * m3 + 0.13e2 * (C_1_S / 0.13e2 + l1 ^ 2 * mP1 + ig ^ 2 * C_M_S / 0.13e2 + m1 * s1 ^ 2 / 0.13e2) * A_3_S) * m2 + 0.12e2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * l2 ^ 2 - 0.24e2 * s2 * m2 * l1 ^ 2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * l2 + 0.12e2 * s2 ^ 2 * m2 * ((l1 ^ 2 * (s3 - l3) ^ 2 * m3 + (mP1 * l3 ^ 2 + A_3_S) * l1 ^ 2 + l3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * mP2 + ((mP1 * s3 ^ 2 + A_3_S) * l1 ^ 2 + s3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * m3 + A_3_S * (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S))) 0.12e2 * g * ((-ig ^ 2 * C_M_S - l1 ^ 2 * m2 - m1 * s1 ^ 2 - C_1_S) * l2 + s2 * l1 ^ 2 * m2) * (l3 * mP2 + m3 * s3) ^ 2 / ((l1 ^ 2 * (mP2 * l3 ^ 2 + m3 * s3 ^ 2 + A_3_S) * m2 ^ 2 + ((0.13e2 * l1 ^ 2 * (s3 - l3) ^ 2 * m3 + 0.13e2 * (mP1 * l3 ^ 2 + A_3_S) * l1 ^ 2 + l3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * mP2 + (0.13e2 * (mP1 * s3 ^ 2 + A_3_S) * l1 ^ 2 + s3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * m3 + 0.13e2 * (C_1_S / 0.13e2 + l1 ^ 2 * mP1 + ig ^ 2 * C_M_S / 0.13e2 + m1 * s1 ^ 2 / 0.13e2) * A_3_S) * m2 + 0.12e2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * l2 ^ 2 - 0.24e2 * s2 * m2 * l1 ^ 2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * l2 + 0.12e2 * s2 ^ 2 * m2 * ((l1 ^ 2 * (s3 - l3) ^ 2 * m3 + (mP1 * l3 ^ 2 + A_3_S) * l1 ^ 2 + l3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * mP2 + ((mP1 * s3 ^ 2 + A_3_S) * l1 ^ 2 + s3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * m3 + A_3_S * (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S))) -0.12e2 * ((((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * l2 + s2 * m2 * (mP2 * l3 ^ 2 + m3 * s3 ^ 2 + A_3_S)) * l1 * d0 / ((l1 ^ 2 * (mP2 * l3 ^ 2 + m3 * s3 ^ 2 + A_3_S) * m2 ^ 2 + 0.13e2 * ((l1 ^ 2 * (s3 - l3) ^ 2 * m3 + A_3_S * l1 ^ 2 + (C_1_S / 0.13e2 + l1 ^ 2 * mP1 + ig ^ 2 * C_M_S / 0.13e2 + m1 * s1 ^ 2 / 0.13e2) * l3 ^ 2) * mP2 + (A_3_S * l1 ^ 2 + (C_1_S / 0.13e2 + l1 ^ 2 * mP1 + ig ^ 2 * C_M_S / 0.13e2 + m1 * s1 ^ 2 / 0.13e2) * s3 ^ 2) * m3 + (C_1_S / 0.13e2 + l1 ^ 2 * mP1 + ig ^ 2 * C_M_S / 0.13e2 + m1 * s1 ^ 2 / 0.13e2) * A_3_S) * m2 + 0.12e2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * l2 ^ 2 - 0.24e2 * s2 * m2 * l1 ^ 2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * l2 + 0.12e2 * s2 ^ 2 * m2 * ((l1 ^ 2 * (s3 - l3) ^ 2 * m3 + (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * l3 ^ 2 + A_3_S * l1 ^ 2) * mP2 + ((ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * s3 ^ 2 + A_3_S * l1 ^ 2) * m3 + A_3_S * (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S))) -0.12e2 * (l1 ^ 2 * (mP2 * l3 ^ 2 + m3 * s3 ^ 2 + A_3_S) * m2 + (l1 ^ 2 * (s3 - l3) ^ 2 * m3 + (mP1 * l3 ^ 2 + A_3_S) * l1 ^ 2 + l3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * mP2 + ((mP1 * s3 ^ 2 + A_3_S) * l1 ^ 2 + s3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * m3 + A_3_S * (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S)) * ds1 / ((l1 ^ 2 * (mP2 * l3 ^ 2 + m3 * s3 ^ 2 + A_3_S) * m2 ^ 2 + ((0.13e2 * l1 ^ 2 * (s3 - l3) ^ 2 * m3 + 0.13e2 * (mP1 * l3 ^ 2 + A_3_S) * l1 ^ 2 + l3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * mP2 + (0.13e2 * (mP1 * s3 ^ 2 + A_3_S) * l1 ^ 2 + s3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * m3 + A_3_S * (ig ^ 2 * C_M_S + 0.13e2 * l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S)) * m2 + 0.12e2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * l2 ^ 2 - 0.24e2 * s2 * m2 * l1 ^ 2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * l2 + 0.12e2 * s2 ^ 2 * m2 * ((l1 ^ 2 * (s3 - l3) ^ 2 * m3 + (mP1 * l3 ^ 2 + A_3_S) * l1 ^ 2 + l3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * mP2 + ((mP1 * s3 ^ 2 + A_3_S) * l1 ^ 2 + s3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * m3 + A_3_S * (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S))) 0.12e2 * ((ig ^ 2 * C_M_S + l1 ^ 2 * m2 + m1 * s1 ^ 2 + C_1_S) * (l3 * mP2 + m3 * s3) * l2 + l1 ^ 2 * (l3 * (l3 - s2) * mP2 + s3 * (s3 - s2) * m3 + A_3_S) * m2 + (l1 ^ 2 * (s3 - l3) ^ 2 * m3 + (mP1 * l3 ^ 2 + A_3_S) * l1 ^ 2 + l3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * mP2 + ((mP1 * s3 ^ 2 + A_3_S) * l1 ^ 2 + s3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * m3 + A_3_S * (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S)) * ds2 / ((l1 ^ 2 * (mP2 * l3 ^ 2 + m3 * s3 ^ 2 + A_3_S) * m2 ^ 2 + ((0.13e2 * l1 ^ 2 * (s3 - l3) ^ 2 * m3 + 0.13e2 * (mP1 * l3 ^ 2 + A_3_S) * l1 ^ 2 + l3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * mP2 + (0.13e2 * (mP1 * s3 ^ 2 + A_3_S) * l1 ^ 2 + s3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * m3 + A_3_S * (ig ^ 2 * C_M_S + 0.13e2 * l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S)) * m2 + 0.12e2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * l2 ^ 2 - 0.24e2 * s2 * m2 * l1 ^ 2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * l2 + 0.12e2 * s2 ^ 2 * m2 * ((l1 ^ 2 * (s3 - l3) ^ 2 * m3 + (mP1 * l3 ^ 2 + A_3_S) * l1 ^ 2 + l3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * mP2 + ((mP1 * s3 ^ 2 + A_3_S) * l1 ^ 2 + s3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * m3 + A_3_S * (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S))); 0 0.12e2 * (ig ^ 2 * C_M_S + l1 ^ 2 * m2 + l1 ^ 2 * m3 + l1 ^ 2 * mP1 + mP2 * l1 ^ 2 + m1 * s1 ^ 2 + C_1_S) * g * (m2 * (l3 * mP2 + m3 * s3) * l2 ^ 2 / 0.12e2 + (-s2 * (l3 * mP2 + m3 * s3) * m2 + (-(s3 - l3) ^ 2 * m3 - mP1 * l3 ^ 2 - A_3_S) * mP2 + (-mP1 * s3 ^ 2 - A_3_S) * m3 - mP1 * A_3_S) * l2 + (l3 * (s2 - l3) * mP2 + s3 * (s2 - s3) * m3 - A_3_S) * s2 * m2) / ((l1 ^ 2 * (mP2 * l3 ^ 2 + m3 * s3 ^ 2 + A_3_S) * m2 ^ 2 + ((0.13e2 * l1 ^ 2 * (s3 - l3) ^ 2 * m3 + (ig ^ 2 * C_M_S + 0.13e2 * l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * l3 ^ 2 + 0.13e2 * A_3_S * l1 ^ 2) * mP2 + ((ig ^ 2 * C_M_S + 0.13e2 * l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * s3 ^ 2 + 0.13e2 * A_3_S * l1 ^ 2) * m3 + 0.13e2 * (C_1_S / 0.13e2 + l1 ^ 2 * mP1 + ig ^ 2 * C_M_S / 0.13e2 + m1 * s1 ^ 2 / 0.13e2) * A_3_S) * m2 + 0.12e2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * l2 ^ 2 - 0.24e2 * s2 * m2 * l1 ^ 2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * l2 + 0.12e2 * s2 ^ 2 * m2 * ((l1 ^ 2 * (s3 - l3) ^ 2 * m3 + (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * l3 ^ 2 + A_3_S * l1 ^ 2) * mP2 + ((ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * s3 ^ 2 + A_3_S * l1 ^ 2) * m3 + A_3_S * (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S))) 0.12e2 * g * ((l1 ^ 2 * m2 ^ 2 / 0.12e2 + (ig ^ 2 * C_M_S + 0.13e2 * l1 ^ 2 * m3 + 0.13e2 * l1 ^ 2 * mP1 + 0.13e2 * mP2 * l1 ^ 2 + m1 * s1 ^ 2 + C_1_S) * m2 / 0.12e2 + (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S) * (mP1 + mP2 + m3)) * l2 ^ 2 + (-0.2e1 * l1 ^ 2 * ((s2 - l3 / 0.2e1) * mP2 + (s2 - s3 / 0.2e1) * m3 + s2 * mP1) * m2 + (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S) * (l3 * mP2 + m3 * s3)) * l2 + s2 * m2 * (l1 ^ 2 * (s2 - l3) * mP2 + l1 ^ 2 * (s2 - s3) * m3 + s2 * (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S))) * (l3 * mP2 + m3 * s3) / ((l1 ^ 2 * (mP2 * l3 ^ 2 + m3 * s3 ^ 2 + A_3_S) * m2 ^ 2 + ((0.13e2 * l1 ^ 2 * (s3 - l3) ^ 2 * m3 + 0.13e2 * (mP1 * l3 ^ 2 + A_3_S) * l1 ^ 2 + l3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * mP2 + (0.13e2 * (mP1 * s3 ^ 2 + A_3_S) * l1 ^ 2 + s3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * m3 + 0.13e2 * (C_1_S / 0.13e2 + l1 ^ 2 * mP1 + ig ^ 2 * C_M_S / 0.13e2 + m1 * s1 ^ 2 / 0.13e2) * A_3_S) * m2 + 0.12e2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * l2 ^ 2 - 0.24e2 * s2 * m2 * l1 ^ 2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * l2 + 0.12e2 * s2 ^ 2 * m2 * ((l1 ^ 2 * (s3 - l3) ^ 2 * m3 + (mP1 * l3 ^ 2 + A_3_S) * l1 ^ 2 + l3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * mP2 + ((mP1 * s3 ^ 2 + A_3_S) * l1 ^ 2 + s3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * m3 + A_3_S * (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S))) -0.12e2 * (m2 * (l3 * mP2 + m3 * s3) * l2 ^ 2 / 0.12e2 + (-s2 * (l3 * mP2 + m3 * s3) * m2 + (-(s3 - l3) ^ 2 * m3 - mP1 * l3 ^ 2 - A_3_S) * mP2 + (-mP1 * s3 ^ 2 - A_3_S) * m3 - mP1 * A_3_S) * l2 + (l3 * (s2 - l3) * mP2 + s3 * (s2 - s3) * m3 - A_3_S) * s2 * m2) * l1 * d0 / ((l1 ^ 2 * (mP2 * l3 ^ 2 + m3 * s3 ^ 2 + A_3_S) * m2 ^ 2 + ((0.13e2 * l1 ^ 2 * (s3 - l3) ^ 2 * m3 + (ig ^ 2 * C_M_S + 0.13e2 * l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * l3 ^ 2 + 0.13e2 * A_3_S * l1 ^ 2) * mP2 + ((ig ^ 2 * C_M_S + 0.13e2 * l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * s3 ^ 2 + 0.13e2 * A_3_S * l1 ^ 2) * m3 + 0.13e2 * (C_1_S / 0.13e2 + l1 ^ 2 * mP1 + ig ^ 2 * C_M_S / 0.13e2 + m1 * s1 ^ 2 / 0.13e2) * A_3_S) * m2 + 0.12e2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * l2 ^ 2 - 0.24e2 * s2 * m2 * l1 ^ 2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * l2 + 0.12e2 * s2 ^ 2 * m2 * ((l1 ^ 2 * (s3 - l3) ^ 2 * m3 + (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * l3 ^ 2 + A_3_S * l1 ^ 2) * mP2 + ((ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * s3 ^ 2 + A_3_S * l1 ^ 2) * m3 + A_3_S * (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S))) 0.12e2 * ((ig ^ 2 * C_M_S + l1 ^ 2 * m2 + m1 * s1 ^ 2 + C_1_S) * (l3 * mP2 + m3 * s3) * l2 + l1 ^ 2 * (l3 * (l3 - s2) * mP2 + s3 * (s3 - s2) * m3 + A_3_S) * m2 + (l1 ^ 2 * (s3 - l3) ^ 2 * m3 + (mP1 * l3 ^ 2 + A_3_S) * l1 ^ 2 + l3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * mP2 + ((mP1 * s3 ^ 2 + A_3_S) * l1 ^ 2 + s3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * m3 + A_3_S * (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S)) * ds1 / ((l1 ^ 2 * (mP2 * l3 ^ 2 + m3 * s3 ^ 2 + A_3_S) * m2 ^ 2 + ((0.13e2 * l1 ^ 2 * (s3 - l3) ^ 2 * m3 + 0.13e2 * (mP1 * l3 ^ 2 + A_3_S) * l1 ^ 2 + l3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * mP2 + (0.13e2 * (mP1 * s3 ^ 2 + A_3_S) * l1 ^ 2 + s3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * m3 + A_3_S * (ig ^ 2 * C_M_S + 0.13e2 * l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S)) * m2 + 0.12e2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * l2 ^ 2 - 0.24e2 * s2 * m2 * l1 ^ 2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * l2 + 0.12e2 * s2 ^ 2 * m2 * ((l1 ^ 2 * (s3 - l3) ^ 2 * m3 + (mP1 * l3 ^ 2 + A_3_S) * l1 ^ 2 + l3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * mP2 + ((mP1 * s3 ^ 2 + A_3_S) * l1 ^ 2 + s3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * m3 + A_3_S * (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S))) -0.12e2 * ((l1 ^ 2 * m2 ^ 2 / 0.12e2 + (ig ^ 2 * C_M_S + 0.13e2 * l1 ^ 2 * m3 + 0.13e2 * l1 ^ 2 * mP1 + 0.13e2 * mP2 * l1 ^ 2 + m1 * s1 ^ 2 + C_1_S) * m2 / 0.12e2 + (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S) * (mP1 + mP2 + m3)) * l2 ^ 2 + 0.2e1 * (l1 ^ 2 * ((l3 - s2) * mP2 + (s3 - s2) * m3 - s2 * mP1) * m2 + (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S) * (l3 * mP2 + m3 * s3)) * l2 + (l1 ^ 2 * (l3 - s2) ^ 2 * mP2 + l1 ^ 2 * (s3 - s2) ^ 2 * m3 + (mP1 * s2 ^ 2 + A_3_S) * l1 ^ 2 + s2 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * m2 + (l1 ^ 2 * (s3 - l3) ^ 2 * m3 + (mP1 * l3 ^ 2 + A_3_S) * l1 ^ 2 + l3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * mP2 + ((mP1 * s3 ^ 2 + A_3_S) * l1 ^ 2 + s3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * m3 + A_3_S * (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S)) * ds2 / ((l1 ^ 2 * (mP2 * l3 ^ 2 + m3 * s3 ^ 2 + A_3_S) * m2 ^ 2 + ((0.13e2 * l1 ^ 2 * (s3 - l3) ^ 2 * m3 + 0.13e2 * (mP1 * l3 ^ 2 + A_3_S) * l1 ^ 2 + l3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * mP2 + (0.13e2 * (mP1 * s3 ^ 2 + A_3_S) * l1 ^ 2 + s3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * m3 + A_3_S * (ig ^ 2 * C_M_S + 0.13e2 * l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S)) * m2 + 0.12e2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * l2 ^ 2 - 0.24e2 * s2 * m2 * l1 ^ 2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * l2 + 0.12e2 * s2 ^ 2 * m2 * ((l1 ^ 2 * (s3 - l3) ^ 2 * m3 + (mP1 * l3 ^ 2 + A_3_S) * l1 ^ 2 + l3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * mP2 + ((mP1 * s3 ^ 2 + A_3_S) * l1 ^ 2 + s3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * m3 + A_3_S * (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S)));];
B = [0 0 0; 0 0 0; 0 0 0; 0.12e2 * ig * (((mP2 * l3 ^ 2 + m3 * s3 ^ 2 + A_3_S) * m2 / 0.12e2 + ((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * l2 ^ 2 + m2 * s2 ^ 2 * (mP2 * l3 ^ 2 + m3 * s3 ^ 2 + A_3_S)) / ((l1 ^ 2 * (mP2 * l3 ^ 2 + m3 * s3 ^ 2 + A_3_S) * m2 ^ 2 + ((0.13e2 * l1 ^ 2 * (s3 - l3) ^ 2 * m3 + (ig ^ 2 * C_M_S + 0.13e2 * l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * l3 ^ 2 + 0.13e2 * A_3_S * l1 ^ 2) * mP2 + ((ig ^ 2 * C_M_S + 0.13e2 * l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * s3 ^ 2 + 0.13e2 * A_3_S * l1 ^ 2) * m3 + A_3_S * (ig ^ 2 * C_M_S + 0.13e2 * l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S)) * m2 + 0.12e2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * l2 ^ 2 - 0.24e2 * s2 * m2 * l1 ^ 2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * l2 + 0.12e2 * s2 ^ 2 * m2 * ((l1 ^ 2 * (s3 - l3) ^ 2 * m3 + (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * l3 ^ 2 + A_3_S * l1 ^ 2) * mP2 + ((ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * s3 ^ 2 + A_3_S * l1 ^ 2) * m3 + A_3_S * (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S))) l1 * m2 * (l2 ^ 2 - 0.12e2 * s2 * l2 + 0.12e2 * s2 ^ 2) * (mP2 * l3 ^ 2 + m3 * s3 ^ 2 + A_3_S) / ((l1 ^ 2 * (mP2 * l3 ^ 2 + m3 * s3 ^ 2 + A_3_S) * m2 ^ 2 + ((0.13e2 * l1 ^ 2 * (s3 - l3) ^ 2 * m3 + (ig ^ 2 * C_M_S + 0.13e2 * l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * l3 ^ 2 + 0.13e2 * A_3_S * l1 ^ 2) * mP2 + ((ig ^ 2 * C_M_S + 0.13e2 * l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * s3 ^ 2 + 0.13e2 * A_3_S * l1 ^ 2) * m3 + A_3_S * (ig ^ 2 * C_M_S + 0.13e2 * l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S)) * m2 + 0.12e2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * l2 ^ 2 - 0.24e2 * s2 * m2 * l1 ^ 2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * l2 + 0.12e2 * s2 ^ 2 * m2 * ((l1 ^ 2 * (s3 - l3) ^ 2 * m3 + (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * l3 ^ 2 + A_3_S * l1 ^ 2) * mP2 + ((ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * s3 ^ 2 + A_3_S * l1 ^ 2) * m3 + A_3_S * (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S))) m2 * l1 * (s3 * (s3 - l3) * m3 + A_3_S) * (l2 ^ 2 - 0.12e2 * s2 * l2 + 0.12e2 * s2 ^ 2) / ((l1 ^ 2 * (mP2 * l3 ^ 2 + m3 * s3 ^ 2 + A_3_S) * m2 ^ 2 + ((0.13e2 * l1 ^ 2 * (s3 - l3) ^ 2 * mP2 + (ig ^ 2 * C_M_S + 0.13e2 * l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * s3 ^ 2 + 0.13e2 * A_3_S * l1 ^ 2) * m3 + (0.13e2 * A_3_S * l1 ^ 2 + (ig ^ 2 * C_M_S + 0.13e2 * l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * l3 ^ 2) * mP2 + A_3_S * (ig ^ 2 * C_M_S + 0.13e2 * l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S)) * m2 + 0.12e2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S) * (((s3 - l3) ^ 2 * mP2 + mP1 * s3 ^ 2 + A_3_S) * m3 + (mP1 * l3 ^ 2 + A_3_S) * mP2 + mP1 * A_3_S)) * l2 ^ 2 - 0.24e2 * m2 * l1 ^ 2 * s2 * (((s3 - l3) ^ 2 * mP2 + mP1 * s3 ^ 2 + A_3_S) * m3 + (mP1 * l3 ^ 2 + A_3_S) * mP2 + mP1 * A_3_S) * l2 + 0.12e2 * m2 * ((l1 ^ 2 * (s3 - l3) ^ 2 * mP2 + (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * s3 ^ 2 + A_3_S * l1 ^ 2) * m3 + (A_3_S * l1 ^ 2 + (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * l3 ^ 2) * mP2 + A_3_S * (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S)) * s2 ^ 2); 0.12e2 * l1 * ((((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * l2 + s2 * m2 * (mP2 * l3 ^ 2 + m3 * s3 ^ 2 + A_3_S)) * ig / ((l1 ^ 2 * (mP2 * l3 ^ 2 + m3 * s3 ^ 2 + A_3_S) * m2 ^ 2 + ((0.13e2 * l1 ^ 2 * (s3 - l3) ^ 2 * m3 + (ig ^ 2 * C_M_S + 0.13e2 * l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * l3 ^ 2 + 0.13e2 * A_3_S * l1 ^ 2) * mP2 + ((ig ^ 2 * C_M_S + 0.13e2 * l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * s3 ^ 2 + 0.13e2 * A_3_S * l1 ^ 2) * m3 + A_3_S * (ig ^ 2 * C_M_S + 0.13e2 * l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S)) * m2 + 0.12e2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * l2 ^ 2 - 0.24e2 * s2 * m2 * l1 ^ 2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * l2 + 0.12e2 * s2 ^ 2 * m2 * ((l1 ^ 2 * (s3 - l3) ^ 2 * m3 + (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * l3 ^ 2 + A_3_S * l1 ^ 2) * mP2 + ((ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * s3 ^ 2 + A_3_S * l1 ^ 2) * m3 + A_3_S * (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S))) -0.12e2 * (mP2 * l3 ^ 2 + m3 * s3 ^ 2 + A_3_S) * ((ig ^ 2 * C_M_S + l1 ^ 2 * m2 + m1 * s1 ^ 2 + C_1_S) * l2 - s2 * l1 ^ 2 * m2) / ((l1 ^ 2 * (mP2 * l3 ^ 2 + m3 * s3 ^ 2 + A_3_S) * m2 ^ 2 + ((0.13e2 * l1 ^ 2 * (s3 - l3) ^ 2 * m3 + 0.13e2 * (mP1 * l3 ^ 2 + A_3_S) * l1 ^ 2 + l3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * mP2 + (0.13e2 * (mP1 * s3 ^ 2 + A_3_S) * l1 ^ 2 + s3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * m3 + A_3_S * (ig ^ 2 * C_M_S + 0.13e2 * l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S)) * m2 + 0.12e2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * l2 ^ 2 - 0.24e2 * s2 * m2 * l1 ^ 2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * l2 + 0.12e2 * s2 ^ 2 * m2 * ((l1 ^ 2 * (s3 - l3) ^ 2 * m3 + (mP1 * l3 ^ 2 + A_3_S) * l1 ^ 2 + l3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * mP2 + ((mP1 * s3 ^ 2 + A_3_S) * l1 ^ 2 + s3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * m3 + A_3_S * (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S))) -0.12e2 * ((ig ^ 2 * C_M_S + l1 ^ 2 * m2 + m1 * s1 ^ 2 + C_1_S) * l2 - s2 * l1 ^ 2 * m2) * (s3 * (s3 - l3) * m3 + A_3_S) / ((l1 ^ 2 * (mP2 * l3 ^ 2 + m3 * s3 ^ 2 + A_3_S) * m2 ^ 2 + ((0.13e2 * l1 ^ 2 * (s3 - l3) ^ 2 * mP2 + (ig ^ 2 * C_M_S + 0.13e2 * l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * s3 ^ 2 + 0.13e2 * A_3_S * l1 ^ 2) * m3 + (0.13e2 * (mP1 * l3 ^ 2 + A_3_S) * l1 ^ 2 + l3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * mP2 + A_3_S * (ig ^ 2 * C_M_S + 0.13e2 * l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S)) * m2 + 0.12e2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S) * (((s3 - l3) ^ 2 * mP2 + mP1 * s3 ^ 2 + A_3_S) * m3 + (mP1 * l3 ^ 2 + A_3_S) * mP2 + mP1 * A_3_S)) * l2 ^ 2 - 0.24e2 * m2 * l1 ^ 2 * s2 * (((s3 - l3) ^ 2 * mP2 + mP1 * s3 ^ 2 + A_3_S) * m3 + (mP1 * l3 ^ 2 + A_3_S) * mP2 + mP1 * A_3_S) * l2 + 0.12e2 * m2 * ((l1 ^ 2 * (s3 - l3) ^ 2 * mP2 + (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * s3 ^ 2 + A_3_S * l1 ^ 2) * m3 + ((mP1 * l3 ^ 2 + A_3_S) * l1 ^ 2 + l3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * mP2 + A_3_S * (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S)) * s2 ^ 2); -0.12e2 * (-m2 * (l3 * mP2 + m3 * s3) * l2 ^ 2 / 0.12e2 + (s2 * (l3 * mP2 + m3 * s3) * m2 + ((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * l2 + m2 * (l3 * (l3 - s2) * mP2 + s3 * (s3 - s2) * m3 + A_3_S) * s2) * l1 * ig / ((l1 ^ 2 * (mP2 * l3 ^ 2 + m3 * s3 ^ 2 + A_3_S) * m2 ^ 2 + ((0.13e2 * l1 ^ 2 * (s3 - l3) ^ 2 * m3 + (ig ^ 2 * C_M_S + 0.13e2 * l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * l3 ^ 2 + 0.13e2 * A_3_S * l1 ^ 2) * mP2 + ((ig ^ 2 * C_M_S + 0.13e2 * l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * s3 ^ 2 + 0.13e2 * A_3_S * l1 ^ 2) * m3 + A_3_S * (ig ^ 2 * C_M_S + 0.13e2 * l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S)) * m2 + 0.12e2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * l2 ^ 2 - 0.24e2 * s2 * m2 * l1 ^ 2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * l2 + 0.12e2 * s2 ^ 2 * m2 * ((l1 ^ 2 * (s3 - l3) ^ 2 * m3 + (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * l3 ^ 2 + A_3_S * l1 ^ 2) * mP2 + ((ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * s3 ^ 2 + A_3_S * l1 ^ 2) * m3 + A_3_S * (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S))) 0.12e2 * ((l3 * mP2 + m3 * s3) * (C_1_S + ig ^ 2 * C_M_S + 0.13e2 / 0.12e2 * l1 ^ 2 * m2 + m1 * s1 ^ 2) * l2 ^ 2 + (l1 ^ 2 * (l3 * (l3 - 0.2e1 * s2) * mP2 + s3 * (s3 - 0.2e1 * s2) * m3 + A_3_S) * m2 + (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S) * (mP2 * l3 ^ 2 + m3 * s3 ^ 2 + A_3_S)) * l2 - m2 * l1 ^ 2 * (l3 * (l3 - s2) * mP2 + s3 * (s3 - s2) * m3 + A_3_S) * s2) / ((l1 ^ 2 * (mP2 * l3 ^ 2 + m3 * s3 ^ 2 + A_3_S) * m2 ^ 2 + ((0.13e2 * l1 ^ 2 * (s3 - l3) ^ 2 * m3 + 0.13e2 * (mP1 * l3 ^ 2 + A_3_S) * l1 ^ 2 + l3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * mP2 + (0.13e2 * (mP1 * s3 ^ 2 + A_3_S) * l1 ^ 2 + s3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * m3 + A_3_S * (ig ^ 2 * C_M_S + 0.13e2 * l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S)) * m2 + 0.12e2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * l2 ^ 2 - 0.24e2 * s2 * m2 * l1 ^ 2 * (((s3 - l3) ^ 2 * m3 + mP1 * l3 ^ 2 + A_3_S) * mP2 + (mP1 * s3 ^ 2 + A_3_S) * m3 + mP1 * A_3_S) * l2 + 0.12e2 * s2 ^ 2 * m2 * ((l1 ^ 2 * (s3 - l3) ^ 2 * m3 + (mP1 * l3 ^ 2 + A_3_S) * l1 ^ 2 + l3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * mP2 + ((mP1 * s3 ^ 2 + A_3_S) * l1 ^ 2 + s3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * m3 + A_3_S * (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S))) ((-l1 ^ 2 * l3 * m2 ^ 2 + (0.13e2 * l1 ^ 2 * (s3 - l3) * m3 - l3 * (ig ^ 2 * C_M_S + 0.13e2 * l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S)) * m2 + 0.12e2 * ((s3 - l3) * m3 - mP1 * l3) * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * l2 ^ 2 + 0.12e2 * (l1 ^ 2 * ((s3 - 0.2e1 * s2) * (s3 - l3) * m3 + 0.2e1 * mP1 * l3 * s2 + A_3_S) * m2 + (s3 * (s3 - l3) * m3 + A_3_S) * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * l2 - 0.12e2 * m2 * (l1 ^ 2 * (s3 - s2) * (s3 - l3) * m3 + s2 * (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * l3 + A_3_S * l1 ^ 2) * s2) / ((l1 ^ 2 * (mP2 * l3 ^ 2 + m3 * s3 ^ 2 + A_3_S) * m2 ^ 2 + ((0.13e2 * mP2 * l1 ^ 2 * l3 ^ 2 - 0.26e2 * s3 * mP2 * l1 ^ 2 * l3 + 0.13e2 * ((mP1 + mP2) * s3 ^ 2 + A_3_S) * l1 ^ 2 + s3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * m3 + mP2 * (ig ^ 2 * C_M_S + 0.13e2 * l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * l3 ^ 2 + A_3_S * (0.13e2 * (mP1 + mP2) * l1 ^ 2 + ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * m2 + 0.12e2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S) * ((mP2 * l3 ^ 2 - 0.2e1 * s3 * mP2 * l3 + (mP1 + mP2) * s3 ^ 2 + A_3_S) * m3 + mP1 * mP2 * l3 ^ 2 + A_3_S * (mP1 + mP2))) * l2 ^ 2 - 0.24e2 * m2 * l1 ^ 2 * s2 * ((mP2 * l3 ^ 2 - 0.2e1 * s3 * mP2 * l3 + (mP1 + mP2) * s3 ^ 2 + A_3_S) * m3 + mP1 * mP2 * l3 ^ 2 + A_3_S * (mP1 + mP2)) * l2 + 0.12e2 * m2 * ((mP2 * l1 ^ 2 * l3 ^ 2 - 0.2e1 * s3 * mP2 * l1 ^ 2 * l3 + ((mP1 + mP2) * s3 ^ 2 + A_3_S) * l1 ^ 2 + s3 ^ 2 * (ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * m3 + mP2 * (ig ^ 2 * C_M_S + l1 ^ 2 * mP1 + m1 * s1 ^ 2 + C_1_S) * l3 ^ 2 + A_3_S * ((mP1 + mP2) * l1 ^ 2 + ig ^ 2 * C_M_S + m1 * s1 ^ 2 + C_1_S)) * s2 ^ 2);];
C = eye(6);
D = [0 0 0; 0 0 0; 0 0 0; 0 0 0; 0 0 0; 0 0 0];

Q = diag([40, 5, 2.5, .8, .4, .2]);
R = diag([100]);
%cT = [1, 1, 0, 0];
sys = ss(A, B(:,1), C, D(:,1));
k = lqr(sys, Q, R)

params = [m1 m2 m3 l1 l2 l3 s1 s2 s3 C_1_S g ig C_M_S d0 ds1 ds2 mP1 mP2, A_3_S, B_3_S];
clear m1 m2 m3 l1 l2 l3 s1 s2 s3 C_1_S g ig C_M_S d0 ds1 ds2 mP1 mP2 A_3_S B_3_S

%% Initial conditions
% First-Order Dynamic system 1
x1_ic = zeros(6,1);