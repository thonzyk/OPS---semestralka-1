function [] = plot_q(D,H,u)
% Return q: Hodnota funkce q pro zadane parametry
%
% D: Tenzor statickych zesileni systemu - iterovatelny pres 3. dimenzi
%
% H: Tenzor statickych zesileni chyby pozorovani - iter. pres 3. dimenzi
%
% u: Vstup systemu
% -------------------------------------------------------------------------

% Pocet kroku
N = 100;

% Inicializace
q = zeros(1, N);
alphas = linspace(0, 1, N);

% Vypocet prubehu funkce q
for i = 1:N
    f_q = fcn_q(D,H,u, +1);
    q(i) = f_q(alphas(i));
end

% Nalezeni maxim funkce q
[m, mi] = max(q);



% Vykresleni
plot(alphas, q)
hold on
% Zachovani predesle barvy
ax = gca;
ax.ColorOrderIndex = ax.ColorOrderIndex - 1;
plot((1/N)*(mi-1), m, 'o')
hold off


title('\textbf{Pr\r ub\v eh funkce q}', 'interpreter', 'latex')
xlabel('$\alpha$', 'interpreter', 'latex')
ylabel('$q(\alpha)$', 'interpreter', 'latex')
end

