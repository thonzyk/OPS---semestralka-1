function drdt = scenario_2(t,r)

global m mu

if t > 600 && t < 660
    u = [-5 5]' * 1e3;
else
    u = [0 0]';
end

position_i = 1:2;
velocity_i = 3:4;

drdt = [r(velocity_i); (-mu*r(position_i))/(sqrt(r(position_i)'*r(position_i)))^3 + u/m];
end
