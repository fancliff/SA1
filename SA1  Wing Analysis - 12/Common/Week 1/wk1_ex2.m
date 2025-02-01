clear
close all

%define grid size and refinement level
xmin = -2.5;
xmax = 2.5;
nx = 51;

ymin = -2.0;
ymax = 2.0;
ny = 41;

%set vortex sheet parameters and number of vortices for discrete approximation
del = 1.5;
nv = 100;
yc = 0;


%Generates matrix of zeros size nx by ny for xm, ym, infa, infb and psi_approx
xm = zeros(nx, ny);
ym = zeros(nx, ny);
infa = zeros(nx, ny);
infb = zeros(nx, ny);
infa_approx = zeros(nx, ny);
infb_approx = zeros(nx, ny);


% Writes values to the matricies
for i = 1:nx
    for j = 1:ny
        %calculate location of grid points and influence coefficients
        xm(i,j) = xmin + (i-1)*(xmax-xmin)/(nx-1);
        ym(i,j) = ymin + (j-1)*(ymax-ymin)/(ny-1);
        [infa(i,j), infb(i,j)] = refpaninf(del, xm(i,j), ym(i,j));
    end
end


%caclulate approximate infa and infb 
%using a series of discrete vortices equispaced along the vortex sheet
%for infa_approx use gamma_a = 1, gamma_b = 0 and vice versa for infb_approx
for k = 0:nv-1 %nv discrete vortices
    %Calc the local vorticity of each discrete vortex
    gamma_infa = (1 - (k+0.5)/nv)*del/nv;
    gamma_infb = ((k+0.5)/nv)*del/nv;
    % Calc xc (location of each discrete vortex) for each k
    xc = (k+0.5)*del/nv;
    for i = 1:nx
        for j = 1:ny
            %Calculate influence coefficients and add to total
            infa_approx(i,j) = infa_approx(i,j) + psipv(xc,yc,gamma_infa,xm(i,j),ym(i,j));
            infb_approx(i,j) = infb_approx(i,j) + psipv(xc,yc,gamma_infb,xm(i,j),ym(i,j));
        end
    end
end

%plot, label, format and print contours of influence coefficients a and b 
%for the analytical and approximate solutions

c = -0.15:0.05:0.15; %contour parameters

figure("Name","Analytical influence coefficient a")
cont1 = contour(xm, ym, infa, c);
%clabel(cont1);
set(gca,'Fontn','Times','FontSize',12,'linewidth',1)
xlabel('x')
ylabel('y')
title('Contours of Influence Coefficient a (Analytical)')
%print -deps2c fig_ex2_infa_analytic.eps

figure("Name","Analytical influence coefficient b")
cont2 = contour(xm, ym, infb, c);
%clabel(cont2);
set(gca,'Fontn','Times','FontSize',12,'linewidth',1)
xlabel('x')
ylabel('y')
title('Contours of Influence Coefficient b (Analytical)')
%print -deps2c fig_ex2_infb_analytic.eps

figure("Name","Discrete approximation influence coefficient a")
cont3 = contour(xm, ym, infa_approx, c);
%clabel(cont3);
set(gca,'Fontn','Times','FontSize',12,'linewidth',1)
xlabel('x')
ylabel('y')
title('Contours of Influence Coefficient a (Approximate)')
%print -deps2c fig_ex2_infa_approx.eps

figure("Name","Discrete approximation influence coefficient b")
cont4 = contour(xm, ym, infb_approx, c);
%clabel(cont4);
set(gca,'Fontn','Times','FontSize',12,'linewidth',1)
xlabel('x')
ylabel('y')
title('Contours of Influence Coefficient b (Approximate)')
%print -deps2c fig_ex2_infb_approx.eps

