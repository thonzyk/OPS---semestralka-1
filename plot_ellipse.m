function [] = plot_ellipse(m, P)
% Plot: Vykresleni elipsy a jejiho stredu na zaklade souradnic stredu a
% disperzni matice
%
% m: Stred elipsy
% P: Disperzni matice elipsy
% -------------------------------------------------------------------------
% Zakresleni elipsy
plot_gaussian_ellipsoid(m, P, 1)
hold on

% Zachovani predesle barvy
ax = gca;
ax.ColorOrderIndex = ax.ColorOrderIndex - 1;

% Zakresleni stredu elipsy
plot(m(1), m(2), 'x')
hold off
end

