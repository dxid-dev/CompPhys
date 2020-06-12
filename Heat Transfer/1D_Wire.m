clc; clear all; close all;
L = 1; t = 1;
dx=0.05; dt = 0.002;
stepx=L/dx; stept=t/dt; 
k1=1/4; lam1 =(k1*dt/(dx^2));
k2=1/16; lam2 =(k2*dt/(dx^2));
x(1)=0; time(1)=0;

for i = 1:stepx
    x(i+1) = (i)*dx;
end

for i = 1:stepx+1
    T(i,1) = 100*sin(pi*x(i));
end

for j=1:stept
    time(j+1)=j*dt;
    for i=2:stepx
        if i<(1/2*stepx+1)
        T(i,j+1)=T(i,j)+(lam1*(T(i+1,j)-2*T(i,j)+T(i-1,j)));
        else
        T(i,j+1)=T(i,j)+(lam2*(T(i+1,j)-2*T(i,j)+T(i-1,j)));
        end
    end
end
subplot(1,2,1); pcolor(time,x,T); shading interp;
subplot(1,2,2); meshc(time,x,T); shading interp; colorbar;
