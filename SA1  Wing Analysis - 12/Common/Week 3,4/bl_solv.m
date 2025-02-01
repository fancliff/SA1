function [int, ils, itr, its, delstar, theta] = bl_solv(x,cp)
    n = length(x); %number of panels

    global Re ue0 vel_grad %#ok<GVMIS>

    ue = sqrt(1-cp); %acctually ue/U
    duedx = zeros(1,n);
    duedx(1) = (ue(1))/(x(1));
    for i = 2:n
        duedx(i) = (ue(i)-ue(i-1))/(x(i)-x(i-1));
    end
    theta = zeros(1,n); %acctually theta/L
    delstar = zeros(1,n); %actually delstar/L
    %He = 1.57258*ones(1,n);

    int = 0; %natural transition point
    ils = 0; %Laminar separation
    itr = 0; %Turbulent reattachement
    its = 0; %Turbulent separation

    I10 = 0; %equation 10 in handout

    i = 0;
    laminar = true; % initializes boundary layer state flag

    while laminar && i < n
        i = i + 1;
        if i == 1
            intbit = ueintbit(0,0,x(1),ue(1));
        else
            intbit = ueintbit(x(i-1),ue(i-1),x(i),ue(i));
        end
        I10 = I10 + intbit;
        theta(i) = sqrt(I10*0.45/Re/(ue(i)^6));

        m = -Re*(theta(i))^2*duedx(i);
        H = thwaites_lookup(m);
        He = laminar_He(H);
        delstar(i) = H*theta(i);
        
        Rethet = Re*ue(i)*theta(i);

        %test for turbulence
        if log(Rethet) >= 18.4*He-21.74
            laminar = false;
            %disp([x(i) (Rethet/1000])  
            int = i;
        elseif m >= 0.09
            laminar = false;
            ils = i;
            He = 1.51509;
        end
    end
    de = He*theta(i);

    while its == 0 && i < n
        ue0 = ue(i);
        vel_grad = duedx(i);
        thick0 = [theta(i), de];

        i = i + 1;

        [~ , thickhist] = ode45(@thickdash,[0,x(i)-x(i-1)],thick0);
        
        theta(i) = thickhist(end, 1);
        de = thickhist(end, 2);
        He = de/theta(i);
        H = (11*He+15)/(48*He-59);

        if He >= 1.58 && ils ~= 0 && itr == 0 % Turbulent reattachent
            itr = i;
        
        elseif He < 1.46 % Turbulent seperation
            its = i;
            H = 2.803;
        end
        delstar(i) = H*theta(i);
    end

    while its ~= 0 && i < n
        i = i+1;
        theta(i) = theta(its)*(ue(its)/ue(i))^(H+2);
        delstar(i) = H*theta(i);
    end
end
