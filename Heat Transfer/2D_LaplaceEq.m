clc; clear all; close all;
x=0:1:100; y=0:1:100; n=1000;
T=zeros(101,101);

for i=1:101
    T(i,1)=0;
    T(i,101)=100;
    T(1,i)=25;
    T(101,i)=0;
end

for k=1:n
    for j=2:100
        for i=2:100
            T(i,j)=(T(i+1,j)+T(i-1,j)+T(i,j+1)+T(i,j-1))/4;
        end
    end
end

subplot(1,2,1); pcolor(x,y,T); shading interp;
title('Distribusi Suhu pada Plat 2D');
xlabel('x'); ylabel('y');
subplot(1,2,2); surfc(x,y,T); shading interp; colorbar;
xlabel('x'); ylabel('y'); zlabel('Suhu');