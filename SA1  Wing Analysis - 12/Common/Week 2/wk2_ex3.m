clear
close all

%initialise basic parameters
ReL = 8.957e5;
%velocity gradient of d(ue/U)/d(x/L)
vel_grad = -0.25;  %-0.25 for this case
npoints = 101;
x = linspace(0,1,npoints); %actually x/L
ue = linspace(1,1+vel_grad,npoints); %acctually ue/U
theta = zeros(1,npoints); %acctually theta/L
laminar = true; % initializes boundary layer state flag
i = 1;

int = 0; %natural transition point
ils = 0; %Laminar separation

I10 = 0; %equation 10 in handout
while laminar && i < npoints
    i = i + 1;
    intbit = ueintbit(x(i-1),ue(i-1),x(i),ue(i));
    I10 = I10 + intbit;
    theta(i) = sqrt(I10*0.45/ReL/(ue(i)^6));

    m = -ReL*(theta(i))^2*vel_grad;
    He = laminar_He(thwaites_lookup(m));
    Rethet = ReL*ue(i)*theta(i);

    %test for laminar to turbulent transition
    if log(Rethet) >= 18.4*He-21.74
        laminar = false;
        %disp([x(i) (Rethet/1000])  
        int = i;
    elseif m >= 0.09 %test for laminar separation
        laminar = false;
        ils = i;
    end
end

if int ~= 0
    disp(['Natural transition at ' num2str(x(int)) ' with Rethet ' num2str(Rethet)])
end
if ils ~= 0
    disp(['Laminar seperation at ' num2str(x(ils)) ' with Rethet ' num2str(Rethet)])
end

