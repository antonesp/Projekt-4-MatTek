%% Projekt 4
close all
clear all
%% Generer billeder og gemmer dem
k=256;
im1 = generate_simdata(k);
im2 = generate_simdata(k,'C:\Users\clar1\OneDrive\Dokumenter\DTU\Matematik og teknologi\Projekt 4');
im3 = genPhantom(k);

%% Fourirtransformation



%% Rekonstruktion af billeder


%% Sampling i DFT rummet
Lim = imageSampling(fshift,0.5);
NoisyLim = imageSampling(fNoisy,0.5);

figure;
imagesc(log(abs(Lim)));
figure;
imagesc(log(abs(NoisyLim)));


invLim = ifft2(fftshift(Lim));
invNoisyLim = ifft2(fftshift(NoisyLim));

figure;
imshow(invLim);
figure;
imshow(invNoisyLim);

%% Udregn forskellen mellem to billeder
error=errorMeasure(inv,invLim);

%% Nu skal vi prøve at plotte fejlen ift. mængden af støj.
close all
im2 = generate_simdata(k);
x=[1:100];
y=zeros(1,100);

f=fft2(im2);
fshift=fftshift(f);
inv = ifft2(fftshift(fshift));
    
for i=1:100
    fNoisy=addNoise(fshift,i);
    invNoisy = ifft2(fftshift(fNoisy));
    
    figure;
    imagesc(abs(invNoisy));
    
    e=errorMeasure(inv,invNoisy);
    y(i)=e;
end
figure;
plot(x,y);
grid on
xlabel('Procent støj');
ylabel('Error');

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
plot(x,y2);

figure;
plot3(x,y,y2)
grid on
xlabel('Procent støj/størrelse af sampling');
ylabel('Error ved støj');
zlabel('Error ved sampling')
%%
close all
load mouseheart.mat
load A.mat
load B.mat
v=recon_volume(B,[]);
[o,o1,o2] = ortho_slices(v,0,0,60);
figure;
imagesc(abs(o2));
% 100,150
%Billled A er et MR-scan af en hjerne

%Billed B er et kranie.
