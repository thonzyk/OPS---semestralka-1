function dxdt = bvpfcn(t,xlambda)
global mu m

x = xlambda(1:2);
x_dot = xlambda(3:4);
lambda = xlambda(5:6);
lambda_dot = xlambda(7:8);
h = sqrt(x(1)^2 + x(2)^2);
u = -lambda/m;

L = [
  mu*(x(2)^2 - 2*x(1)^2)/h^5,   (-3*mu*x(1)*x(2))/h^5;
  (-3*mu*x(1)*x(2))/h^5,        mu*(x(1)^2 - 2*x(2)^2)/h^5
];

dxdt = [
    x_dot;
    (-mu*x)/h^3 + u/m;
    -lambda_dot;
    L*lambda
];
end