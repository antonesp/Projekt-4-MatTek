
%% Functiom til image sampling
% Af Anton Espholm
% Dato 14-01-2022

% Målet med funktionen er at tage et udsnit af midten af billedet
function im = imageSampling(signal,frac)

% Input undersøges
if ~isnumeric(frac)||(frac>1)||(frac<0)
    error('Fejl frac skal være et tal mellem 0 og 1')
elseif ~ismatrix(signal)
    error('Fejl signal skal være en gyldig billede matrix')
else
% En 0 matrix med samme størelse for signal opstilles
[n,m] = size(signal);
zM = zeros(n,m);

% Størelsen af en matrix med størrelsen frac*(nXm) bestemmes
fn = frac*n;
fm = frac*m;

% Udsnittet defineres
sig = signal(n/2-fn/2:n/2+fn/2,m/2-fm/2:m/2+fm/2);

% Udsnittet indsættes i 0 matrixen.
zM(n/2-fn/2:n/2+fn/2,m/2-fm/2:m/2+fm/2) = sig;

im = zM;
end
