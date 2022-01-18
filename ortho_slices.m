% Af Clara Hollenbeck og Anton Espholm.
%Dato 18-01-2022

%input er en 3d matrix og 3 scalarer. Scalarende andgiver den ønskede
%slice.
%output er 3 matrixer som hver er slices i forskellige dimensioner af input
%matrixen.

function [o1,o2,o3] = ortho_slices(M,s1,s2,s3)

[n,m,z] = size(M);
sM = size(M);
% Input undersøges.
assert(length(sM) == 3,'Fejl ugyldig matrix, matrixen skal være 3 dimensionel')
assert(ismember(s1,1:n)||ismember(s2,1:m)||ismember(s3,1:z),'Fejl dinne ønskede slices er ikke en del af matrixen')

% Udsnittende af M defineres ved at sætte en dimension til en scalar og
% squeeze til at fjerne alle dimensioner med en længde på 1.
o1 = squeeze(M(s1,:,:));
o2 = squeeze(M(:,s2,:));
o3 = squeeze(M(:,:,s3));
