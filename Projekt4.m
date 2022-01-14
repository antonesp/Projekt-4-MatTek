
% Et dokument som indeholder og tester funktionerne der skal bruges til projektet
clear all
close all
%% Først generes data
im1 = generate_simdata(500);

%% Støj tilføjes



%% Fouriertransformation

f=fft2(im1);
imagesc(log(abs(f)))

fshift = fftshift(f);

% Vi laver ffthshift uden støj
figure(2);
imagesc(log(abs(fshift)));
% Vi laver fftshift med støj
fNoise = addnoise(fshift,0.1);

figure(3);
imagesc(log(abs(fNoise)));

%% Rekonstruktion

% Vi skal nu rekonstruere billedet ved hjælp inver fftshift

% Vi laver igen 2 billeder et med støj og et uden.
infshift = ifft2(fshift);
figure(4)
imagesc(abs(infshift))

infNoise = ifft2(fNoise);
figure(5)
imagesc(abs(infNoise))

%% Rekonstruktion med image sampling
samFshift = imageSampling(fshift,0.5);

samfNoise = imageSampling(fNoise,0.5);

figure(6)
imagesc(log(abs(samFshift)));

figure(7)
imagesc(log(abs(samfNoise)));

% Vi kører rekonstruktionen nu

Saminfshift = ifft2(samFshift);
figure(8)
imagesc(abs(Saminfshift))


SaminfNoise = ifft2(samfNoise);
figure(9)
imagesc(abs(SaminfNoise))