function res = constraints(xlambdat0,xlambdatf,nu) % boundary conditions

global r0 dotr0 hL vL rL landing_state

x = xlambdatf(1);
y = xlambdatf(2);

h = sqrt(x^2 + y^2);

v11 = x/h;
v12 = y/h;
v21 = (-vL*y^2)/h^3;
v22 = (vL*x*y)/h^3;
v31 = v22;
v32 = (-vL*x^2)/h^3;

V = [
    v11 v12 0 0;
    v21 v22 1 0;
    v31 v32 0 1
];

res = [
    xlambdat0(1:4) - [r0; dotr0];
    
    xlambdatf(1:4) - landing_state;
    
%     xlambdatf(5:8) - nu;
    
%     h - hL;
%     xlambdatf(3:4) - vL*xlambdatf(1:2)/h;
%     V'*nu
];

end