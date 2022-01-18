%% Rekonstruktion af MR-billeder

function volume = recon_volume(M,vek)
[x,y,z]=size(M);

if isempty(vek)
    V = zeros(x,y,z);
   for i=1:z
        f=(M(:,:,i));
    
    Lim = imageSampling(f,0.6);
    invLim = ifft2(Lim);
    V(:,:,i)=invLim;
   end
else
    l=length(vek);
    V = zeros(x,y,l);
for i=1:l
    f=(M(:,:,vek(i)));
    
    Lim = imageSampling(f,0.6);
    invLim = ifft2(Lim);
    V(:,:,i)=invLim;
end
end
volume = V;
end

    