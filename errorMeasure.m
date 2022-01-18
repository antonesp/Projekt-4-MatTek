function eM= errorMeasure(X,Y)
%Udregner hvor stor forskel der er mellem to matricer.
%Input: To 2D matricer, hvor X er ground truth.
%Output: Fejlmål
%Forfatter: Clara Hollenbeck. 14-1-2022

%Tjekker om X og Y er 2D matricer.
assert(ismatrix(X) && ismatrix(Y),'Input skal være en 2D matrix') 

Xn=X-Y;                          %Udregner forskellen mellem X og Y
eM=norm(Xn,'fro')/norm(X,'fro'); %Udregner fejlmålet
end