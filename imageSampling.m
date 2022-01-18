%% Functiom til image sampling

%Funktionen har til opgave at tage et udsnit af en andgivet matrix.
%Udsnittet tages i midten af matrixen, da funktionen er tiltænkt fourier
%transformerede billeder og at der i midten vil være flest detajler.

% Input er en matrix (signal), og et tal 0:1 (frac).
% Output er en matrix med midten lig signal, og resten lig 0. Størrelsen af
% midten bestemmes af frac.

% Af Anton Espholm og Clara Hollenbeck
% Dato 14-01-2022

function im = imageSampling(signal,frac)

% Det undersøges hvorvidt input er en gyldig matrix og et tal mellem 1 og
% 0.
if ~isnumeric(frac)||(frac>=1)||(frac<0)
    error('Fejl frac skal være et i intervallet [0;1[')
elseif ~ismatrix(signal)
    error('Fejl signal skal være en gyldig billede matrix')
else
% En 0 matrix med samme størelse for signal opstilles
[n,m] = size(signal);
zM = zeros(n,m);

% Størelsen af en matrix med størrelsen frac*(nXm) bestemmes
fn = floor(frac*n*0.5);
fm = floor(frac*m*0.5);

n2 = n/2;
m2 = m/2;

% Udsnittet defineres. Ved at plusse og minuse fn og fm sikres det at
% matrixen ligger i midten af signal.
sig = signal(n2-fn:n2+fn,m2-fm:m2+fm);

% Udsnittet indsættes i 0 matrixen.
zM(n2-fn:n2+fn,m2-fm:m2+fm) = sig;

im = zM;
end
