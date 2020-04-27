function circles = plot_circle(x,y,r,c)
th = 0:pi/500:2*pi;
x_circle = r * cos(th) + x;
y_circle = r * sin(th) + y;
circles = plot(x_circle, y_circle, 'k');
fill(x_circle, y_circle, c)
end

