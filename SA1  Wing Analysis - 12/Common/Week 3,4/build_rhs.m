function rhsvec = build_rhs(xs,ys,alpha)
    np = length(xs) - 1; %1 repeated x,y coordinate for first and last panel
    rhsvec = zeros(np+1,1); %initialise output, b vector in handout, column vector
    for i = 2:np %leaves first and last rows zero because gamma(1) = gamma(np+1) = 0
        rhsvec(i) = (ys(i)-ys(i+1))*cos(alpha) - (xs(i)-xs(i+1))*sin(alpha);
        %define free-stream stream function based on angle of attack as y.cos(alpha)-x.sin(alpha)
    end
end
