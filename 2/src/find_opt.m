%%

close all; clear; clc;

global t0 tf mu nx nc x0 m N n h_l v_l

t0 = 0;
tf = 1000;

nx = 1:4;
nc = 5:8;

m = 11000;

mu = 4.9048695e12; % Standard gravitational parameter of the Moon


initial_height = 1e7;
circular_velocity = sqrt((mu/initial_height));
escape_velocity = sqrt(2*(mu/initial_height));
polohovy_uhel = pi/2;
uhel = 0.4;


x0 = [initial_height*cos(polohovy_uhel) initial_height*sin(polohovy_uhel) cos(uhel)*circular_velocity sin(uhel)*circular_velocity]';

moon_radius = 1737.4e3;

h_l = moon_radius + 100; % Landing height
v_l = 10; % Landing speed

N = eye(4);
n = [0 moon_radius 0 -1]';

solfinal = bvp4c(@bvpfcn,@bcfcn,guess);


t = solfinal.x;
x = solfinal.y(1, :);
y = solfinal.y(2, :);
x_dot = solfinal.y(3, :);
y_dot = solfinal.y(4, :);

lambda_dot = solfinal.y(7:8, :);
u = -lambda_dot/m;

plot(x, y)
hold on
plot_circle(0, 0, moon_radius, [0.4 0.4 0.4]);
axis equal 
grid
figure
plot(t, u)
figure
plot(t, [x; y]')
title('position')
figure
plot(t, [x_dot; y_dot]')
title('velocity')
figure
plot(t, [x_dot; y_dot]')
title('velocity')
% animation(solfinal.y(1:2, :)')





function dxdt = bvpfcn(t,xlambda, nu) % equation to solve
global mu m

x = xlambda(1:2);
x_dot = xlambda(3:4);
lambda = xlambda(5:6);
lambda_dot = xlambda(7:8);

h = sqrt(x(1)^2 + x(2)^2);
u = -lambda_dot/m;

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
%--------------------------------
function res = bcfcn(xlambdat0,xlambdatf,nu) % boundary conditions

global x0 nx h_l v_l 

x = xlambdatf(1);
y = xlambdatf(2);

h = sqrt(x^2 + y^2);

v11 = x/h;
v12 = y/h;
v21 = (-v_l*y^2)/h^3;
v22 = (v_l*x*y)/h^3;
v31 = v22;
v32 = (-v_l*x^2)/h^3;

V = [
    v11 v12 0 0;
    v21 v22 1 0;
    v31 v32 0 1
];

W = [v11 v12 0 0];



res = [
    xlambdat0(nx) - x0;
    
%     eye(4)*xlambdatf(nx) - [0 h_l 0 v_l]';
    
    h - h_l;
    
    xlambdatf(3:4) - v_l*xlambdatf(1:2)/h;
    V'*nu
];

end
%--------------------------------
function solinit = guess() % initial guess for y and y'
global x0 h_l v_l
t0 = 0;
tf = 15000;
tinit = t0:5:tf;
xlambdainit = [x0 ;ones(4, 1)];
nuinit = ones(3, 1);
solinit = bvpinit(tinit,xlambdainit,nuinit);
end
%--------------------------------


