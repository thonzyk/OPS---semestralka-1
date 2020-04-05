function [b] = test_b()

vert_count = round(rand*10)+3;

b = zeros(2, vert_count);

for i=1:vert_count
    b(:, i) = [rand*60-15 rand*60-15]';
end

k = convhull(b');

b = b(:, k(1:end-1));

end

