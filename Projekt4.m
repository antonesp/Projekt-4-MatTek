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
imagesc(log(abs(f)));

fshift=fftshift(f);
imagesc(log(abs(fshift)));

%Indsæt hvid støj på billedet.
fNoisy=addNoise(fshift,0.01);
figure;
imagesc(log(abs(fNoisy)));

%% Rekonstruktion af billeder
inv = ifft2(fftshift(fshift));       %Billed uden støj
invNoisy = ifft2(fftshift(fNoisy));  %Billed med støj
figure;
imshow(inv);
figure;
imshow(invNoisy);

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
im1 = generate_simdata(k);
x=[1:100];
y=zeros(1,100);

f=fft2(im1);
fshift=fftshift(f);
inv = ifft2(fftshift(fshift));
    
for i=1:100
    fNoisy=addNoise(fshift,i);
    invNoisy = ifft2(ifftshift(fNoisy));
    
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
for i=1:99
    f=fft2(im1);
    fshift=fftshift(f);
    inv = ifft2(fshift);
    
    Lim = imageSampling(fshift,i/100);
    invLim = ifft2(Lim);
    
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
