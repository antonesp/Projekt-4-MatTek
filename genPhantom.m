% Funktionen har til at kalde 'phantom' kommandoen og gennere et billede
% med en given størrelse.

%Dato 18-01-2022
%Af Anton Espholm og Clara Hollenbeck

%Input størrelsen af billedet
%Output et billede som kan gemmes.

function phan = genPhantom(x)


% Input chekkes.
assert(isempty(x),'Fejl du har ikke andgivet en ønsket billede størrelse')
% x afroundes og eventuelle complexe eller negative tal fjernes.
x = floor(abs(x));
assert(isstring(x),'Fejl x må ikke være en string')
assert(isinteger(int8(x))||x<=0,'Fejl x skal være et heltal over 0')

P = phantom('Modified Shepp-Logan',x);

phan = imshow(P);
imsave