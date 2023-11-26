m1 = params(1);       % kg
m2 = params(2);    % kg
l1 = params(3);       % m
l2 = params(4);      % m
s1 = params(5);     % m
s2 = params(6);     % m

C_1_S = params(7);  % kgm²
g = params(8);       % m/s²
ig = params(9);
C_M_S = params(10);


A = [0 0 1 0; 0 0 0 1; 0 m2 * g * l1 / (C_M_S * ig ^ 2 + m1 * s1 ^ 2 + C_1_S) 0 0; 0 0.1e1 / s2 / (C_M_S * ig ^ 2 + m1 * s1 ^ 2 + C_1_S) * g * (C_M_S * ig ^ 2 + l1 ^ 2 * m2 + m1 * s1 ^ 2 + C_1_S) 0 0;];
b = [0; 0; ig / (C_M_S * ig ^ 2 + m1 * s1 ^ 2 + C_1_S); l1 * ig / s2 / (C_M_S * ig ^ 2 + m1 * s1 ^ 2 + C_1_S);];
C = [1, 1, 1, 1];
D = 0;

clear m1 m2 l1 l2 s1 s2 C_1_S g ig C_M_S