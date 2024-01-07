figure("WindowState","maximized");
set(gcf,'Visible','on');
set(groot,'defaultLineLineWidth', 2.5);

t = simout_s.Time;
s = simout_s.Data(:,1);
sv = simout_s.Data(:,2);
sa = simout_s.Data(:,3);

hold on;
plot(t, s, 'k', t, sv, 'b--', t, sa, 'r:');
hold off;
title('Wegverläufe')
ylabel('Weg s in m')
xlabel('Zeit t in s')
legend('s', 's_v', 's_a');
grid on;


start = 2400;
endt = 3001;
rng = start:endt;
axes('position',[.65 .3 .25 .25]) % xlocation, ylocation, xsize, ysize
plot(t(rng), s(rng), 'k', t(rng), sv(rng), 'b--', t(rng), sa(rng), 'r:'); axis tight
axis([t(start) t(endt) .7995 .8001])
annotation('rectangle',[.5 .8 .1 .025])
annotation('arrow',[.65 .6],[.55 .8])
grid on;

fontsize(24, 'points')
print('s_1e-3', '-depsc')

%%
figure("WindowState","maximized");
set(gcf,'Visible','on');
set(groot,'defaultLineLineWidth', 2.5);

t = simout_v.Time;
v = simout_v.Data(:,1);
va = simout_v.Data(:,2);

hold on;
plot(t, v, 'b', t, va, 'r');
hold off;
title('Geschwindigkeitsverläufe')
ylabel('Geschwindigkeit v in m/s')
xlabel('Zeit t in s')
legend('v', 'v_a');
grid on;
axis([0 Te 0 0.6000001])
axes('position',[.65 .3 .25 .25]) % xlocation, ylocation, xsize, ysize
start = 2400;
endt = 3001;
rng = start:endt;
plot(t(rng), v(rng), 'b', t(rng), va(rng), 'r'); 
axis tight
% axis([t(start) t(endt) 0 0.005])
axis([t(start) t(endt) -0.00015 0])
annotation('rectangle',[.5 .1 .1 .05])
annotation('arrow',[.65 .6],[.3 .15])

grid on;
fontsize(24, 'points')
%print('v_1e-3', '-depsc')

%%

t = out.simout.Time;
q1 = out.simout.Data(:,1);
q2 = out.simout.Data(:,2);
q3 = out.simout.Data(:,3);

figure%("WindowState","maximized");
set(gcf,'Visible','on');
set(groot,'defaultLineLineWidth', 1);


plot(t, q1, 'k', t, q2, 'b', t, q3, 'r');
title('Soll-Position')
ylabel('Winkel in rad/s')
xlabel('Zeit in s')
legend('q_1', 'q_2', 'q_3');
%axis([0 Te -0.6 0.1000001])
grid on;
fontsize(14, 'points')
print('Soll_Position', '-depsc')

q1 = out.simout1.Data(:,1);
q2 = out.simout1.Data(:,2);
q3 = out.simout1.Data(:,3);

figure;
set(gcf,'Visible','on');
%set(groot,'defaultLineLineWidth', 1.5);

plot(t, q1, 'k', t, q2, 'b', t, q3, 'r');
title('Down-Konfiguration')
ylabel('Winkel in rad/s')
xlabel('Zeit in s')
legend('q_1', 'q_2', 'q_3');
hold off;
grid on;
fontsize(14, 'points')
print('Ist_Position_Down', '-depsc')
