function [err] = tekenkegelsnede(a,b,c,d,e,f)
err =0;
A = [a b;b c];
B = [d;e]
y = eig(A);
if y(1)<=0 || y(2)<=0
    err = 1;
    return;
end
T = transpose(-B)/A
T = transpose(T/2);
C = transpose(T)*A*T + transpose(B)*T + f;
if C > 0
    err =1;
end
fh = @(xi,yi) a*xi^2 + 2*b*xi*yi + c*yi^2 + d*xi + e*yi +f;
w =ezplot(fh);
set(w,'Color','r');
end