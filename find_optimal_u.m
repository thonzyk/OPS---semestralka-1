function [u_optimal] = find_optimal_u(D,H, polygon_constraint, u0)
% Return u_optimal: Optimalni u
%
% D: Tenzor statickych zesileni systemu - iterovatelny pres 3. dimenzi
%
% H: Tenzor statickych zesileni chyby pozorovani - iter. pres 3. dimenzi
%
% u: Tenzor vstupu systemu - iterovatelny pres 3. dimenzi
%
% polygon_constraint: 1 = sekvence bodu omezujiciho hnohouhelniku - iter.
%                         pres 2. dimenzi
% u0: Pocatecni podminka optimalizace
% -------------------------------------------------------------------------

% Inicializace
is_polygon = ~isempty(polygon_constraint);

if is_polygon
    [A, b] = equation_from_polygon_vertices(polygon_constraint);
    
else
    A = [];
    b = [];
end

% Kriterialni funkce
J = @(u)u'*u;

% Nalezeni optima
u_optimal = fmincon(J,u0,A,b,[],[],[],[],@compute_g);



    function [c,ceq] = compute_g(u)
        ceq = [];
        c = 1 - compute_q(u);
    end

    function [q] = compute_q(u)
        f_q = fcn_q(D,H,u, -1);
        alpha0 = 0.5;
        [~, q] = fminsearch(f_q,alpha0);
        % Minus sign for MAX/MIN duality
        q = -q;
    end
end

