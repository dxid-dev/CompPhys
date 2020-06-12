clc; clear all;
R=2; g=9.8;
r(1)=0.75; t(1)=0; omega(1)=0; theta(1)=0;
del=0.01; n=10/del;

for i=1:n+1
    theta(i+1)=(pi/12)*cos(pi*t(i));
    r(i+1)=r(i)+del*omega(i);
    omega(i+1)=((pi^2/12)^2)*r(i)*(sin(pi*t(i)))^2-g*sin((pi/12)*cos(pi*t(i)));
    t(i+1)=t(i)+del;
end

sumbux = R.*sin(theta); sumbuy = R.*cos(theta);
gelangx = r.*sin(theta); gelangy = r.*cos(theta);
pusatx = 0; pusaty = 0;

for j=1:n+1
    rodx = [pusatx sumbux(j)];
    rody = [pusaty sumbuy(j)];
    plot(gelangx(j),gelangy(j),'ko',rodx,rody,'r-'); text(0.1,4,"Waktu: "+num2str(t(j))+" s"); text(0.1,3.5,"Sudut: "+num2str((theta(j)/pi)*180)+" derajat");
    axis([-1.5 1.5 -1.5 5]);
    pause(del);
end


