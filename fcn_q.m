function q = fcn_q(D,H,u,sign)
% Return q: Tvar funkce q pro zadane parametry
%
% D: Tenzor statickych zesileni systemu - iterovatelny pres 3. dimenzi
%
% H: Tenzor statickych zesileni chyby pozorovani - iter. pres 3. dimenzi
%
% u: Vstup systemu
%
% sign: Hodnota +1 nebo -1 kvuli MAX/MIN dualite optima
% -------------------------------------------------------------------------

% Substituce parametru
D1 = D(:, :, 1);
D2 = D(:, :, 2);
M1 = H(:, :, 1)'*H(:, :, 1);
M2 = H(:, :, 2)'*H(:, :, 2);

% Tvar funkce q
q = @(alpha)sign*u'*(D1 - D2)' * (alpha-alpha^2) * inv( M1 + alpha*(M2-M1) ) * (D1 - D2)*u;
end

