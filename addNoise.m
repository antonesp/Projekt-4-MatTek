function fNoisy = addNoise(Image,noiseLevel)
%Funktionen tager et billede der er blevet læst, og putter hvid støj på
%det. noiseLevel angiver hvor meget støj der skal være, og kan være mellem 0
%og 0.999 eller mellem 1 og 100.
%Input: Billedarray og et tal der angiver mængden af støj.
%Output: Billede med hvid støj.

%Clara Hollenbeck og Anton Espholm. 14.1 2022
%Rettet 17.1 2022

if ~isnumeric(noiseLevel)  %Tjekker at noiseLevel er et tal
    error('noiseLevel skal være et tal');

elseif (noiseLevel<0) || (100<noiseLevel)  
    %Sørger for at noiseLevel er inden for det rigtige interval
    error('noiseLevel skal være et positivt tal under 100');

elseif (1<=noiseLevel) &&(100>=noiseLevel) %Hvis man angiver i procent
    [n,m]=size(Image); %Definerer størrelsen af billedet
    noise=noiseLevel/100; %Ændrer noiseLevel til procent
    
r = randn(n,m);        %Laver en matrix med pseudotilfældige tal efter normalfordelingen
r = r/norm(r,'fro');   %Deler med Frobenius-gennemsnittet af matricen r.

r2 = randn(n,m);       %Gør det samme for den imaginære del  
r2 = r2/norm(r2,'fro');

%Laver en støjmatrix hvor støjniveauet kan forstørres eller formindskes.
e = noise*r*norm(real(Image),'fro')+noise*r2*norm(imag(Image)*1i,'fro');
fNoisy = Image + e;    %Laver billed med støj.

else %Hvis man angiver i tal mellem 0 og 1.
[n,m]=size(Image);
r = randn(n,m);
r = r/norm(r,'fro');

r2 = randn(n,m);         
r2 = r2/norm(r2,'fro');

e = noiseLevel*r*norm(real(Image),'fro')+noiseLevel*r2*norm(imag(Image)*1i,'fro');
fNoisy = Image + e;
end

