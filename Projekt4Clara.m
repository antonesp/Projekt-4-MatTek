%% Projekt 4
close all
clear all
%% Generer billeder og gemmer dem
k=500;
im1 = generate_simdata(k);
figure(1)
im2 = generate_simdata(k,'C:\Users\anton\OneDrive\Skrivebord\MatTek 3 Ugers Matlab\Projekt 4');
figure(1)
imshow(im2)


%% Fourirtransformation

f=fft2(im1);
fshift = fftshift(f);

% Vi laver ffthshift uden støj
figure(2);
imagesc(log(abs(fshift)));
% Vi laver fftshift med støj
fNoise = addnoise(fshift,1000);

figure(3);
imagesc(log(abs(fNoise)));

%% Sampling i DFT rummet
Lim = imageSampling(fshift,0.5);
NoisyLim = imageSampling(fNoise,0.5);

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
im2 = generate_simdata(500);
x=[1:100];
y=zeros(1,100);

f=fft2(im2);
fshift=fftshift(f);
inv = ifft2(fftshift(fshift));
imR = rescale(abs(inv));

for i=1:100
    fNoisy=addnoise(fshift,i);
    invNoisy = ifft2(fftshift(fNoisy));
    
    imR2 = rescale(abs(invNoisy));
    
    e=error_measure(imR,imR2);
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
    
    e=error_measure(inv,invLim);
    y2(i)=e;
end


figure;
plot(x,y2);
grid on
xlabel('Procent Samplesize');
ylabel('Error');

figure;
plot3(x,y,y2,'b.')
grid on
xlabel('Procent støj/størrelse af sampling');
ylabel('Error ved støj');
zlabel('Error ved sampling')

%% Plot fejlen ved sampling
im1 = generate_simdata(k);
x=[1:99];
f=fft2(im1);
fshift=fftshift(f);
inv = ifft2(fftshift(fshift));
fshiftNoise1 = addnoise(fshift,20);
fshiftNoise2 = addnoise(fshift,40);
fshiftNoise3 = addnoise(fshift,60);
fshiftNoise4 = addnoise(fshift,80);
fshiftNoise5 = addnoise(fshift,100);

y1 = zeros(1,99);
y2 = y1;
y3 = y1;
y4 = y1;
y5 = y1;

for i=1:99
    Lim = imageSampling(fshiftNoise1,i/100);
    invLim = ifft2(fftshift(Lim));
    
    e=error_measure(inv,invLim);
    y1(i)=e;
end

for i=1:99
    Lim = imageSampling(fshiftNoise2,i/100);
    invLim = ifft2(fftshift(Lim));
    
    e=error_measure(inv,invLim);
    y2(i)=e;
end

for i=1:99
    Lim = imageSampling(fshiftNoise3,i/100);
    invLim = ifft2(fftshift(Lim));
    
    e=error_measure(inv,invLim);
    y3(i)=e;
end

for i=1:99
    Lim = imageSampling(fshiftNoise4,i/100);
    invLim = ifft2(fftshift(Lim));
    
    e=error_measure(inv,invLim);
    y4(i)=e;
end

for i=1:99
    Lim = imageSampling(fshiftNoise5,i/100);
    invLim = ifft2(fftshift(Lim));
    
    e=error_measure(inv,invLim);
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
v=recon_volume(A,[]);
[o,o1,o2] = ortho_slices(v,0,0,100);

subplot(1,3,1)
imagesc(abs(o));
subplot(1,3,2)
imagesc(abs(o2));
subplot(1,3,3)
imagesc(abs(o3));

% 100,150
%Billled A er et MR-scan af en hjerne

%Billed B er et kranie.