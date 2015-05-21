function [y] = periospline(x,f,t)

D=zeros(size(x,1)-1,1);
D2 = zeros(size(x,1)-2,1);
B=zeros(size(x,1)-1,1);
XEND= x(end)-x(end-1);
D(1) = 2*(XEND+ x(2)-x(1));
D2(1) = x(2) - x(1);
B(1) = 6*((f(2)-f(1))/(x(2) - x(1)) - (f(end)-f(end-1))/XEND);
for i = 1:(size(D,1)-1)
    delta1 = x(i+1)-x(i);
    delta2 = x(i+2)-x(i+1);
    D(i+1)=2*(delta1+delta2);
    if i~=(size(D,1)-1)
        D2(i+1) = delta2;
    end
    deltaf1 = f(i+1)-f(i);
    deltaf2 = f(i+2)-f(i+1);
    B(i+1) = 6*((deltaf2/delta2)-(deltaf1/delta1));
end


S = full(gallery('tridiag',D2,D,D2));

S(size(S,2),1)=XEND;
S(1,size(S,2))=XEND;

[Q,R] = qr(S,0);

s = R\(transpose(Q)*B);
s = [s;s(1)];

c1 = zeros(size(s,1)-1,1);
c2 = c1;
for i = 2:size(s,1)
    delta1 = x(i)-x(i-1);
    c1(i-1) = f(i)/delta1 - (delta1/6)*s(i);
    c2(i-1) = f(i-1)/delta1 - (delta1/6)*s(i-1);
end
y = t;

for k = 1:size(t,1)
    for i = 2:size(x,1)
        if t(k)<x(i)
            z=t(k);
            delta1 = x(i)-x(i-1);
            y(k)=((z-x(i-1))^3/(6*delta1))*s(i) - ((z-x(i))^3/(6*delta1))*s(i-1) + c1(i-1)*(z-x(i-1))+c2(i-1)*(x(i)-z);
            break
        end
    end
end
figure
axis([0 2*pi -2 2])
hold on
for i = 2:size(x,1)
        delta1 = x(i)-x(i-1);
        q = linspace(x(i-1),x(i),100);
        v=((q-x(i-1)).^3/(6*delta1))*s(i) - ((q-x(i)).^3/(6*delta1))*s(i-1) + c1(i-1)*(q-x(i-1))+c2(i-1)*(x(i)-q);
        plot(q,v)
end

hold off