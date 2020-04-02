%% 1. SEMESTRÁLNÍ PRÁCE KKY/OPS - STATICKA OPTIMALIZACE
%% Autor: Tomáš Honzík

%% SETUP
% slCharacterEncoding('UTF-8')
close all; clear; clc;

%% 1) POPIS MOZNYCH REALIZACI SYSTEMU POMOCI MATIC

% Nacteni parametru systemu
[D,H,utest,b] = modelDiscrInputDesign_assigment(1);

% Graficke srovnani systemu
ellipse_system_compare(D,H,utest(:, 1))
title('Porovnani systemu pro u-test1')

ellipse_system_compare(D,H,[6 8]')
title('Porovnani systemu pro u-test2')


%% 2) FUNKCE q

figure
plot_q(D,H,utest(:, 1))
hold on
plot_q(D,H,utest(:, 2))
hold on
plot(0:1, ones(1, 2), '--')
legend('q(u_1)','max_1', 'q(u_2)','max_1', 'limit')
grid

%% 3) NALEZENI OPTIMA

u0 = [-20 -20]';
global optimal_u;

% Bez omezeni polygonem
optimal_u = find_optimal_u(D,H,[],u0);
plot_g_3D(D,H,30,utest, []);
ellipse_system_compare(D,H,optimal_u)
title('Porovnání systému pro u-optimalni')

% S omezenim polygonem
optimal_u = find_optimal_u(D,H,b,u0);
plot_g_3D(D,H,30,utest, b);
ellipse_system_compare(D,H,optimal_u)
title('Porovnání systému pro u-optimalni s omezenim polygonem')






