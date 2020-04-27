function [a_i,b_i] = find_interval_indexes(input,a,b)

a_i = length(input);
b_i = length(input);

for i=1:length(input)
    if input(i) > a && input(i) < input(a_i)
        a_i =  i;
    end
    
    if input(i) > b && input(i) < input(b_i)
        b_i =  i;
    end
end
end

