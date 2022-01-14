%% Funktion til at skabe støj i et billede

function picNoise = addnoise(pic,noise)

 im = im2double(pic);
 [n,m] = size(im);
 
% De første if staments chekker for gyldige inputs
if ~isnumeric(noise)
    error('Fejl støj skal være et tal')
    
elseif noise<0
    error('Fejl støj kan ikke være under 0')
    
elseif noise>1
    noise = noise/100;
    
    r = randn(n,m);
    r = r/norm(r,'fro');

    e = noise*r*norm(real(im),'fro')+noise*r*norm(imag(im),'fro')*1i;
    picNoise = im + e;

elseif (noise<=1)&&(noise>=0)
    noise = noise;
    r = randn(n,m);

    r = r/norm(r,'fro');

    e = noise*r*norm(real(im),'fro')+noise*r*norm(imag(im),'fro')*1i;
    picNoise = im + e;

else
    error('Ukendt fejl, undersøg om noise er andgivet korrekt')
end

