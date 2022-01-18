%% Rekonstruktion af MR-billeder
function volume = recon_volume(M,vek)
%Funktionen laver en rekonstruktion af en stak af 2D billeder. vek er en
%vektor der angiver hvilke slices, som ønskes rekonstrueret. Hvis vek er
%tom rekonstruerers alle slices.
%Input: 3D array og en index-vektor.
%Output: 3D array med rekonstruerede billeder.
%Forfatter: Clara Hollenbeck 17-1-2022.
%Redigeret af Clara Hollenbeck 18-1-2022

assert(length(size(M))==3,'Input skal være et 3D array')
assert(isvector(vek),'Input 2 skal være en vektor')

[x,y,z]=size(M);        %Udregner størrelsen af arrayet


if isempty(vek)        %Tjekker om vek er tom
    V = zeros(x,y,z);  %Matrix med samme størrelse som M, fyldt med 0'er
   for i=1:z
        f=(M(:,:,i));  %Tager et udsnit af M
    
    Lim = imageSampling(f,0.6);  %Sampler udsnittet så der kun er 60% tilbage
    invLim = ifft2(Lim);         %Rekonstruerer billedet
    V(:,:,i)=invLim;             %Indsætter det i V
   end
else
    l=length(vek);               %Længden af vek
    
    %Laver en matrix med samme nxm som M,og samme dybde som længden af vek, fyldt
    %med 0'er.
    V = zeros(x,y,l);            
for i=1:l
    %Tjekker at tallene i vek ikke er større end dybden af M.
    assert(vek(i)<=z,'Tallene i vektoren må ikke være større end dybden af M')
    f=(M(:,:,vek(i)));
    
    Lim = imageSampling(f,0.6);
    invLim = ifft2(Lim);
    V(:,:,i)=invLim;
end
end
volume = V;
end

    