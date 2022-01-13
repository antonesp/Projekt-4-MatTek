function sim = generate_simdata(k)
close all
%Først generes en cirkel.
[n,m]=meshgrid(1:k,1:k);  %generer en matrix der er kxk og angiv n og m.
centerX=unifrnd(0,k,1,1); %Lav centrum i en tilfældig x- og y-værdi
centerY = unifrnd(0,k,1,1);
radius = k/8;             %Radius afhænher af k

%Laver et 2D logical array, hvor de pixels der opfylder kravet får værdien
%1 og de der ikke gør får værdien 0.
circle=(m-centerY).^2+(n-centerX).^2<=radius.^2;
circle=circle*0.5; %Gang med 0.5 for at cirklen bliver grå

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
tri=tri*0.5; %Gør trekanten grå

%Tilsidst laves et kvadrat på samme måde som trekanten.
x1=unifrnd(0,k,1,1);
x2=x1+k/6;
x=[x1,x1,x2,x2];
y=[x1,x2,x2,x1];

firkant=poly2mask(x,y,k,k);
firkant=firkant*0.5;

%Cirkel,trekant og firkant lægges sammen, så de er i samme matrix.
sim=circle+tri+firkant; 

%Viser billedet.
figure;
sim=imshow(sim);
