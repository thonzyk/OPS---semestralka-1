function [] = plot_g_3D(D,H,N,utest,polygon_constraint)
% Plot: 3D Graf funkce g + hladinu prahu
% Plot: Vrstevnice funkce g + zakazana oblast
%
% D: Tenzor statickych zesileni systemu - iterovatelny pres 3. dimenzi
%
% H: Tenzor statickych zesileni chyby pozorovani - iter. pres 3. dimenzi
%
% u: Tenzor vstupu systemu - iterovatelny pres 3. dimenzi
%
% polygon_constraint: 1 = sekvence bodu omezujiciho hnohouhelniku - iter.
%                         pres 2. dimenzi
% -------------------------------------------------------------------------

% Inicializace
g = zeros(N);
is_polygon = ~isempty(polygon_constraint);

% Empiricky urcene rozmezi os
x_axis = linspace(-30, 30, N);
y_axis = x_axis;

% Vykresleni hladiny ve vysce 0
figure
mesh(x_axis, y_axis, g, 'edgecolor', 'k')
hold on

% Vypocet 3D grafu funkce g
for i=1:N
   for j=1:N
       u = [x_axis(j) y_axis(i)]';
       q = q_max(D,H,u);
       g(i, j) = 1 - q;
   end
end

% Vykresleni 3D grafu funkce g
surf(x_axis, y_axis, g)
hold off

% Popisky
title('\textbf{3D graf funkce g(u)}', 'interpreter', 'latex')
xlabel('$\mathbf{u_1}$', 'interpreter', 'latex')
ylabel('$\mathbf{u_2}$', 'interpreter', 'latex')
legend('\textbf{Prahov\'' a hladina}', '\textbf{g(u)}', 'interpreter', 'latex')
axis equal

% Vykresleni vrstevnic
figure
hold on
contour(x_axis, y_axis, g, 40)

% Vykresleni zakazane oblasti
[~,c] = contourf(x_axis, y_axis, g, [0 0]);
c.LineWidth = 3;
c.Color = 'r';

% Vykresleni omezujiciho polygonu
if is_polygon
    pgon = polyshape(polygon_constraint(1, :), polygon_constraint(2, :));
    s4 = plot(pgon);
else
    s4 = [];
end

% Vykresleni testovacich u a optimalniho u
s1 = scatter(utest(1, 1), utest(2, 1), 'r');
s2 = scatter(utest(1, 2), utest(2, 2), 'b');
global optimal_u;
s3 = plot(optimal_u(1), optimal_u(2), 'g*');
hold off

% Popisky
title('\textbf{Vrstevnice funkce g(u)}', 'interpreter', 'latex')
legend([c, s1, s2, s3, s4], '\textbf{Nevyhovuj\'' ic\'' i u}', '$\mathbf{u_{test1}}$', '$\mathbf{u_{test2}}$', '\textbf{Optimalni u}', '\textbf{Omezuj\'' ic\'' i polygon}', 'interpreter', 'latex')
w = warning('query','last');
id = w.identifier;
warning('off',id)
xlabel('$\mathbf{u_1}$', 'interpreter', 'latex')
ylabel('$\mathbf{u_2}$', 'interpreter', 'latex')
axis equal
grid
end

