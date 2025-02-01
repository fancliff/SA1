function dthickdx = thickdash(xmx0, thick)
    %global variables used by thickdash
    global Re ue0 vel_grad %#ok<GVMIS>

    ue = ue0 + vel_grad*xmx0;
    theta = thick(1);
    de = thick(2);

    Retheta = Re*ue*theta;

    He = de/theta;

    if He >= 1.46
        H = (11*He+15)/(48*He-59);
    else
        H = 2.803;
    end

    c_f = 0.091416*((H-1)*Retheta)^-0.232*exp(-1.26*H);
    c_diss = 0.010024*((H-1)*Retheta)^-(1/6);

    dthickdx = [(c_f/2 - (H+2)/ue*vel_grad*theta); (c_diss - 3/ue*vel_grad*de)];
    