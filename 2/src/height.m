function [h] = height(r)

global meanRadius

h = zeros(length(r), 1);

for i=1:length(h)
    h(i) = norm(r(i, :));
end

h = h - meanRadius;
end

