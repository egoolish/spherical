mySphFun = (sin(t).*cos(p)).^2 + (sin(t).*cos(p)).^3 + (sin(t).*cos(p)).*(sin(t).*sin(p))...
    + (sin(t).*sin(p)).*(cos(t)) + (sin(t).*cos(p)).*(cos(t)) + ...
    (sin(t).*cos(p)).*(sin(t).*sin(p)).*(cos(t)) + (cos(t)).^4 + (cos(t)).*(sin(t).*sin(p)).*(sin(t).*cos(p)).^2;


syms t p 
els = zeros(1, 10);
actuals = zeros(1, 10);
approxs = zeros(1, 10);
diffs = zeros(1, 10);
max = 15;


for idx = 0:max-1
   els(idx+1) = idx;
   approx = myApprox(mySphFun, idx);
   approxs(idx+1) = double(subs(approx, [t, p], [0.5, 0.4]));
   actuals(idx+1) = double(subs(mySphFun, [t, p], [0.5, 0.4]));
   diffs(idx+1) = approxs(idx+1) - actuals(idx+1);
end
data = [els; actuals; approxs; diffs].';
f = figure;
uit = uitable(f);
uit.Data = data;
uit.ColumnName = {"# of Terms"; "actual"; "approx"; "diff"};
uit.Position = [20 120 415 170];
uicontrol('Style', 'text', 'Position', [20 390 400 22], 'String', ...
    "4x^2 + 3x^3 + 2xy + yz - xz - 2x^2z - 3z^4 - 4zyx^2, theta = 0.5, phi = 0.4");

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