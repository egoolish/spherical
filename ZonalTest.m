dx = pi/360;
alt = -pi/2:dx:pi/2;
az = 0:dx:2*pi;
[phi, theta] = meshgrid(az, alt);

fff = figure;
m = 0;
l = 5;
Plm = legendre(l,cos(theta), 'sch');
sum = reshape(Plm(m+1,:,:), size(phi));
plot(theta, sum);
title('Single Zonal Harmonic L = 5');

f11 = figure;
l = 10;
Plm = legendre(l,cos(theta), 'sch');
sum = reshape(Plm(m+1,:,:), size(phi));
plot(theta, sum);
title('Single Zonal Harmonic L = 10');

f12 = figure;
l = 15;
Plm = legendre(l,cos(theta), 'sch');
sum = reshape(Plm(m+1,:,:), size(phi));
plot(theta, sum);
title('Single Zonal Harmonic L = 15');

Plm = legendre(0,cos(theta));
sum = Plm;
for l = 1:30
    Plm = legendre(l,cos(theta), 'sch');
    sum = sum + reshape(Plm(m+1,:,:), size(phi));
end

f1 = figure;
plot(theta, sum);
title('Sum Zonal Harmonics L = 0:30');

f2 = figure;
plot(theta, sum/31);
title('Average Zonal Harmonics L = 0:30');

%select(legendre(l, cos(t)),p);
%select = @(LP, p) reshape(LP(abs(m)+1,:,:), size(p));

%[Xm,Ym,Zm] = sph2cart(phi, theta, real(P32));
%surf(Xm,Ym,Zm)