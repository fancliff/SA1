function [infa, infb] = panelinf(a,b,x,y)

    %Vectors of locations of a, b and the vector location of r
    vpoint = [x, y];
    va = a;
    vb = b;

    vpanel = vb - va; %panel vector
    rv = vpoint - va;

    t = vpanel/norm(vpanel); %unit row vector parallel to panel
    theta = pi/2;
    R = [cos(theta) -sin(theta); sin(theta) cos(theta)]; %90 degrees anticlockwise rotation matrix
    n = (R*t')'; %unit row vector perpendicular to panel

    X = dot(rv,t); % X co-ordinate in panel reference frame
    Y = dot(rv,n); % Y co-ordinate in panel reference frame

    [infa, infb] = refpaninf(norm(vpanel),X,Y); %use existing function with panel length 
    %and point co-ordinates in panel reference frame to find influence coeffs
end