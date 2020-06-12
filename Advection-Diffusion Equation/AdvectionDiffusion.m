clc; clear all; close all;

% Pemodelan Numerik 2D Adveksi-Dispersi
% untuk Memprediksi Konsentrasi Polutan pada Sungai

% Inisiasi Konstanta pada Persamaan
% D (laju difusi), U (kecepatan aliran di sumbu x), V (kecepatan aliran di sumbu y) 
D=0.09; U=0.4; V=3.5;

% Inisiasi panjang, lebar dan langkah untuk perhitungan dimensi ruang dan waktu
h = 0.05; x = 0:h:5; y = 0:h:0.5;
dt = 1; t = 0:dt:100;

% Konsentrasi Awal
C = zeros(length(y),length(x),length(t));
% Nilai Awal (t=1)
C(7:8,4:5,1) = 20; C(3:4,28:29,1) = 7; C(6:7,50:51,1) = 10;
% Nilai Awal (t=2)
for j=2:length(x)-1
    for i=2:length(y)-1
    C(i,j,2)=C(i,j,1)+(D*(C(i+1,j,1)+C(i-1,j,1)+C(i,j+1,1)+C(i,j-1,1)-4*C(i,j,1))...
        -U*((C(i+1,j,1)-C(i-1,j,1))/2*h)-V*((C(i,j+1,1)-C(i,j-1,1))/2*h))*dt;
    end
end

% Perhitungan Konsentrasi
for n=2:length(t)-1
    for j=2:length(x)-1
        for i=2:length(y)-1
        C(i,j,n+1)=C(i,j,n)+(D*(C(i+1,j,n)+C(i-1,j,n)+C(i,j+1,n)+C(i,j-1,n)-4*C(i,j,n))...
            -U*((C(i+1,j,n)-C(i-1,j,n))/2*h)-V*((C(i,j+1,n)-C(i,j-1,n))/2*h))*dt;
        end
    end
end

% Plot Grafik
set(gcf,'position',get(0,'screensize'));
for n=1:length(t)
    clf;
    % Grafik 3D, besar konsentrasi ditampilkan sesuai ketinggian di sumbu Z
    subplot(2,1,1);
    surf(x,y,C(:,:,n)); caxis([0 20]);
    shading interp; 
    title(sprintf('Pemodelan Numerik 2D Adveksi-Dispersi\nuntuk Memprediksi Konsentrasi Polutan pada Sungai'));
    xlabel('x'); ylabel('y'); zlabel(sprintf('C(x,y,t = %1.2f)',t(n)));
    axis ([0 5 0 0.5 0 20]);
    
    % Grafik 2D, besar konsentrasi ditampilkan berdasarkan warna
    subplot(2,1,2);
    pcolor(x,y,C(:,:,n)); colorbar; caxis([0 20]); grid off;
    shading interp;
    title(sprintf('Difusi Adveksi ketika t = %1.2f s)',t(n)));
    xlabel('x'); ylabel('y');
    axis ([0 5 0 0.5]);
    drawnow;
    F(n) = getframe(gcf);
    hold on;
end

% Membuat hasil visualisasi dalam file video
visualisasi = VideoWriter('Visualisasi.avi');
visualisasi.FrameRate = 10;
open(visualisasi);
for i=1:length(t)
    frame = F(i) ;    
    writeVideo(visualisasi, frame);
end
close(visualisasi);