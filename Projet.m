% Louis ALDASORO & Tom AUCLER

%% Préliminaire 1
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
DSP_x = abs(X).^2;

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
plot(f,DSP_x);
title("Densité spectrale de puissance");
xlabel('Fréquence normalisée');
ylabel('Amplitude');

%% Préliminaire 2
mu = 0;
RSB = -5; %rapport signal sur bruit
Ps = sum(abs(X))/N; %puissance signal x(t)
sig = sqrt(Ps * 10^(-RSB/10)); %puissance bruit sqrt

noise = mu + sig*randn(N,1);
y = x + noise; %signal bruité

Y = fftshift(fft(y));
DSP_y = abs(Y).^2;

figure
subplot 311
plot(y); 
title("Représentation temporelle du signal bruité");
ylabel('Amplitude');

subplot 312
plot(f,abs(X));
title("Spectre de puissance");
xlabel('Fréquence normalisée');
ylabel('Amplitude');

subplot 313
plot(f,DSP_y);
title("Densité spectrale de puissance");
xlabel('Fréquence normalisée');
ylabel('Amplitude');


