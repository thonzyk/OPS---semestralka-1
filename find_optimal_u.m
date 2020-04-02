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
    polygon_center = (sum(polygon_constraint, 2)'/length(polygon_constraint))';
end

% Kriterialni funkce
J = @(u)u'*u;

% Nalezeni optima
u_optimal = fmincon(J,u0,[],[],[],[],[],[],@crit);


    function [c,ceq] = crit(u)
        ceq = [];
        % Omezeni funkci g(u)
        c(1) = compute_g(u);
        
        % Omezeni polygonem
        if is_polygon
            c(2) = polygon_fcn(u);
        end
    end

    function c = compute_g(u)
        c = 1 - compute_q(u);
    end

    function [q] = compute_q(u)
        f_q = fcn_q(D,H,u, -1);
        alpha0 = 0.5;
        [~, q] = fminsearch(f_q,alpha0);
        % Minus sign for MAX/MIN duality
        q = -q;
    end

    function c = polygon_fcn(u)
        if inpolygon(u(1),u(2),polygon_constraint(1, :),polygon_constraint(2, :))
            c = -1;
        else
            c = distance(u', polygon_center');
        end
    end
end

