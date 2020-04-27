
%% SETUP
close all; clear; clc;

%% CREATE MODEL

gray_color = [0.7 0.7 0.7];

global m mu t0 r0 dotr0 tf rL hL vL orbitalPeriod meanRadius landing_state
[m,mu,t0,r0,dotr0,tf,rL,hL,vL,orbitalPeriod, meanRadius] = ops_zadani_2_2019_data(1);
%OPS_ZADANI_2_2019_DATA Parametry zadani semestralni prace z OPS
%   [m,mu,t0,r0,dotr0,tf,rf,hf,vf] = ops_zadani_2_2019_data(id) pro
%   cislo zadani id vrati
%   m - hmotnost lunarniho modulu [kg]
%   mu - gravitacni parametr Mesice [m^3/s^2]
%   t0 - pocatecni cas [s]
%   r0 - pocatecni polohu lunarniho modulu [m]
%   dotr0 - pocatecni rychlost lunarniho modulu [m/s]
%   tf - koncovy cas [s]
%   rL - pozadovane misto pristani na Mesici
%   hL - pozadovana vyska nad mistem pristani
%   vL - pozadovana koncova rychlost smerem k Mesici ve vysce hL nad rL

% hL = hL + meanRadius;


landing_state = [rL+hL*(rL/norm(rL)); -vL*(rL/norm(rL))];

%%

% initial_height = 1e5;
% circular_velocity = sqrt((mu/initial_height));
% escape_velocity = sqrt(2*(mu/initial_height));


options = odeset('RelTol',1e-6, 'MaxStep', 0.2);

[t, r] = ode45(@scenario_1, [t0 orbitalPeriod], [r0; dotr0], options);



figure
plot_circle(0, 0, meanRadius, gray_color);
hold on
plot(r(:, 1), r(:, 2))
plot(r(1, 1), r(1, 2), 'Color', 'b', 'Marker', 'x')
plot(r(end, 1), r(end, 2), 'Color', 'b', 'Marker', 'o')
hold off



%%

[t, r] = ode45(@scenario_2, [t0 orbitalPeriod], [r0; dotr0], options);

[a_i,b_i] = find_interval_indexes(t, 600, 660);

figure
plot_circle(0, 0, meanRadius, gray_color);
hold on
plot(r(:, 1), r(:, 2))
plot(r(1, 1), r(1, 2), 'Color', 'b', 'Marker', 'x')
plot(r(end, 1), r(end, 2), 'Color', 'b', 'Marker', 'o')
plot(r(a_i, 1), r(a_i, 2), 'Color', 'm', 'Marker', 'x')
plot(r(b_i, 1), r(b_i, 2), 'Color', 'm', 'Marker', 'o')
hold off


%%


solfinal = bvp4c(@scenario_optimal,@constraints,guess);


t = solfinal.x;
x = solfinal.y(1, :);
y = solfinal.y(2, :);
x_dot = solfinal.y(3, :);
y_dot = solfinal.y(4, :);

lambda_dot = solfinal.y(7:8, :);
u = -lambda_dot/m;

plot_circle(0, 0, meanRadius, gray_color);
hold on
plot(x, y)
quiver(x(end), y(end), x_dot(end), y_dot(end))
axis equal 
grid

figure
plot(t, u)
% 
% figure
% plot(t, [x; y]')
% title('position')
% 
% figure
% plot(t, [x_dot; y_dot]')
% title('velocity')
% 
% figure
% plot(t, [x_dot; y_dot]')
% title('velocity')




