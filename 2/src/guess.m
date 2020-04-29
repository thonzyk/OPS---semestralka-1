function solinit = guess()
global r0 dotr0 t0 tf
tinit = linspace(t0, tf, 500);
xlambdainit = [[r0; dotr0]; ones(4, 1)];
solinit = bvpinit(tinit,xlambdainit);
end