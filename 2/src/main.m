%% 2. SEMESTRALNI PRACE KKY/OPS - STATICKA OPTIMALIZACE
%% Autor: Tomas Honzik & Tomas Kolar
%% SETUP
close all; 
clear; clc;

gray_color = [0.7 0.7 0.7];
blue_color = [0, 0.4470, 0.7410];
orange_color = [0.8500, 0.3250, 0.0980];
yellow_color = [0.9290, 0.6940, 0.1250];
purple_color = [0.4940, 0.1840, 0.5560];
green_color = [0.4660, 0.6740, 0.1880];
lightblue_color = [0.3010, 0.7450, 0.9330];
red_color = [0.6350, 0.0780, 0.1840];

marker_size = 12;

global m mu t0 r0 dotr0 tf rL hL vL meanRadius
[m,mu,t0,r0,dotr0,tf,rL,hL,vL,orbitalPeriod, meanRadius] = ops_zadani_2_2019_data(1);

%% SIM SCENARIO 1


options = odeset('RelTol',1e-6, 'MaxStep', 0.2);
[t, r] = ode45(@scenario_1, [t0 orbitalPeriod], [r0; dotr0], options);
h = height(r(:, 1:2));

%% PLOT SCENARIO 1

% View
figure
plot_circle(0, 0, meanRadius, gray_color);
hold on
plot(r(:, 1), r(:, 2), 'Color', blue_color)
plot(r(1, 1), r(1, 2), 'Color', orange_color, 'Marker', '+', 'MarkerSize', marker_size, 'LineWidth', 2)
plot(r(end, 1), r(end, 2), 'Color', green_color, 'Marker', 'x', 'MarkerSize', marker_size, 'LineWidth', 2)
hold off
axis equal
grid
title('\textbf{Pohyb bez pohonu}', 'interpreter', 'latex')
xlabel('\textbf{Poloha x [m]}', 'interpreter', 'latex')
ylabel('\textbf{Poloha y [m]}', 'interpreter', 'latex')
legend('\textbf{M\v{e}s\''{i}c}', '\textbf{Trajektorie}', '\textbf{Startovn\''{i} pozice}', '\textbf{Kone\v{c}n\''{a} pozice}', 'interpreter', 'latex')

% Height
figure
plot(t, h)
grid
title('\textbf{Pr\r ub\v eh v\'' y\v sky bez pohonu}', 'interpreter', 'latex')
xlabel('\textbf{\v Cas [s]}', 'interpreter', 'latex')
ylabel('\textbf{V\'' y\v ska [m]}', 'interpreter', 'latex')

% Position
figure
plot(t, r(:, 1:2))
grid
title('\textbf{Pr\r ub\v eh polohy bez pohonu}', 'interpreter', 'latex')
xlabel('\textbf{\v Cas [s]}', 'interpreter', 'latex')
ylabel('\textbf{Poloha [m]}', 'interpreter', 'latex')
legend('Osa x', 'Osa y')

% Velocity
figure
plot(t, r(:, 3:4))
grid
title('\textbf{Pr\r ub\v eh rychlosti bez pohonu}', 'interpreter', 'latex')
xlabel('\textbf{\v Cas [s]}', 'interpreter', 'latex')
ylabel('\textbf{Rychlost [} $\mathbf{m\cdot s^{-1}}$ \textbf{]}', 'interpreter', 'latex')
legend('Osa x', 'Osa y')

% Thrust
figure
plot(t, zeros(length(t), 2))
grid
title('\textbf{Pr\r ub\v eh tahu pohonu bez pohonu :-)}', 'interpreter', 'latex')
xlabel('\textbf{\v Cas [s]}', 'interpreter', 'latex')
ylabel('\textbf{S\'' ila [N]}', 'interpreter', 'latex')
legend('Osa x', 'Osa y')


%% SCENARIO 2

[t, r] = ode45(@scenario_2, [t0 orbitalPeriod], [r0; dotr0], options);
[a_i,b_i] = find_interval_indexes(t, 600, 660);
h = height(r(:, 1:2));

%% PLOT SCENARIO 2

% View
figure
plot_circle(0, 0, meanRadius, gray_color);
hold on
plot(r(1:a_i, 1), r(1:a_i, 2), 'Color', blue_color)
plot(r(1, 1), r(1, 2), 'Color', orange_color, 'Marker', '+', 'MarkerSize', marker_size, 'LineWidth', 2)
plot(r(end, 1), r(end, 2), 'Color', green_color, 'Marker', 'x', 'MarkerSize', marker_size, 'LineWidth', 2)
plot(r(a_i:b_i, 1), r(a_i:b_i, 2), 'Color', red_color, 'Marker', 'o', 'MarkerFaceColor', red_color, 'MarkerSize', 2)
plot(r(b_i:end, 1), r(b_i:end, 2), 'Color', blue_color)
quiver(r(round((a_i+b_i)/2), 1), r(round((a_i+b_i)/2), 2), -5000, 5000)
axis equal
grid
title('\textbf{Pohyb s pohonem}', 'interpreter', 'latex')
xlabel('\textbf{Poloha x [m]}', 'interpreter', 'latex')
ylabel('\textbf{Poloha y [m]}', 'interpreter', 'latex')
legend('\textbf{M\v{e}s\''{i}c}', '\textbf{Trajektorie}', '\textbf{Startovn\''{i} pozice}', '\textbf{Kone\v{c}n\''{a} pozice}', '\textbf{Za\v{c}\''{a}tek a konec ak\v{c}n\''{i}ho z\''{a}sahu}', 'interpreter', 'latex')
hold off

% Height
figure
plot(t, h)
grid
title('\textbf{Pr\r ub\v eh v\'' y\v sky s pohonem}', 'interpreter', 'latex')
xlabel('\textbf{\v Cas [s]}', 'interpreter', 'latex')
ylabel('\textbf{V\'' y\v ska [m]}', 'interpreter', 'latex')

% Position
figure
plot(t, r(:, 1:2))
grid
title('\textbf{Pr\r ub\v eh polohy s pohonem}', 'interpreter', 'latex')
xlabel('\textbf{\v Cas [s]}', 'interpreter', 'latex')
ylabel('\textbf{Poloha [m]}', 'interpreter', 'latex')
legend('Osa x', 'Osa y')

% Velocity
figure
plot(t, r(:, 3:4))
grid
title('\textbf{Pr\r ub\v eh rychlosti s pohonem}', 'interpreter', 'latex')
xlabel('\textbf{\v Cas [s]}', 'interpreter', 'latex')
ylabel('\textbf{Rychlost [} $\mathbf{m\cdot s^{-1}}$ \textbf{]}', 'interpreter', 'latex')
legend('Osa x', 'Osa y')

% Thrust
figure
plot(t, [zeros(2, a_i) [-5000 0; 0 5000]*ones(2, b_i-a_i) zeros(2, length(t)-b_i)]')
grid
title('\textbf{Pr\r ub\v eh tahu pohonu}', 'interpreter', 'latex')
xlabel('\textbf{\v Cas [s]}', 'interpreter', 'latex')
ylabel('\textbf{S\'' ila [N]}', 'interpreter', 'latex')
legend('Osa x', 'Osa y')


%% FIND OPTIMAL TRAJECTORY

solfinal = bvp4c(@scenario_optimal,@constraints,guess);

t = solfinal.x;
x = solfinal.y(1, :);
y = solfinal.y(2, :);
x_dot = solfinal.y(3, :);
y_dot = solfinal.y(4, :);
costate = solfinal.y(5:8, :);
lambda = solfinal.y(5:6, :);
u = -lambda/m;
h = height(solfinal.y(1:2, :)');

J_value = J(t, u);

H = hemiltonian(solfinal.y, u);

%% PLOT OPTIMAL TRAJECTORY

disp(['Hodnota J: ' num2str(J_value, '%10.3e\n')])

% View
figure
plot_circle(0, 0, meanRadius, gray_color);
hold on
plot(x, y, 'Color', blue_color)
plot(x(1), y(1), 'Color', orange_color, 'Marker', '+', 'MarkerSize', marker_size, 'LineWidth', 2)
plot(x(end), y(end), 'Color', green_color, 'Marker', 'x', 'MarkerSize', marker_size, 'LineWidth', 2)
quiver(x(end), y(end), x_dot(end), y_dot(end), 'Color', lightblue_color)
axis equal
grid
title('\textbf{Pohyb po optim\'' aln\'' i trajektorii}', 'interpreter', 'latex')
xlabel('\textbf{Poloha x [m]}', 'interpreter', 'latex')
ylabel('\textbf{Poloha y [m]}', 'interpreter', 'latex')
legend('\textbf{M\v{e}s\''{i}c}', '\textbf{Trajektorie}', '\textbf{Startovn\''{i} pozice}', '\textbf{Kone\v{c}n\''{a} pozice}', '\textbf{P\v rist\'' avac\'' i rychlost}', 'interpreter', 'latex')

% Height
figure
plot(t, h)
grid
title('\textbf{Pr\r ub\v eh v\'' y\v sky optim\'' aln\'' i trajektorie}', 'interpreter', 'latex')
xlabel('\textbf{\v Cas [s]}', 'interpreter', 'latex')
ylabel('\textbf{V\'' y\v ska [m]}', 'interpreter', 'latex')

% Position
figure
plot(t, [x; y]')
grid
title('\textbf{Pr\r ub\v eh polohy optim\'' aln\'' i trajektorie}', 'interpreter', 'latex')
xlabel('\textbf{\v Cas [s]}', 'interpreter', 'latex')
ylabel('\textbf{Poloha [m]}', 'interpreter', 'latex')
legend('Osa x', 'Osa y')

% Velocity
figure
plot(t, [x_dot; y_dot]')
grid
title('\textbf{Pr\r ub\v eh rychlosti optim\'' aln\'' i trajektorie}', 'interpreter', 'latex')
xlabel('\textbf{\v Cas [s]}', 'interpreter', 'latex')
ylabel('\textbf{Rychlost [} $\mathbf{m\cdot s^{-1}}$ \textbf{]}', 'interpreter', 'latex')
legend('Osa x', 'Osa y')

% Thrust
figure
plot(t, u)
grid
title('\textbf{Pr\r ub\v eh tahu pohonu p\v ri optim\'' aln\'' i trajektorii}', 'interpreter', 'latex')
xlabel('\textbf{\v Cas [s]}', 'interpreter', 'latex')
ylabel('\textbf{S\'' ila [N]}', 'interpreter', 'latex')
legend('Osa x', 'Osa y')

% Costate
figure
plot(t, costate)
grid
title('costate')
title('\textbf{Pr\r ub\v eh Laplasov\'' ych multiplik\'' ator\r u}', 'interpreter', 'latex')
xlabel('\textbf{\v Cas [s]}', 'interpreter', 'latex')
ylabel('$\mathbf{\lambda}$', 'interpreter', 'latex')

figure
plot(t, H)
