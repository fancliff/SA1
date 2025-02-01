clear
close all

%define grid size and refinement
xmin = -2.5;
xmax = 2.5;
nx = 51;

ymin = -2.0;
ymax = 2.0;
ny = 41;

xm = zeros(nx, ny);
ym = zeros(nx, ny);

np = 100; %number of panels for approximation

theta = (0:np)*2*pi/np; %angles of panel edges

%Co-ordinates and circulation of panel edges (from inviscid flow theory)
xs = cos(theta);
ys = sin(theta);
gammas = -2*sin(theta);

%define grid co-ordinates
for i = 1:nx
    for j = 1:ny
        xm(i,j) = xmin + (i-1)*(xmax-xmin)/(nx-1);
        ym(i,j) = ymin + (j-1)*(ymax-ymin)/(ny-1);
    end
end

%set free-stream stream function contribution (flow at zero inclination)
psi = ym;

%Find panel circulation contributions to stream function 
%At every grid point and due to all np panels
for k = 1:np
    for i = 1:nx
        for j = 1:ny
            [infa, infb] = panelinf([xs(k),ys(k)], [xs(k+1),ys(k+1)], xm(i,j), ym(i,j));
            psi(i,j) = psi(i,j) + gammas(k)*infa + gammas(k+1)*infb;
        end
    end
end

%plot, label, format and print contours of stream function
c = -1.75:0.25:1.75; %contour parameters
figure("Name","Cylinder (alpha = 0)")
cont1 = contour(xm, ym, psi, c);
%clabel(cont1);
set(gca,'Fontn','Times','FontSize',12,'linewidth',1)
xlabel('x')
ylabel('y')
title('Cylinder Streamlines (alpha = 0)')
%print -deps2c fig_ex4.eps

%plot circle on same graph of streamfunction contours (ie streamlines)
hold on
plot(xs,ys)
hold off

