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

a = 2;
b = -2;
c = 4;
d = -4;
e = -1;
f = 1;
g = -3;
h = 3;

% myCartFun = @(x, y, z) x.^2 + y.*z;
% mySphFun = @(p, t) (cos(p).*sin(t)).^2 + (sin(t).*sin(p).*cos(t));

% myCartFun = @(x, y, z) a.*x.*x + b.*x.*x.*x + c.* x.* y + d.*y.*z + e.*x.*z + f.*x.*y.*z ...
%     + g.*z.*z.*z.*z + h.*z.*y.*x.*x;

mySphFun = a.*(sin(t).*cos(p)).^2 + b.*(sin(t).*cos(p)).^3 + c.*(sin(t).*cos(p)).*(sin(t).*sin(p))...
    + d.*(sin(t).*sin(p)).*(cos(t)) + e.*(sin(t).*cos(p)).*(cos(t)) + ...
    f.*(sin(t).*cos(p)).*(sin(t).*sin(p)).*(cos(t)) + g.*(cos(t)).^4 + h.*(cos(t)).*(sin(t).*sin(p)).*(sin(t).*cos(p)).^2;

syms t p 

theta = 0.5;
dx = 100;
phis = linspace(-1, 1, dx);
actuals = zeros(1, dx);
approxs = zeros(1, dx);
diffs = zeros(1, dx);
max = 20;

approx = myApprox(mySphFun, max);
for idx = 1:dx
   approxs(idx) = double(subs(approx, [t, p], [theta, phis(idx)]));
   actuals(idx) = double(subs(mySphFun, [t, p], [theta, phis(idx)]));
   diffs(idx) = approxs(idx) - actuals(idx);
end
f = figure;
plot(thetas, actuals, thetas, approxs, thetas, diffs);
title("2x^2 - 2x^3 + 4xy - 4yz - xz + x^2z - 3z^4 + 3zyx^2, theta = 0.5, L = 1:" + num2str(max));
xlabel("Phi");
legend({'Actual', 'Approx', 'Diff'});
    

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
