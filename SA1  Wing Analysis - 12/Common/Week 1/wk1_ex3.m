clear
close all

%sets grid size and refinement
xmin = 0.0;
xmax = 5.0;
nx = 51;

ymin = 0.0;
ymax = 4.0;
ny = 41;

nv = 100; %number of discrete vortices for approximation

%define locations of vortex sheet ends and the length, del, of the sheet
a = [3.5, 2.5];
b = [1.6, 1.1];
del = norm(b-a);

%Generates matrix of zeros size nx by ny for xm, ym, 
%and infa, infb and their approximations
xm = zeros(nx, ny);
ym = zeros(nx, ny);
infa = zeros(nx, ny);
infb = zeros(nx, ny);
infa_approx = zeros(nx, ny);
infb_approx = zeros(nx, ny);


% Writes values to the matricies
for i = 1:nx
    for j = 1:ny
        xm(i,j) = xmin + (i-1)*(xmax-xmin)/(nx-1);
        ym(i,j) = ymin + (j-1)*(ymax-ymin)/(ny-1);
        [infa(i,j), infb(i,j)] = panelinf(a,b, xm(i,j), ym(i,j)); %analytical solution of influence coefficients
    end
end

%caclulate approximate infa and infb using the discrete vortex method
%for infa_approx use gamma_a = 1, gamma_b = 0 and vice versa for infb_approx
for k = 0:nv-1 %nv equispaced vortices between a and b
    %Calc the local vorticity
    gamma_infa = (1 - (k+0.5)/nv)*del/nv;
    gamma_infb = ((k+0.5)/nv)*del/nv;
    % Calc location of each discrete vortex k
    xc = a(1)+(b(1)-a(1))*(k+0.5)/nv;
    yc = a(2)+(b(2)-a(2))*(k+0.5)/nv;
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
%print -deps2c fig_ex3_infa_analytic.eps

figure("Name","Analytical influence coefficient b")
cont2 = contour(xm, ym, infb, c);
%clabel(cont2);
set(gca,'Fontn','Times','FontSize',12,'linewidth',1)
xlabel('x')
ylabel('y')
title('Contours of Influence Coefficient b (Analytical)')
%print -deps2c fig_ex3_infb_analytic.eps

figure("Name","Discrete approximation influence coefficient a")
cont3 = contour(xm, ym, infa_approx, c);
%clabel(cont3);
set(gca,'Fontn','Times','FontSize',12,'linewidth',1)
xlabel('x')
ylabel('y')
title('Contours of Influence Coefficient a (Approximate)')
%print -deps2c fig_ex3_infa_approx.eps

figure("Name","Discrete approximation influence coefficient b")
cont4 = contour(xm, ym, infb_approx, c);
%clabel(cont4);
set(gca,'Fontn','Times','FontSize',12,'linewidth',1)
xlabel('x')
ylabel('y')
title('Contours of Influence Coefficient b (Approximate)')
%print -deps2c fig_ex3_infb_approx.eps

