clear
close all

%load in required data from saved files
He4_025 = load("4_025").He;
He5_025 = load("5_025").He;
He6_025 = load("6_025").He;

theta4_025 = load("4_025").theta;
theta5_025 = load("5_025").theta;
theta6_025 = load("6_025").theta;


He6_0 = load("6_0").He;
He7_0 = load("7_0").He;

theta6_0 = load("6_0").theta;
theta7_0 = load("7_0").theta;

x = load("7_0").x;

%{
figure("Name","Theta against x, vel grad = 0")
plot(x,theta6_0,"-","Color","r","LineWidth",1.25)
hold on
plot(x,theta7_0,"-","Color","b","LineWidth",1.25)
hold off
xlabel("x/L")
ylabel("\theta/L")
set(gca,"Fontn","Times","FontSize",12,"linewidth",1)
legend("ReL=10^6","ReL=10^7","Location","northwest")
arrowtext = {"\leftarrow Natural Transition, x/L=0.37"};
text(0.38,0.00014,arrowtext,"Fontn","Times","FontSize",9,"fontweight","bold");
%print -deps2c fig_ex6_theta_0.eps

figure("Name","He against x, vel grad = 0")
plot(x,He6_0,"-","Color","r","LineWidth",1.25)
hold on
plot(x,He7_0,"-","Color","b","LineWidth",1.25)
hold off
xlabel("x/L")
ylabel("H_e")
set(gca,'Fontn','Times','FontSize',12,'linewidth',1)
legend("ReL=10^6","ReL=10^7","Location","northwest")
arrowtext = {"\leftarrow Natural Transition, x/L=0.37"};
text(0.38,1.58,arrowtext,"Fontn","Times","FontSize",9,"fontweight","bold");
%print -deps2c fig_ex6_He_0.eps


figure("Name","Theta against x, vel grad = 0")
plot(x,theta4_025,"-","Color","r","LineWidth",1.25)
hold on
plot(x,theta5_025,"-","Color","b","LineWidth",1.25)
plot(x,theta6_025,"-","Color","g","LineWidth",1.25)
hold off
xlabel("x/L")
ylabel("\theta/L")
set(gca,"Fontn","Times","FontSize",12,"linewidth",1)
legend("ReL=10^4","ReL=10^5","ReL=10^6","Location","northwest")
arrowtext = {"\leftarrow Natural Transition, x/L=0.49"};
text(0.49,0.0005,arrowtext,"Fontn","Times","FontSize",8,"fontweight","bold");
arrowtext = {"\leftarrow Laminar Separation, x/L=0.5"};
text(0.5,0.00185,arrowtext,"Fontn","Times","FontSize",8,"fontweight","bold");
text(0.5,0.006,arrowtext,"Fontn","Times","FontSize",8,"fontweight","bold");
arrowtext = {"Turbulent Reattachment, x/L=0.59 \rightarrow"};
text(0.17,0.0023,arrowtext,"Fontn","Times","FontSize",8,"fontweight","bold");
arrowtext = {"Turbulent Separation, x/L=0.82 \rightarrow"};
text(0.44,0.0096,arrowtext,"Fontn","Times","FontSize",8,"fontweight","bold");
%print -deps2c fig_ex6_theta_025.eps

figure("Name","He against x, vel grad = 0")
plot(x,He4_025,"-","Color","r","LineWidth",1.25)
hold on
plot(x,He5_025,"-","Color","b","LineWidth",1.25)
plot(x,He6_025,"-","Color","g","LineWidth",1.25)
hold off
xlabel("x/L")
ylabel("H_e")
set(gca,'Fontn','Times','FontSize',12,'linewidth',1)
legend("ReL=10^4","ReL=10^5","ReL=10^6","Location","northwest")
arrowtext = {"Natural Transition, x/L=0.49 \rightarrow"};
text(0.149,1.521,arrowtext,"Fontn","Times","FontSize",8,"fontweight","bold");
arrowtext = {"Laminar Separation, x/L=0.5 \uparrow"};
text(0.18,1.51,arrowtext,"Fontn","Times","FontSize",8,"fontweight","bold");
arrowtext = {"\leftarrow Turbulent Reattachment, x/L=0.59"};
text(0.59,1.587,arrowtext,"Fontn","Times","FontSize",8,"fontweight","bold");
arrowtext = {"Turbulent Separation, x/L=0.82 \rightarrow"};
text(0.45,1.461,arrowtext,"Fontn","Times","FontSize",8,"fontweight","bold");
%print -deps2c fig_ex6_He_025.eps

%}