clear
close all

npoints = 101;

global ReL ue0 vel_grad %#ok<GVMIS>
%initialise basic parameters
ReL = 1e5;
%velocity gradient of d(ue/U)/d(x/L)
vel_grad = -0.381;  

x = linspace(0,1,npoints); %actually x/L
ue = linspace(1,1+vel_grad,npoints); %acctually ue/U
theta = zeros(1,npoints); %acctually theta/L
He = 1.57258*ones(1,npoints);

laminar = true; % initializes boundary layer state flag

i = 1;

int = 0; %natural transition point
ils = 0; %Laminar separation
itr = 0; %Turbulent reattachement
its = 0; %Turbulent separation

I10 = 0; %equation 10 in handout

while laminar && i < npoints
    i = i + 1;
    intbit = ueintbit(x(i-1),ue(i-1),x(i),ue(i));
    I10 = I10 + intbit;
    theta(i) = sqrt(I10*0.45/ReL/(ue(i)^6));

    m = -ReL*(theta(i))^2*vel_grad;
    He(i) = laminar_He(thwaites_lookup(m));
    
    Rethet = ReL*ue(i)*theta(i);

    %test for turbulence
    if log(Rethet) >= 18.4*He(i)-21.74
        laminar = false;
        %disp([x(i) (Rethet/1000])  
        int = i;
    elseif m >= 0.09
        laminar = false;
        ils = i;
        He(i) = 1.51509;
    end
end
de = He(i)*theta(i);

while its == 0 && i < npoints

    thick0 = [theta(i), de];
    ue0 = ue(i);

    i = i + 1;

    [delx, thickhist] = ode45(@thickdash,[0,x(i)-x(i-1)],thick0);
    
    theta(i) = thickhist(end, 1);
    de = thickhist(end, 2);

    He(i) = de/theta(i);

    %disp(He(i))
    if He(i) >= 1.58 && ils ~= 0 && itr == 0 % Turbulent reattachent
        itr = i;
    
    elseif He(i) < 1.46 % Turbulent seperation
        its = i;
    end
end

He(i:npoints) = He(i);

while its ~= 0 && i < npoints
    i = i+1;
    theta(i) = theta(its)*(ue(its)/ue(i))^(2.803+2);
end

if int ~= 0
    disp(['Natural transition at ' num2str(x(int)) ' with Rethet ' num2str(ReL*ue(int)*theta(int))])
end
if ils ~= 0
    disp(['Laminar seperation at ' num2str(x(ils)) ' with Rethet ' num2str(ReL*ue(ils)*theta(ils))])
end
if itr ~= 0
    disp(['Turbuent Reattachment at ' num2str(x(itr)) ' with Rethet ' num2str(ReL*ue(itr)*theta(itr))])
end
if its ~= 0
    disp(['Turbulent seperation at ' num2str(x(its)) ' with Rethet ' num2str(ReL*ue(its)*theta(its))])
end


%save 6_025.mat -v7.3 %save data to a relevant file

%example plotting

figure("Name", "\theta/L vs x/L");
plot(x,theta,"-", "Color","r","LineWidth",1)
set(gca,'Fontn','Times','FontSize',12,'linewidth',1)
xlabel('x/L')
ylabel('\theta/L')

figure("Name", "H_e vs x/L");
plot(x,He,"-", "Color","r","LineWidth",1)
set(gca,'Fontn','Times','FontSize',12,'linewidth',1)
xlabel('x/L')
ylabel('H_e')
%}