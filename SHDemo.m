alt = -pi/2:dx:pi/2;
az = 0:dx:2*pi;
[phi, theta] = meshgrid(az, alt);


l = 3;
m = 2;

Plm = legendre(l, cos(theta));
P32 = reshape(Plm(m+1,:,:), size(phi));

C = norm_factor(l, m);
Y32 = C.*P32.*exp(1i*m*phi);

[Xm, Ym, Zm] = sph2cart(phi, theta, real(Y32));
surf(Xm, Ym,Zm);
title('$Y_3^2$ spherical harmonic','interpreter','latex')

%Calculates the normalization factor based on a degree l and an order m
function nf = norm_factor(l, m)
abs_m = abs(m);
num = (2*l + 1)*factorial(l - abs_m);
denom = 4*pi*factorial(l + abs_m);
nf = sqrt(num/denom);
end