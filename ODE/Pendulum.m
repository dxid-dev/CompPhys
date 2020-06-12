clc; clear all;
g=9.8; L=1; w=2.5; Y=0.25;

del=0.01; h=10; n=h/del;
theta(1)=pi/3; omega(1)=0; t(1)=0;

for i=1:n+1
    theta(i+1)=theta(i)+del*omega(i);
    omega(i+1)=omega(i)+del*(-g/L*sin(theta(i))+(omega(i)^2/L)*Y*cos(theta(i))*sin(omega(i)*t(i)));
    t(i+1)=t(i)+del;
end

%Grafik
subplot(2,2,1); plot(t,theta,'b');
title('Grafik Sudut terhadap Waktu'); xlabel('Waktu (s)'); ylabel('Theta (Rad)');
subplot(2,2,3); plot(t,omega,'r');
title('Grafik Kecepatan Sudut terhadap Waktu'); ylabel('Omega (m/s)'); xlabel('Waktu (s)');

%Animasi
sumbux = L.*sin(theta); sumbuy = -L.*cos(theta);
pusatx(1) = 0; pusaty = 0;
for k=1:n+1
    pusatx(k) = Y*sin(w*t(k));
end
for j=1:n+1
    talix = [pusatx(j) sumbux(j)]; taliy = [pusaty sumbuy(j)];
    batasx=[min(pusatx) max(pusatx); 0 0];
    subplot(2,2,[2 4]); plot(sumbux(j),sumbuy(j),'ko',talix,taliy,'r-',batasx(1,:),batasx(2,:),'b-');
    title('Simulasi Pendulum');
    text(0.1,0.8,"Waktu: "+num2str(t(j))+" s"); text(0.1,0.7,"Sudut: "+num2str((theta(j)/pi)*180)+" derajat");
    xlabel("Sudut Tebesar: "+num2str(max(theta)*180/pi)+" derajat")
    axis tight; axis square; axis([-1.5 1.5 -1.5 1])
    drawnow;
end