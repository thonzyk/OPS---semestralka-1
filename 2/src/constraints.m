function res = constraints(xlambdat0,xlambdatf)

global r0 dotr0 rL hL vL

landing_state = [rL+hL*(rL/norm(rL)); -vL*(rL/norm(rL))];

res = [
    xlambdat0(1:4) - [r0; dotr0];
    xlambdatf(1:4) - landing_state
];

end