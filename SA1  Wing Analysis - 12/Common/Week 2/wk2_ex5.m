clear
close all
%global variables used by thickdash
global ReL ue0 vel_grad %#ok<GVMIS>

%{
ue0 = 1.0;
vel_grad = [-0.25, -0.5, -0.95]; 
ReL = 1e7;
%}
%{
ue0 = 1.0;
vel_grad = -0.5; 
ReL = [1e6, 1e7, 1e8];
%}

ue0 = 1.0;
vel_grad = -0.5;
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


He = thickhist(:, 2)./thickhist(:, 1);
HeSep = 1.46.*ones(1,length(delx)); %turbulent separation below He=1.46

seploc = 0;
%check for turbulent separation
for i = 30:length(delx) %ignore numerical errors in first few points
%use plot below to decide size of loop
    if He(i-1)>1.46 && He(i)<1.46
        seploc = x(i); 
        %could do linear interpolation for extra accuracy
        %less effect as number of points is increased
        break %no point checking further downstream values
    end
end

if seploc ~= 0
    seploc %#ok<NOPTS>
end

figure("Name", "H_e vs x/L");
plot(x,He,"-", "Color","r","LineWidth",1)
hold on
plot(x,HeSep,"-", "Color", "[0 0 1]","LineWidth",1)
hold off
set(gca,'Fontn','Times','FontSize',12,'linewidth',1)
xlabel('x/L')
ylabel('H_e')


figure("Name", "Comparisons of Theta and d_e");
plot(x,thickhist(:,1),"-", "Color","r","LineWidth",1)
hold on
plot(x,thickhist(:,2), "-", "Color","[0 0.5 0]","LineWidth",1)
hold off
set(gca,'Fontn','Times','FontSize',12,'linewidth',1)
xlabel('x/L')
ylabel('\theta/L, \delta_e/L')
legend("\theta/L","\delta_e/L","Location","northwest")
%print -deps2c fig_ex5_theta_delta_e.eps