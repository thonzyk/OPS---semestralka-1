function [A,b] = equation_from_polygon_vertices(vertices)
% Vrati parametry nerovnice A*x<=b, ktera popisuje vnitrek libovolneho
% konvexniho polygonu tvoreneho zadanymi vrcholy.
% Return A: Matice nerovnice
% Return b: Vektor prave strany nerovnice
%
% vertices: Vrcholy polygonu
% -------------------------------------------------------------------------


% Pocet vrcholu
vert_count = length(vertices(1, :));

% Dimenze bod?
dim = length(vertices(:, 1));

% Ziskani poradi vrcholu polygonu
k = convhull(vertices');

% Overeni ze je polygon konvexni
if length(k) ~= vert_count + 1
    error('ERR: Polygon is not convex!')
end

% Inicializace rovnice
A = zeros(vert_count, dim);
b = zeros(vert_count, 1);

% Vypocet soustavy nerovnic
for i=1:vert_count
    direct_vec = vertices(:, k(i+1)) - vertices(:, k(i));
    
    % TODO: zobecnit pro n-dim vektor
    norm_vec = [-direct_vec(2) direct_vec(1)]; % 2D only
    
    A(i, :) = norm_vec;
    b(i) = norm_vec*vertices(:, i);
end

A = -1*A;
b = -1*b;
end

