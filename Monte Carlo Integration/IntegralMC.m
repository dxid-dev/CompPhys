clc; clear all; close all;
f=@(x)(sin(x));
n=700;
hit=0;
miss=0;
for i=1:n
    xs=pi*rand;
    ys=1.5*rand;
    xp(i)=xs;
    yp(i)=ys;
    if ys<=f(xs)
        hit=hit+1;
    else
        miss=miss+1;
    end
end
hit;
miss;

nhit=(hit/(miss+hit))*(1.5*pi);
fprintf('Result: %f',nhit)
nmiss=(miss/(miss+hit))*(1.5*pi);
plot(xp,yp,'.');
hold on
xsin=linspace(0,pi);
ysin=f(xsin);
plot(xsin,ysin)