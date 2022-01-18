%% Orthoslices
function [O1,O2,O3] = ortho_slices(M,s1,s2,s3)
%Laver tre orthoslices. En for hver retning i matricen M.
%Input: 3D Matrix samt s1,s2 og s3, der angiver hvilket slice der skal
%tages ud.
%Forfatter: Clara Hollenbeck. 17-1-2022
l=length(size(M));
assert(l==3,'Dimensionen af M skal være 3');

[n,m,z]=size(M);
 
assert((s1>=0)&&(n>=s1),'s1 skal være mellem 1 og n')
assert((s2>=0)&&(m>=s2),'s2 skal være mellem 1 og m')
assert((s3>=0)&&(z>=s3),'s3 skal være mellem 1 og z')

if (s1>=1)&&(n>=s1)
O1 = M(s1,:,:);
O1=squeeze(O1);
else 
    O1=[];
end
if (s2>=1)&&(m>=s2)
 O2 = M(:,s2,:);
 O2=squeeze(O2);
else
    O2=[];
end
if (s3>=1)&&(z>=s3)
O3 = M(:,:,s3);
O3=squeeze(O3);
else
    O3=[];
end