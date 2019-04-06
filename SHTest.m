theta = linspace(-pi/2, pi/2, 3600);
max = 20;
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