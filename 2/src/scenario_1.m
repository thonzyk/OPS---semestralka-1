function drdt = scenario_1(t,r)

global m mu t0 r0 dotr0 tf rL hL vL orbitalPeriod

u = [0 0]';

position_i = 1:2;
velocity_i = 3:4;

drdt = [r(velocity_i); (-mu*r(position_i))/(sqrt(r(position_i)'*r(position_i)))^3 + u/m];
end
