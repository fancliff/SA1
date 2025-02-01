function [infa, infb] = refpaninf(del,X,Yin)
%takes inputs of vortex sheet length (del) , and location coordinates (X,Yin)
%and returns influence coefficients for a and b
%Vortex sheet positioned from a = (0,0) to b = (del,0)


%error handling trap if Yin is requested very close to 0 
%so that log(0) and divide by 0 errors are not encountered
if abs(Yin) < 1e-9
    Y = 1e-9;
else
    Y = Yin;
end

%calculate intermediary values I0 and I1 using equations in handout
I0 = (-1/(4*pi)) * ( X*log(X^2 + Y^2) - (X-del)*log((X-del)^2 + Y^2) - 2*del + 2*Y* (atan(X/Y) - atan((X-del)/Y)) );

I1 = (1/(8*pi)) * ( (X^2 + Y^2)*log(X^2 + Y^2) - ((X-del)^2 + Y^2)*log((X-del)^2 + Y^2) - 2*X*del + del^2);

%define influence coefficients from handout
infa = ((1-X/del)*I0 - I1/del);
infb = (I0*X/del + I1/del);

end