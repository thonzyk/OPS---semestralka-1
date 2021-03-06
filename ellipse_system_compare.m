function [] = ellipse_system_compare(D,H,u)
% Plot: Vykresli srovnani dvou systemu pro dany vstup. Vnitrek elips
% popisuje mnozinu vsech eventualnich realizaci daneho systemu.
%
% D: Tenzor statickych zesileni systemu - iterovatelny pres 3. dimenzi
%
% H: Tenzor statickych zesileni chyby pozorovani - iter. pres 3. dimenzi
%
% u: Vstup systemu
% -------------------------------------------------------------------------

systems_count = length(D(1, 1, :));

figure
for i=1:systems_count
    m = D(:, :, i)*u;
    P = H(:, :, i)'* H(:, :, i);
    
    hold on
    plot_ellipse(m, P)
end
hold off

% Popisky
xlabel('$\mathbf{y_1}$', 'interpreter', 'latex')
ylabel('$\mathbf{y_2}$', 'interpreter', 'latex')
legend('\textbf{elipsa 1}', '\textbf{st\v{r}ed elipsy 1}', '\textbf{elipsa 2}', '\textbf{st\v{r}ed elipsy 2}', 'interpreter', 'latex')
grid
end

