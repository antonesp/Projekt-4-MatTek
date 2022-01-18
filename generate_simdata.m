function sim = generate_simdata(k,texFiles)
% Af Clara Hollenbeck og Anton Espholm
% Dato 18-01-2022

% generate_simdata har til opgave at genere billeder med 3 figurer, hvis
% det ønskes kan texture inkluderes på billederne.

% Input: k andgiver størrelsen af billedet og figurende på det. texFiles er
% et frivilligt input og er lokationen på tex filerne. Hvis texFiles er tom
% vil der ikke bruges nogle texture.

%Output: Et billede.

%Input undersøges.
assert(isstring(texFiles),'texFiles skal være lokationen af dine texture filet, hvis du ikke ønsker at bruge dem så lad texFiles være tom')
assert(isstring(k),'Fejl x må ikke være en string')
k = floor(abs(k));
assert(isinteger(int8(k))||k<=0,'Fejl x skal være et heltal over 0')


%Først generes en cirkel.
[n,m]=meshgrid(1:k,1:k);  %generer en matrix der er kxk og angiv n og m.
centerX=unifrnd(0,k,1,1); %Lav centrum i en tilfældig x- og y-værdi
centerY = unifrnd(0,k,1,1);
radius = k/8;             %Radius afhænher af k

%Laver et 2D logical array, hvor de pixels der opfylder kravet får værdien
%1 og de der ikke gør får værdien 0.
circle=(m-centerY).^2+(n-centerX).^2<=radius.^2;

%Herefter laves en Trekant. Først laves 3 x-værdier
x1=unifrnd(0,k,1,1);
x2=x1+k/4;
x=[x1,x1,x2];

%Herefter laves 3 y-værdier ud fra x-værdierne så trekanten bliver
%retvinklet.
y1=x1;
y2=x1-k/4;
y=[y1,y2,y1];

%Trekanten laves
tri=poly2mask(x,y,k,k);

%Tilsidst laves et kvadrat på samme måde som trekanten.
x1=unifrnd(0,k,1,1);
x2=x1+k/6;
x=[x1,x1,x2,x2];
y=[x1,x2,x2,x1];

firkant=poly2mask(x,y,k,k);

%Cirkel,trekant og firkant lægges sammen, så de er i samme matrix.
if ~exist('texFiles')
    sim=circle+tri+firkant;
else
    im1 = append(texFiles,'\tex1.png');
    im2 = append(texFiles,'\tex2.png');
    im3 = append(texFiles,'\tex3.png');
    
    tex1 = imread(im1);
    tex1 = imresize(tex1,[k,k]);
    tex1 = im2double(tex1);

    tex2 = imread(im2);
    tex2 = imresize(tex2,[k,k]);
    tex2 = im2double(tex2);

    tex3 = imread(im3);
    tex3 = imresize(tex3,[k,k]);
    tex3 = im2double(tex3);

    sim=tex1.*circle+tex2.*tri+tex3.*firkant; 
end


