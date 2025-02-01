clear
close all

%global variables used by thickdash
global ReL ue0 vel_grad %#ok<GVMIS>

ue0 = 1.0;
vel_grad = 0.0;
ReL = 1e7;

%initialise turbulent boundary layer at first point
x0 = 0.01;
thick0(1) = 0.023*x0*(ReL*x0)^(-1/6);
thick0(2) = 1.83*thick0(1);

[delx, thickhist] = ode45(@thickdash, [0 0.99], thick0);
%solve ODE (15) from handout up to x=L

x = x0 + delx;

theta7 = 0.037*x.*(ReL*x).^(-1/5); %1/7th power law approximation

theta9 = 0.023*x.*(ReL*x).^(-1/6); %1/9th power law approximation

figure("Name", "Comparisons of Theta");
plot(x,thickhist(:,1),"-", "Color","r","LineWidth",1)
hold on
plot(x,theta7, "-", "Color","[0 0.5 0]","LineWidth",1)
plot(x,theta9, "-", "Color","[0 0 1]","LineWidth",1)
hold off
set(gca,'Fontn','Times','FontSize',12,'linewidth',1)
xlabel('x/L')
ylabel('\theta/L')
legend("\theta/L calculated","1/7th power estimate","1/9th power estimate","Location","northwest")
%print -deps2c fig_ex4_mom_thickness_3methods.eps