clear
close all

%profiles = {'naca6212','basg_3', 'naca0012','naca4412', 'test_1', 'basg_4'}; %profile/s to plot
%profiles = {'naca0012_3','naca0012_9'};
profiles = {'naca4412_3','naca4412_9'};
len_profiles = length(profiles);
colourlist = {"r",[0 0.5 0],"b","m","#4DBEEE","#77AC30","#7E2F8E","#EDB120","#0072BD","#D95319","#A2142F","k"};
len_colourlist = length(colourlist);

% Load the image
%img = imread('0012clvaexperimental.png');
img = imread('4412clvaexperimental.png');

% Create figure
figure("Name", "Cl v alpha");

% Plot the image
imagesc([-24, 24], [-1.8, 1.8], flipud(img)); % Flip the image vertically for correct orientation
set(gca, 'YDir', 'normal'); % Correct the Y-axis direction

% Hold on to plot over the image
hold on;

for i = 1:len_profiles
    data = load(strcat("Data/", profiles{i},"/",profiles{i}));
    plot(data.alpha,data.clswp,"x", "Color", colourlist{mod(i,len_colourlist)}, "linewidth", 1)
end

% Set axis limits
xlim([-24, 24]);
ylim([-1.8, 1.8]);

legend(profiles,"location","southeast")
xlabel("\alpha")
ylabel("C_l")
set(gca,'Fontn','Times','FontSize',12,'linewidth',1)

hold off;



% Load the image
%img = imread('0012cdvclexperimental.png');
img = imread('4412cdvclexperimental.png');

% Create figure
figure("Name", "Cd v Cl");

% Plot the image
imagesc([-1.6, 1.6], [0, 0.024], flipud(img)); % Flip the image vertically for correct orientation
set(gca, 'YDir', 'normal'); % Correct the Y-axis direction

% Hold on to plot over the image
hold on;

for i = 1:len_profiles
    data = load(strcat("Data/", profiles{i},"/",profiles{i}));
    plot(data.clswp,data.cdswp,"x", "Color", colourlist{mod(i,len_colourlist)}, "linewidth", 1)
end

% Set axis limits
xlim([-1.6, 1.6]);
ylim([0, 0.024]);

legend(profiles,"location","northwest")
xlabel("C_l")
ylabel("C_d")
set(gca,'Fontn','Times','FontSize',12,'linewidth',1)

hold off;

