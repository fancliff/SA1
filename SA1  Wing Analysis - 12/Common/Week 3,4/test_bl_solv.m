%  Zero pressure gradient b-l; bl_solv and Blasius

clear
close all

global Re %#ok<GVMIS>

Re = 1e4;
vel_grad = -0.25;

n = 100;
x = linspace(1/n,1,n);
ue = ones(1,n) + vel_grad*x;
cp = ones(1,n) - ue.^2;
%cp = zeros(1,n); %zero pressure gradient

[int, ils, itr, its, delstar, theta] = bl_solv ( x, cp );
blthet = 0.664 * sqrt(x/Re);

if int ~= 0
  disp(['Natural transition at ' num2str(x(int))])
end
if ils ~= 0
  disp(['Laminar seperation at ' num2str(x(ils))])
end
if itr ~= 0
  disp(['Turbuent Reattachment at ' num2str(x(itr))])
end
if its ~= 0
  disp(['Turbulent seperation at ' num2str(x(its))])
end

figure(2)
plot(x,blthet,'-',x,theta,'x')
xlabel('x')
ylabel('\theta')
legend('Blasius (zero pressure gradient)','blsolv')


