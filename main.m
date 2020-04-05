%% 1. SEMESTRALNI PRACE KKY/OPS - STATICKA OPTIMALIZACE
%% Autor: Tomas Honzik & Tomas Kolar

%% SETUP
% slCharacterEncoding('UTF-8')
% feature('DefaultCharacterSet', 'UTF8')
close all; clear; clc;

%% 1) POPIS MOZNYCH REALIZACI SYSTEMU POMOCI MATIC

% Nacteni parametru systemu
[D,H,utest,b] = modelDiscrInputDesign_assigment(1);

% Graficke srovnani systemu
ellipse_system_compare(D,H,utest(:, 1))
title('\textbf{Porovn\''{a}n\''{i} systn\''{e}mu pro} $\mathbf{u_{test1}}$', 'interpreter', 'latex')

ellipse_system_compare(D,H,utest(:, 2))
title('\textbf{Porovn\''{a}n\''{i} systn\''{e}mu pro} $\mathbf{u_{test2}}$', 'interpreter', 'latex')


%% 2) FUNKCE q

figure
plot_q(D,H,utest(:, 1))
hold on
plot_q(D,H,utest(:, 2))
hold on
plot(0:1, ones(1, 2), '--')
legend('$\mathbf{q(u_1)}$','$\mathbf{max_1}$', '$\mathbf{q(u_2)}$','$\mathbf{max_1}$', '\textbf{Limit}', 'interpreter', 'latex')
grid

%% 3) NALEZENI OPTIMA

u0 = [10 10]';
global optimal_u;

% Bez omezeni polygonem
optimal_u = find_optimal_u(D,H,[],u0);
plot_g_3D(D,H,30,utest, []);
ellipse_system_compare(D,H,optimal_u)
title('\textbf{Porovn\'' an\'' i syst\'' emu pro u-optim\'' aln\'' i}', 'interpreter', 'latex')

% S omezenim polygonem
optimal_u = find_optimal_u(D,H,b,u0);
plot_g_3D(D,H,30,utest, b);
ellipse_system_compare(D,H,optimal_u)
title('\textbf{Porovn\'' an\'' i syst\'' emu pro u-optim\'' aln\'' i s omezen\'' im polygonem}', 'interpreter', 'latex')

