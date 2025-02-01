function psixy = psipv(xc,yc,Gamma,x,y)
%takes inputs of vortex centre (xc,yc), vortex strength (Gamma), and location coords (x,y)
%Converts linear to radial Coordinates
r2 = (x-xc)^2 + (y-yc)^2;

% Calculates stream function with r^2 from above
psixy = - Gamma/(4*pi) * log(r2);

end