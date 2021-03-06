function [a,b,c,d,e,f] = ellips(x,y)
%function that returnes an elllips approximating the given (x,y) points
%given by the vectors x and y.
A=[];
B=zeros(size(x));
size(x,1)
for i=1:size(x,1)
    
    B(i)= -(x(i)^2);
    F= [2*x(i)*y(i) (y(i)^2)-(x(i)^2) x(i) y(i) 1];
    A=[A;F];
end
[Q,R] = qr(A,0);

Z = R\(transpose(Q)*B);
b = Z(1);
c = Z(2);
d = Z(3);
e = Z(4);
f = Z(5);
a = 1-c;
hold on
fh = @(xi,yi) a*xi.^2 + 2*b*xi.*yi + c*yi.^2 + d*xi + e*yi +f;

w =ezplot(fh);
set(w,'Color','r');

plot(transpose(x),transpose(y),'h')
hold off