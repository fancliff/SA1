clear
close all

np = 100; %number of panels in approx
nx = 51; %grid refinement
ny = 41;
theta = (0:np)*2*pi/np; %angles of panel edges

%co-ordinates of panle edges
xs = cos(theta);
ys = sin(theta);

%angle of attack of inclined cylinder
aoa = pi/24;

circ_0 = 0;
circ_a = 0;
L_panel = 2*sin(pi/np); %length of each of np panels

%calculate A matrix and b vector from handout
Amat = build_lhs(xs,ys);
b0 = build_rhs(xs,ys,0); %0 angle of attack
ba = build_rhs(xs,ys,aoa);

%solve equation gamma = A(inv)b
gam_0 = Amat\b0;
gam_a = Amat\ba;

for i = 1:np+1 %sum circulation for all panels 
    circ_0 = circ_0 + gam_0(i)*L_panel;
    circ_a = circ_a + gam_a(i)*L_panel;
end

%print total circulation for alpha = 0 and pi/24
circ_0
circ_a

pltvar = theta/pi; %variable to plot gamma against

%plot, label, format and print values of surface velocity (ie panel gamma) around the cylinder
figure("Name", "Surf Vels Alpha = 0");
plot(pltvar,gam_0)
axis([0 2 -2.5 2.5])
set(gca,'Fontn','Times','FontSize',12,'linewidth',1)
xlabel('\Theta/\pi')
ylabel('Velocity')
title('Surface Velocity (\alpha = 0)')
%print -deps2c fig_ex5_surfvel_0.eps

figure("Name", "Surf Vels Alpha = pi/24");
plot(pltvar,gam_a)
axis([0 2 -2.5 2.5])
set(gca,'Fontn','Times','FontSize',12,'linewidth',1)
xlabel('\Theta/\pi')
ylabel('Velocity')
title('Surface Velocity (\alpha = \pi/24)')
%print -deps2c fig_ex5_surfvel_a.eps

%combined plot
figure("Name", "Surf Vels Both");
plot(pltvar,gam_a, "-", "Color","r","LineWidth",1)
hold on
plot(pltvar,gam_0, "-", "Color","[0 0.5 0]","LineWidth",1)
hold off
axis([0 2 -2.5 2.5])
set(gca,'Fontn','Times','FontSize',12,'linewidth',1)
xlabel('\Theta/\pi')
ylabel('Velocity')
title('Surface Velocity (\alpha = \pi/24 & 0)')
legend("\alpha = \pi/24","\alpha = 0","Location","northwest")
%print -deps2c fig_ex5_surfvel_both.eps

%streamline plotting below for alpha = pi/24
xmin = -2.5;
xmax = 2.5;

ymin = -2.0;
ymax = 2.0;

xm = zeros(nx, ny);
ym = zeros(nx, ny);

%define grid co-ordinates
for i = 1:nx
    for j = 1:ny
        xm(i,j) = xmin + (i-1)*(xmax-xmin)/(nx-1);
        ym(i,j) = ymin + (j-1)*(ymax-ymin)/(ny-1);
    end
end

psi = ym*cos(aoa) - xm*sin(aoa); %angled free-stream contribution to stream function

%panel circulation contributions to stream function
%for all grid points and all np panels
for k = 1:np
    for i = 1:nx
        for j = 1:ny
            [infa, infb] = panelinf([xs(k),ys(k)], [xs(k+1),ys(k+1)], xm(i,j), ym(i,j));
            psi(i,j) = psi(i,j) + gam_a(k)*infa + gam_a(k+1)*infb;
        end
    end
end

c = -1.75:0.25:1.75; %contour parameters
%plot, label, format and print contours of stream function
figure("Name", "Alpha = pi/24");
cont1 = contour(xm, ym, psi, c);
%clabel(cont1);
set(gca,'Fontn','Times','FontSize',12,'linewidth',1)
xlabel('x')
ylabel('y')
title('Cylinder Streamlines (\alpha = \pi/24)')
%print -deps2c fig_ex5_streamlines.eps

%plot circle on same graph of streamfunction contours (ie streamlines)
hold on
plot(xs,ys)
hold off