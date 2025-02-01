clear
close all

%initialise basic parameters
ReL = 2e7;   %[5e6, 1e7, 2e7]
%velocity gradient of d(ue/U)/d(x/L)
vel_grad = 0.1;  %[-0.1, 0.0, 0.1]
npoints = 101;
x = linspace(0,1,npoints); %actually x/L
ue = linspace(1,1+vel_grad,npoints); %acctually ue/U
theta = zeros(1,npoints);
laminar = true; % initializes boundary layer state flag
i = 1;
I10 = 0; %integral part of eq10 in handout


while laminar && i < npoints
    i = i + 1;
    intbit = ueintbit(x(i-1),ue(i-1),x(i),ue(i));
    I10 = I10 + intbit;
    theta(i) = sqrt(I10*0.45/ReL/((ue(i))^6));

    m = -ReL*(theta(i))^2*vel_grad;
    He = laminar_He(thwaites_lookup(m));
    Rethet = ReL*ue(i)*theta(i);

    %test for laminar to turbulent transition
    if log(Rethet) >= 18.4*He-21.74
        laminar = false;
        disp([x(i) Rethet/1000])
    end
end

