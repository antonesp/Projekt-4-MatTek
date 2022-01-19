%% Projekt 4
close all
clear all
%% Generer billeder og gemmer dem
k=256;
im1 = generate_simdata(k);
im2 = generate_simdata(k,'C:\Users\clar1\OneDrive\Dokumenter\DTU\Matematik og teknologi\Projekt 4');
im3 = genPhantom(k);

%% Fourirtransformation
f=fft2(im1);

fshift=fftshift(f); 

%Indsæt hvid støj på billedet.
fNoisy=addNoise(fshift,0.5);

%Viser billederne
figure;
subplot(2,2,1);
imagesc(log(abs(f)));
title('Fouriertransformeret billede');

subplot(2,2,2);
imagesc(log(abs(fshift)));
title('Efter billedet er blevet shiftet');

subplot(2,2,3);
imagesc(log(abs(fNoisy)));
title('Billede med støj');

%% Rekonstruktion af billeder
inv = ifft2(fftshift(fshift));       %Billed uden støj
invNoisy = ifft2(fftshift(fNoisy));  %Billed med støj

figure;
subplot(1,2,1);
imshow(inv);
title('Uden støj');

subplot(1,2,2);
imshow(invNoisy);
title('Med støj');

%% Sampling i DFT rummet
Lim = imageSampling(fshift,0.5);        %Sampling uden støj
NoisyLim = imageSampling(fNoisy,0.5);   %Sampling med støj

invLim = ifft2(fftshift(Lim));
invNoisyLim = ifft2(fftshift(NoisyLim));

%Plotter billederne
figure;
subplot(2,2,1);
imagesc(log(abs(Lim)));
title('Sampling uden støj');

subplot(2,2,2);
imagesc(log(abs(NoisyLim)));
title('Sampling med støj');

subplot(2,2,3);
imshow(abs(invLim));
title('Rekonstruktion uden støj');

subplot(2,2,4);
imshow(abs(invNoisyLim));
title('Rekonstruktion med støj');

%% Udregn forskellen mellem to billeder
error=errorMeasure(inv,invLim);

%% Nu skal vi prøve at plotte fejlen ift. mængden af støj.
im2 = generate_simdata(k);
x=[1:100];
y=zeros(1,100);

f=fft2(im2);
fshift=fftshift(f);
inv = ifft2(fftshift(fshift));
imR = rescale(abs(inv));

for i=1:100
    fNoisy=addNoise(fshift,i);
    invNoisy = ifft2(fftshift(fNoisy));
    
    imR2 = rescale(abs(invNoisy));
    
    e=errorMeasure(imR,imR2);
    y(i)=e;
end
    


%% Plot fejlen ved sampling
im1 = generate_simdata(k);
x=[1:100];
y2=zeros(1,100);
f=fft2(im1);
fshift=fftshift(f);
inv = ifft2(fftshift(fshift));

for i=1:99
    Lim = imageSampling(fshift,i/100);
    invLim = ifft2(fftshift(Lim));
    
    e=errorMeasure(inv,invLim);
    y2(i)=e;
end

figure;
subplot(2,2,1);
plot(x,y);
grid on
title('Fejl ved støj');
xlabel('Procent støj');
ylabel('Error');

subplot(2,2,2);
plot(x,y2);
title('Fejl ved sampling');
xlabel('Procent støj/størrelse af sampling');
ylabel('Error ved støj');

%% Plot fejlen ved sampling
im1 = generate_simdata(k);
x=[1:99];
f=fft2(im1);
fshift=fftshift(f);
inv = ifft2(fftshift(fshift));
fshiftNoise1 = addNoise(fshift,20);
fshiftNoise2 = addNoise(fshift,40);
fshiftNoise3 = addNoise(fshift,60);
fshiftNoise4 = addNoise(fshift,80);
fshiftNoise5 = addNoise(fshift,100);

y1 = zeros(1,99);
y2 = y1;
y3 = y1;
y4 = y1;
y5 = y1;

for i=1:99
    Lim = imageSampling(fshiftNoise1,i/100);
    invLim = ifft2(fftshift(Lim));
    
    e=errorMeasure(inv,invLim);
    y1(i)=e;
end

for i=1:99
    Lim = imageSampling(fshiftNoise2,i/100);
    invLim = ifft2(fftshift(Lim));
    
    e=errorMeasure(inv,invLim);
    y2(i)=e;
end

for i=1:99
    Lim = imageSampling(fshiftNoise3,i/100);
    invLim = ifft2(fftshift(Lim));
    
    e=errorMeasure(inv,invLim);
    y3(i)=e;
end

for i=1:99
    Lim = imageSampling(fshiftNoise4,i/100);
    invLim = ifft2(fftshift(Lim));
    
    e=errorMeasure(inv,invLim);
    y4(i)=e;
end

for i=1:99
    Lim = imageSampling(fshiftNoise5,i/100);
    invLim = ifft2(fftshift(Lim));
    
    e=errorMeasure(inv,invLim);
    y5(i)=e;
end

figure;
plot(x,y1,'DisplayName','Støj 20%');
grid on
xlabel('Procent Samplesize');
ylabel('Error');
hold on

plot(x,y2,'DisplayName','Støj 40%');
plot(x,y3,'DisplayName','Støj 60%');
plot(x,y4,'DisplayName','Støj 80%');
plot(x,y5,'DisplayName','Støj 100%');

lgd = legend;

hold off

%%
close all
load mouseheart.mat
load A.mat
load B.mat
v=recon_volume(B);
volumeViewer(abs(v));
[o,o1,o2] = ortho_slices(v,88,0,0);
figure;
imagesc(abs(o));
% 100,150
%Billled A er et MR-scan af en hjerne

%Billed B er et kranie.
