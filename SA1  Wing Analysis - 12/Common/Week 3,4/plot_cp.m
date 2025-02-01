clear
close all

%profiles = {'naca6212','basg_3', 'naca0012','naca4412', 'lowRe_2a_high', 'basg_4', 'lowRe_2d_high'}; %profile/s to plot
%profiles = {'naca4412', 'naca0012', 'naca4408','naca4212', 'naca6412', 'naca6212', 'naca6206', 'naca8208'};
%profiles = {'naca0012','naca4412','highRe_1','highRe_2'};
%profiles = {'naca0012low','naca4412low','lowRe_2a','lowRe_2d'};
%profiles = {'naca0012low','naca4412low','highRe_1_low','highRe_2_low'};
%profiles = {'naca0012','naca4412','lowRe_2a_high','lowRe_2d_high'};
profiles = {'naca0012','naca4412','thick1','thick2','thick3'};

len_profiles = length(profiles);
angle = "10";
colourlist = {"r",[0 0.5 0],"b","m","#4DBEEE","#77AC30","#7E2F8E","#EDB120","#0072BD","#D95319","#A2142F","k"};
len_colourlist = length(colourlist);

figure("Name", "Surface Cp")
hold on
for i = 1:len_profiles
    data = load(strcat("Data/", profiles{i},"/",profiles{i},"_",angle));
    plot(data.xs,data.cp,".", "Color", colourlist{mod(i,len_colourlist)}, "linewidth", 0.25)
end
hold off
legend(profiles,"location","southeast")
xlabel("x")
ylabel("Cp")
ylim([-inf,1])
set(gca,'Fontn','Times','FontSize',12,'linewidth',1)
