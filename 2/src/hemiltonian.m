function [H] = hemiltonian(xlambdas, us)
global mu m

H = zeros(length(us), 1);

for i=1:length(H)
    xlambda = xlambdas(:, i);
    u = us(:, i);
    
    h = norm(xlambda(1:2));
    
    H(i) = 1/2*(u'*u) + xlambda(5:8)'*[xlambda(3:4); ((-mu*xlambda(1:2))/h^3+u/m)];
end
end

