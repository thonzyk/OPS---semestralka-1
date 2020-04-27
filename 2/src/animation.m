function [] = animation(r)


N = 1000;
L = length(r);
step = round(L/N);

moon_radius = 1737;

figure


for i=1:step:L
    hold off
    axis([min([r(:, 1); -moon_radius]) max([r(:, 1); 0]) min([r(:, 2); -moon_radius]) max([r(:, 2); 0])]);
    circle(0, 0, 1737, [0.4 0.4 0.4]);
    hold on
    axis([min([r(:, 1); -moon_radius]) max([r(:, 1); 0]) min([r(:, 2); -moon_radius]) max([r(:, 2); 0])]);
    plot(r(i, 1), r(i, 2), 'b*')
    axis([min([r(:, 1); -moon_radius]) max([r(:, 1); 0]) min([r(:, 2); -moon_radius]) max([r(:, 2); 0])]);
    pause(0.001)
end

function circles = circle(x,y,r,c)
th = 0:pi/50:2*pi;
x_circle = r * cos(th) + x;
y_circle = r * sin(th) + y;
circles = plot(x_circle, y_circle);
fill(x_circle, y_circle, c)
end

end

