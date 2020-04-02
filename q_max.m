function [q_m] = q_max(D,H,u)
% Return q: Maximalni hodnota funkce q na intervalu <0,1>
%
% D: Tenzor statickych zesileni systemu - iterovatelny pres 3. dimenzi
%
% H: Tenzor statickych zesileni chyby pozorovani - iter. pres 3. dimenzi
%
% u: Vstup systemu
% -------------------------------------------------------------------------

% Nacteni tvaru funkce q
f_q = fcn_q(D,H,u, -1);

% Pocatecni podminka
alpha0 = 0.5;

% Nalezeni optima
[~, q_m] = fminsearch(f_q,alpha0);

% Znamenko minus kvuli MAX/MIN dualite optima
q_m = -q_m;
end

