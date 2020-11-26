clear;
close all;
clc;

%Paramètres
N = 5000;
p = 4;
s = 0.5;
f = -0.5:1/N:0.5-1/N;

prephi = randn(p,1);
phi = prephi./sum(abs(prephi));

x = zeros(N,1);

bbg = s*randn(N,1);
for i = 1:N
    for k = 1:p
        if i-k > 0
            x(i) = x(i) + phi(k)*x(i-k);
        end
    end
    x(i) = x(i) + bbg(i);
end

X = fftshift(fft(x));
DSP = abs(X).^2;

figure
subplot 311
plot(x); 
title("Signal autorégressif d'ordre 4");
ylabel('Amplitude');

subplot 312
plot(f,abs(X));
title("Spectre de puissance");
xlabel('Fréquence normalisée');
ylabel('Amplitude');

subplot 313
plot(f,DSP);
title("Densité spectrale de puissance");
xlabel('Fréquence normalisée');
ylabel('Amplitude');