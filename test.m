dx = 100;
theta = linspace(-pi/2, pi/2, dx);
max = 20;
alt = linspace(-pi/2,pi/2, dx);
az = linspace(0,2*pi, dx);
[phi, th] = meshgrid(alt, az);
[x, y, z] = sph2cart(phi, th, 1);

[t1, t2] = cart2sph(0.3, 0.6, 0.8);

a = 1;
b = 1;
c = 1;
d = 1;
e = 1;
f = 1;
g = 1;
h = 1;

fun2 = @(x, y, z) a.*x.*x + b.*x.*x.*x + c.* x.* y + d.*y.*z + e.*x.*z + f.*x.*y.*z + g.*z.*z.*z.*z + h.*z.*y.*x.*x;

disp(fun2(0.3, 0.6, 0.8));



f = figure;
surf(x, y, z, fun2(x, y, z));

% Plm = legendre(0,cos(theta), 'sch');
% sum = Plm;
% for t = 1:max
%     disp(t);
%     l = t;
%     Plm = legendre(l,cos(theta), 'sch');
%     sum = sum + Plm(1, :); 
%     clear Plm
% end
% 
% f1 = figure;
% plot(theta, sum);
% title(['Sum Zonal Harmonics L = 0:', num2str(max)]);
% 
% f2 = figure;
% plot(theta, sum/(max+1));
% title(['Average Zonal Harmonics L = 0:', num2str(max)]);