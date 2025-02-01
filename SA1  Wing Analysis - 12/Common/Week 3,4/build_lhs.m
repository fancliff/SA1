function lhsmat = build_lhs(xs,ys)
    np = length(xs) - 1; %1 repeated x,y coordinate for first and last panel
    psip = zeros(np+1,np+1); %intermediate matrix as described in handout
    lhsmat = zeros(np+1,np+1); %output from function (A matrix in handout)

    for i = 1:np+1 
        %loop over all panels and populate intermediate matrix with the corresponding ...
        %influence coefficients from the handout. 
        %influence coefficients are calculated at and from the panel edge points.
        j=1;
        [infa, infb] = panelinf([xs(j),ys(j)], [xs(j+1),ys(j+1)], xs(i), ys(i));
        psip(i,j) = infa;

        for j = 2:np
            infb_prev = infb; %store previous value of infb as reqd from eqn5 in handout
            [infa, infb] = panelinf([xs(j),ys(j)], [xs(j+1),ys(j+1)], xs(i), ys(i));
            psip(i,j) = infa + infb_prev;
        end

        j= np+1;
        psip(i,j) = infb; %infb(np) due to strucutre of above for loop
    end

    for j = 1:np+1 %populate output matrix, column entries
        for i = 2:np %row entries
            %leaves first and last rows zero for now.
            %np-1 equations for panel edges from this loop.
            lhsmat(i,j) = psip(i+1,j) - psip(i,j);
        end
    end
    
    %define first and last matrix rows according to new averaged Kutta condition
    lhsmat(1,1) = 1;
    lhsmat(1,2) = -1;
    lhsmat(1,3) = 0.5;
    lhsmat(1,np-1) = -0.5;
    lhsmat(1,np) = 1;

    lhsmat(np+1,1) = 1;
    lhsmat(np+1,np+1) = 1;

end
