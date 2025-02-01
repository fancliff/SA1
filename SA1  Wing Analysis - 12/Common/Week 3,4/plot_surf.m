clear
close all

%profiles = {'reflex_1', 'reflex_3', 'lwr_reflex1', 'basg_1', 'basg_2','naca6208'}; %profile/s to plot
%profiles = {'naca0012','naca4412','lowRe_2a','lowRe_2d'};
%profiles = {'naca0012','naca4412','basg_3','basg_4'};
profiles = {'naca4412', 'naca0012', 'naca4408','naca4212', 'naca6412', 'naca6212', 'naca6206', 'naca8208'};
len_profiles = length(profiles);
colourlist = {"r",[0 0.5 0],"b","m","#4DBEEE","#77AC30","#7E2F8E","#EDB120","#0072BD","#D95319","#A2142F","k"};
len_colourlist = length(colourlist);

figure("Name", "Aerofoil surface")
hold on
for i = 1:len_profiles
    y=load(strcat('Geometry/', profiles{i},'.surf'));
    x=y(2:end-1,1);
    y=y(2:end-1,2);
    [xs, ys] = splinefit([1;x;1],[0;y;0],0);
    plot(xs,ys,"-", "Color", colourlist{mod(i,len_colourlist)}, "linewidth", 0.75)
    axis equal
end
hold off
legend(profiles,"location","southeast")
xlabel("x")
ylabel("y")
xlim([0, 1])
ylim([-0.3, 0.3])
set(gca,'Fontn','Times','FontSize',12,'linewidth',1)