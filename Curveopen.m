function curveopen
[x1,y1] = click;
x1 = transpose(x1);
y1 = transpose (y1);
D=zeros(size(x1,1)-2,1);
D2 = zeros(size(x1,1)-3,1);
B=zeros(size(x1,1)-2,1);
DELTA = zeros(size(x1,1),1);
f=x1;
DELTA(1) = 0;
for i = 1:((size(x1,1))-1)
    DELTA(i+1)=DELTA(i) + sqrt((x1(i+1)-x1(i))^2 + (y1(i+1)-y1(i))^2);
end
DELTA
for i = 1:(size(D,1))
    delta1 = DELTA(i+1)-DELTA(i);
    delta2 = DELTA(i+2)-DELTA(i+1);
    D(i)=2*(delta1+delta2);
    if i~=(size(D,1))
        D2(i) = delta2;
    end
    deltaf1 = f(i+1)-f(i);
    deltaf2 = f(i+2)-f(i+1);
    B(i) = 6*((deltaf2/delta2)-(deltaf1/delta1));
end

S = full(gallery('tridiag',D2,D,D2));
s= S\B;
s = [0;s;0];
c1 = zeros(size(s,1)-1,1);
c2 = c1;
for i = 2:size(s,1)
    delta1 = DELTA(i)-DELTA(i-1);
    c1(i-1) = f(i)/delta1 - (delta1/6)*s(i);
    c2(i-1) = f(i-1)/delta1 - (delta1/6)*s(i-1);
end
D=zeros(size(y1,1)-2,1);
D2 = zeros(size(y1,1)-3,1);
B=zeros(size(y1,1)-2,1);
f=y1;

for i = 1:(size(D,1))
    delta1 = DELTA(i+1)-DELTA(i);
    delta2 = DELTA(i+2)-DELTA(i+1);
    D(i)=2*(delta1+delta2);
    if i~=(size(D,1))
        D2(i) = delta2;
    end
    deltaf1 = f(i+1)-f(i);
    deltaf2 = f(i+2)-f(i+1);
    B(i) = 6*((deltaf2/delta2)-(deltaf1/delta1));
end

S = full(gallery('tridiag',D2,D,D2));
sy= S\B;
sy = [0;sy;0];
cy1 = zeros(size(sy,1)-1,1);
cy2 = cy1;
for i = 2:size(sy,1)
    delta1 = DELTA(i)-DELTA(i-1);
    cy1(i-1) = f(i)/delta1 - (delta1/6)*sy(i);
    cy2(i-1) = f(i-1)/delta1 - (delta1/6)*sy(i-1);
end


figure
axis([0 1 0 1])
hold on
for i = 2:size(x1,1)
        delta1 = DELTA(i)-DELTA(i-1);
        q = linspace(DELTA(i-1),DELTA(i),40);
        v=(((q-DELTA(i-1)).^3)/(6*delta1))*s(i) - (((q-DELTA(i)).^3)/(6*delta1))*s(i-1) + c1(i-1)*(q-DELTA(i-1))+c2(i-1)*(DELTA(i)-q);
        h =(((q-DELTA(i-1)).^3)/(6*delta1))*sy(i) - (((q-DELTA(i)).^3)/(6*delta1))*sy(i-1) + cy1(i-1)*(q-DELTA(i-1))+cy2(i-1)*(DELTA(i)-q);
        plot(v,h,'b')
end
hold off