function [cl, cd] = forces(circ,cp,delstarl,thetal,delstaru,thetau);

    cl = -2*circ;
    u_te = sqrt(1-cp(end));
    delstar_te = delstarl(end) + delstaru(end);
    theta_te = thetal(end) + thetau(end);
    H_te = delstar_te/theta_te;

    theta_infin = theta_te*(u_te)^((H_te+5)/2);
    cd = 2*theta_infin;
end

