theta = linspace(-pi/2, pi/2, 720000);
z1 = linspace(0, 1, 360000);
z2 = linspace(1, 0, 360000);
z = [z1, z2];
max = 20;

%fun = @(p, t) sin(t).^3.*cos(p).*sin(p).^2 + 2*sin(t).^2.*cos(p).*sin(p).*cos(t) - sin(t).^3.*cos(p).^3;

Plm = legendre(0,cos(theta), 'sch');
sum = Plm;
for t = 1:max
    disp(t);
    l = t;
    Plm = legendre(l,cos(theta), 'sch');
    sum = sum + Plm(1, :); 
    clear Plm
end

f1 = figure;
plot(theta, sum);
title(['Sum Zonal Harmonics L = 0:', num2str(max)]);

f2 = figure;
plot(theta, sum/(max+1));
title(['Average Zonal Harmonics L = 0:', num2str(max)]);