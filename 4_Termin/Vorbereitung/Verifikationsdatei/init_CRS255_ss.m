%%%% Initialization template
clear
clc
%% Parameters
% Parameter 1
g = 9.81; % (m/s2)

%Armträgheiten

B_S1 = 0.103; % (kgm2)
A_S2 = 0.0036; % (kgm2)
B_S2 = 0.0159; % (kgm2)
C_S2 = 0.0170; % (kgm2)
A_S3 = 0.0021; % (kgm2)
B_S3 = 0.018; % (kgm2)
C_S3 = 0.0583; % (kgm2)

%Uebersetzung Getriebe der Motoren (sind alle gleich)

i_G1=72; 
i_G2=72; 
i_G3=72; 

%Motortraegheiten
B_M1 = 1.89e-5; % (kgm2)
C_M2 = 1.89e-5; % (kgm2)
C_M3 = 1.89e-5; % (kgm2)

%Massen
m2 = 1.866; % (kg)
m3 = 2.173; % (kg)


%Abstaende
s2 = 0.125; % (m)
s3 = 0.131; % (m)
l2 = 0.25; % (m)
l3 = 0.25; % (m)

%Daempfungsbeiwerte
d1 = 4; % (Nms)
d2 = 6; % (Nms)
d3 = 5; % (Nms)

%Motorparameter
Ra = 3; % (Ohm)
km = 0.066; % (Nm/A)
ku = 7; % Spannungsverstaerkung
ua_max = 5; % (V) max. Ankerspannung (vor Verstaerkung)

%Encoder parameter
N = 4000; % (1) Strich pro Umdrehung
params_CRS = [g m2 m3 s2 s3 l2 l3 B_S1 A_S2 B_S2 C_S2 A_S3 B_S3 C_S3 i_G1 i_G2 i_G3 B_M1 C_M2 C_M3];
%clear g m2 m3 s2 s3 l2 l3 B_S1 A_S2 B_S2 C_S2 A_S3 B_S3 C_S3 i_G1 i_G2 i_G3 B_M1 C_M2 C_M3

%% Initial conditions
% First-Order Dynamic system 1
x1_ic = zeros(6,1);

%% Simulationseinstellungen
Ta = 1e-3; % Abtastzeit in s


