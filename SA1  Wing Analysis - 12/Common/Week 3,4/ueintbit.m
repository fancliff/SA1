function f = ueintbit(xa, ua, xb, ub)

%calculates the integral part of Eq10 in handout
%Thwaite's solution of the momentum integral equation
%Assumes a linear variation in ue

    %Calculate u_mean and delta x and u to simplify later equations
    u_mean = (ua+ub)*0.5;
    deltau = ub-ua;
    deltax = xb-xa;

    f = (u_mean^5 + 5/6 *u_mean^3*deltau^2 + 1/16 *u_mean*deltau^4)*deltax;

end