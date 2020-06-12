clc; clear all; close all;
m=1; %Massa Partikel (kg)
q=1; %Muatan Partikel (C)
E0= 4; %Medan Listrik (N/C)
B0= 5; %Medan Magnet (T)
v0= 10; %Kecepatan Awal Partikel (m/s)
thetaE0_x= 90; %Sudut Medan Listrik terhadap sumbu X
thetaE0_y= 0; %Sudut Medan Listrik terhadap sumbu Y
thetaE0_z= 90; %Sudut Medan Listrik terhadap sumbu Z
thetaB0_x= 90; %Sudut Medan Magnet terhadap sumbu X
thetaB0_y= 90; %Sudut Medan Magnet terhadap sumbu Y
thetaB0_z= 0; %Sudut Medan Magnet terhadap sumbu Z
thetav0_x= 45; %Sudut Arah Kecepatan Awal Partikel terhadap sumbu X
thetav0_y= -45; %Sudut Arah Kecepatan Awal Partikel terhadap sumbu Y
thetav0_z= 90; %Sudut Arah Kecepatan Awal Partikel terhadap sumbu Z

phiE0_x=pi/180*thetaE0_x;
phiE0_y=pi/180*thetaE0_y;
phiE0_z=pi/180*thetaE0_z;
phiB0_x=pi/180*thetaB0_x;
phiB0_y=pi/180*thetaB0_y;
phiB0_z=pi/180*thetaB0_z;
phiv0_x=pi/180*thetav0_x;
phiv0_y=pi/180*thetav0_y;
phiv0_z=pi/180*thetav0_z;

E0_x=E0*cos(phiE0_x);
E0_y=E0*cos(phiE0_y);
E0_z=E0*cos(phiE0_z);
B0_x=B0*cos(phiB0_x);
B0_y=B0*cos(phiB0_y);
B0_z=B0*cos(phiB0_z);
v0_x=v0*cos(phiv0_x);
v0_y=v0*cos(phiv0_y);
v0_z=v0*cos(phiv0_z);

Ex=E0_x;
Ey=E0_y;
Ez=E0_z;
Bx=B0_x;
By=B0_y;
Bz=B0_z;
vx=v0_x;
vy=v0_y;
vz=v0_z;

h=0.01;
N=1000;

x0=0;
y0=0;
z0=0;
x=x0;
y=y0;
z=z0;

%Menentukan nilai Kecepatan
%Metode Euler
%Setelah ditemukan, dicari nilai posisi

for i=1:N
t=i*h;
vx=(q*(vx+(Ex+vy*Bz-By*vz)*h))/m;
x=x+vx*h;
vy=(q*(vy+(Ey+vz*Bx-Bz*vx)*h))/m;
y=y+vy*h;
vz=(q*(vz+(Ez+vx*By-Bx*vy)*h))/m;
z=z+vz*h;
kec(i,:)=[t vx vy vz];
medan(i,:)=[x y z];
end

t=kec(:,1);
vx=kec(:,2);
vy=kec(:,3);
vz=kec(:,4);
x=medan(:,1);
y=medan(:,2);
z=medan(:,3);

kece=[vx vy vz];

%Menentukan nilai Percepatan
%Diferensiasi dengan Metode Beda Maju, Beda Mundur dan Beda Central

ax(1)=(vx(2)-vx(1))/(t(2)-t(1));
ay(1)=(vy(2)-vy(1))/(t(2)-t(1));
az(1)=(vz(2)-vz(1))/(t(2)-t(1));
for i=2:N-1
    ax(i)=(vx(i+1)-vx(i-1))/(t(i+1)-t(i-1));
    ay(i)=(vy(i+1)-vy(i-1))/(t(i+1)-t(i-1));
    az(i)=(vz(i+1)-vz(i-1))/(t(i+1)-t(i-1));
end
ax(N)=(vx(N)-vx(N-1))/(t(N)-t(N-1));
ay(N)=(vy(N)-vy(N-1))/(t(N)-t(N-1));
az(N)=(vz(N)-vz(N-1))/(t(N)-t(N-1));

perc=[ax' ay' az'];

for i=1:N
    clf
    plot3(x,y,z,'--')
    hold on
    plot3(x(i),y(i),z(i),'o');grid on; 
    axis tight
    axis square
    title('Dinamika Partikel Bermuatan pada Medan Elektromagnetik')
    xlabel('x');ylabel('y');zlabel('z');
    drawnow
    fprintf('t = %f v=%f a=%f\n',t(i), norm(kece(i,:)), norm(perc(i,:)))
end