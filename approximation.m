global a
global b
global c
global d
global e
global f
global g
global h
global mySphFun
syms p t

a = -1;
b = 3;
c = -6;
d = 3;
e = 1;
f = -1;
g = 2;
h = -1;

% myCartFun = @(x, y, z) x.^2 + y.*z;
% mySphFun = @(p, t) (cos(p).*sin(t)).^2 + (sin(t).*sin(p).*cos(t));

% myCartFun = @(x, y, z) a.*x.*x + b.*x.*x.*x + c.* x.* y + d.*y.*z + e.*x.*z + f.*x.*y.*z ...
%     + g.*z.*z.*z.*z + h.*z.*y.*x.*x;
 
mySphFun = a.*(sin(t).*cos(p)).^2 + b.*(sin(t).*cos(p)).^3 + c.*(sin(t).*cos(p)).*(sin(t).*sin(p))...
    + d.*(sin(t).*sin(p)).*(cos(t)) + e.*(sin(t).*cos(p)).*(cos(t)) + ...
    f.*(sin(t).*cos(p)).*(sin(t).*sin(p)).*(cos(t)) + g.*(cos(t)).^4 + h.*(cos(t)).*(sin(t).*sin(p)).*(sin(t).*cos(p)).^2;

syms t p 
approx = myApprox(mySphFun, 50);
t1 = 0.5;
p1 = 0.7;
disp(double(subs(approx, [t, p], [t1, p1])));
disp(double(subs(mySphFun, [t, p], [t1, p1])));


function output = myApprox(fun, max)
    syms p t
    output = 0;
    for l = 0:max
        disp(l);
        fun_real = sin(t).*fun.*getLegendre(l, cos(t));
        coeff = ((2.*l+1)./2) .* int(fun_real, t, 0, pi);
        output = output + coeff.*getLegendre(l, cos(t));
    end
end

function out = getLegendre(l, t)
    whole = legendreP(l, t);
    out = whole(1, :);
end

% function output = myApprox(x, y, z, max)
%     global mySphFun
%     r = sqrt(x.^2+y.^2+z.^2);
%     t = acos(z/r);
%     output = 0;
%     for l = 0:max
%         disp("l : " + num2str(l) + ", x : " + num2str(output));
%         fun_l = @(p, t) sin(t) .* mySphFun(p, t) .* getLegendre(t, l);
%         coeff_l = integral2(fun_l, 0, 2*pi, 0, pi, 'AbsTol', 1e-12);
%         output = output + (coeff_l .* getLegendre(t, l));
%     end
% end
% 
% function out = getLegendre(t, l)
%     whole = legendre(l, cos(t), 'sch');
%     out = squeeze(whole(1, :, :));
% end
