function x_dot = sysdyn(x,m,c,d,u)

q      = x(1);
q_dot  = x(2);
q_ddot = u/m - c/m*q - d/m*q_dot;

x_dot = [q_dot; q_ddot];

end