clear
close all

%set size of calculation area and grid refinement
xmin = -2.5;
xmax = 2.5;
nx = 51;

ymin = -2.0;
ymax = 2.0;
ny = 41;

xc = 0.5;
yc = 0.25;
Gamma = 3.0;

%Generates matrix of zeros size nx by ny for xm, ym, and psi
xm = zeros(nx, ny);
ym = zeros(nx, ny);
psi = zeros(nx, ny);

% Writes values to the matricies
for i = 1:nx
    for j = 1:ny
        xm(i,j) = xmin + (i-1)*(xmax-xmin)/(nx-1);
        ym(i,j) = ymin + (j-1)*(ymax-ymin)/(ny-1); 
        %defines matrix grid based on number of locations and size
        psi(i,j) = psipv(xc,yc,Gamma,xm(i,j),ym(i,j));
        %calcualtes stream function at each location
    end
end

%contour parameters
c = -0.4:0.2:1.2;
%plot, label, format and print contours
figure("Name", "Point Vortex");
cont1 = contour(xm,ym,psi,c);
%clabel(cont1); %label contour values
%% set fonts and frame:
set(gca,'Fontn','Times','FontSize',12,'linewidth',1)
xlabel('x')
ylabel('y')
title('Streamlines for a point vortex at (0.5,0.25)')

%print -deps2c fig_ex1.eps
