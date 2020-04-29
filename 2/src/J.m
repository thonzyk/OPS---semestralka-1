function [crit] = J(t,u)

if length(t) ~= length(u(1, :))
    error('dimension does not match')
end

L = zeros(length(t), 1);

for i=1:length(t)
    L(i) = u(:, i)'*u(:, i);
end

crit = trapz(t, L);
end

