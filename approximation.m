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

a = 4;
b = 3;
c = 2;
d = 1;
e = -1;
f = -2;
g = -3;
h = -4;

% myCartFun = @(x, y, z) x.^2 + y.*z;
% mySphFun = @(p, t) (cos(p).*sin(t)).^2 + (sin(t).*sin(p).*cos(t));

% myCartFun = @(x, y, z) a.*x.*x + b.*x.*x.*x + c.* x.* y + d.*y.*z + e.*x.*z + f.*x.*y.*z ...
%     + g.*z.*z.*z.*z + h.*z.*y.*x.*x;

mySphFun = a.*(sin(t).*cos(p)).^2 + b.*(sin(t).*cos(p)).^3 + c.*(sin(t).*cos(p)).*(sin(t).*sin(p))...
    + d.*(sin(t).*sin(p)).*(cos(t)) + e.*(sin(t).*cos(p)).*(cos(t)) + ...
    f.*(sin(t).*cos(p)).*(sin(t).*sin(p)).*(cos(t)) + g.*(cos(t)).^4 + h.*(cos(t)).*(sin(t).*sin(p)).*(sin(t).*cos(p)).^2;

syms t p 

thetas = [-0.9, -0.5, -0.3, 0.1, 0.5, 0.7, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4];
phis = [0.4, 0.4, 0.4, 0.4, 0.4, 0.4, -0.9, -0.5, -0.3, 0.1, 0.5, 0.7];
actuals = zeros(1, 12);
approxs = zeros(1, 12);
diffs = zeros(1, 12);
max = 20;

approx = myApprox(mySphFun, max);
for idx = 1:12
   approxs(idx) = double(subs(approx, [t, p], [thetas(idx), phis(idx)]));
   actuals(idx) = double(subs(mySphFun, [t, p], [thetas(idx), phis(idx)]));
   diffs(idx) = approxs(idx) - actuals(idx);
end
data = [thetas; phis; actuals; approxs; diffs].';
f = figure;
uit = uitable(f);
uit.Data = data;
uit.ColumnName = {"theta"; "phi"; "actual"; "approx"; "diff"};
uit.Position = [20 155 415 230];
uicontrol('Style', 'text', 'Position', [20 390 400 22], 'String', ...
    "4x^2 + 3x^3 + 2xy + yz - xz - 2x^2z - 3z^4 - 4zyx^2, L = 1:" + num2str(max));

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
