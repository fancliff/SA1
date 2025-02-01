clear
close all

%profiles = {'naca0012','naca0012low','naca4412','naca4412low'};
%profiles = {'naca0012','naca4412','highRe_1','highRe_2'};
%profiles = {'naca0012low','naca4412low','lowRe_2a','lowRe_2d'};
%profiles = {'naca0012','naca4412','lowRe_2a_high','lowRe_2d_high'};
profiles = {'naca0012low','naca4412low','highRe_1_low','highRe_2_low'};
%profiles = {'naca4412', 'naca0012', 'naca4408','naca4212', 'naca6412', 'naca6212', 'naca6206', 'naca8208'};
len_profiles = length(profiles);
colourlist = {"r",[0 0.5 0],"b","m","#4DBEEE","#77AC30","#7E2F8E","#EDB120","#0072BD","#D95319","#A2142F","k"};
len_colourlist = length(colourlist);


figure("Name", "Cl v alpha")
hold on
for i = 1:len_profiles
    data = load(strcat("Data/", profiles{i},"/",profiles{i}));
    plot(data.alpha,data.clswp,"x", "Color", colourlist{mod(i,len_colourlist)}, "linewidth", 1)
end
hold off
legend(profiles,"location","southeast")
xlabel("\alpha")
ylabel("C_l")
set(gca,'Fontn','Times','FontSize',12,'linewidth',1)

figure("Name", "Cd v alpha")
hold on
for i = 1:len_profiles
    data = load(strcat("Data/", profiles{i},"/",profiles{i}));
    plot(data.alpha,data.cdswp,"x", "Color", colourlist{mod(i,len_colourlist)}, "linewidth", 1)
end
hold off
legend(profiles,"location","north")
xlabel("\alpha")
ylabel("C_d")
set(gca,'Fontn','Times','FontSize',12,'linewidth',1)

figure("Name", "Cl/Cd v alpha")
hold on
for i = 1:len_profiles
    data = load(strcat("Data/", profiles{i},"/",profiles{i}));
    plot(data.alpha,data.lovdswp,"x", "Color", colourlist{mod(i,len_colourlist)}, "linewidth", 1)
end
hold off
legend(profiles,"location","southeast")
xlabel("\alpha")
ylabel("C_l/C_d")
set(gca,'Fontn','Times','FontSize',12,'linewidth',1)

figure("Name", "Cd v Cl")
hold on
for i = 1:len_profiles
    data = load(strcat("Data/", profiles{i},"/",profiles{i}));
    plot(data.clswp,data.cdswp,"x", "Color", colourlist{mod(i,len_colourlist)}, "linewidth", 1)
end
hold off
legend(profiles,"location","north")
xlabel("C_l")
ylabel("C_d")
set(gca,'Fontn','Times','FontSize',12,'linewidth',1)

