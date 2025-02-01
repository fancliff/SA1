clear
close all

%initialise basic parameters
ReL = 1e3;
npoints = 101;
x = linspace(0,1,npoints); %actually x/L
ue = ones(1,npoints); %actually ue/U
theta = zeros(1,npoints); %actually theta/L

I10 = 0; %integral part of equation 10 in handout

for j = 2:npoints %sum contributions to integral in equation 10 over all points
    intbit = ueintbit(x(j-1),ue(j-1),x(j),ue(j));
    I10 = I10 + intbit; 
    theta(j) = sqrt(I10*0.45/ReL/(ue(j)^6)); %calculate mom thickness at each point
end

theta_blasius = 0.664/(ReL^0.5) * x.^0.5; %Blasius solution for momentum thickness

figure("Name", "Momentum Thickness ue=U");
plot(x,theta,"-", "Color","r","LineWidth",1)
hold on
plot(x,theta_blasius, "-", "Color","[0 0 1]","LineWidth",1)
hold off
set(gca,'Fontn','Times','FontSize',12,'linewidth',1)
xlabel('x/L')
ylabel('\theta/L')
legend("Thwaites","Blasius","Location","northwest")
%print -deps2c fig_ex1_mom_thickness.eps

