% Louis ALDASORO & Tom AUCLER

%% Préliminaire 1
clear;
close all;
clc;

%Paramètres
N = 5000;
p = 4;
f = -0.5:1/N:0.5-1/N;


pole = abs(randn(p,1));
pole = pole/sum(pole);

pole = [1;pole];
e = randn(N,1);
x = filter(1, pole, e);
  
H = freqz(1,pole,2*pi*f);

X = fftshift(fft(x)).^2/N;
DSP_x = abs(H).^2;

figure
subplot 211
plot(x); 
title("Signal autorégressif d'ordre 4");
ylabel('Amplitude');


subplot 212
plot(f,abs(X));
hold on;
plot(f,DSP_x,'LineWidth',2);
title("Spectre et densité spectrale de puissance");
xlabel('Fréquence normalisée');
ylabel('Amplitude');



%% Préliminaire 2
mu = 0;
RSB = [-5,0,10]; %rapport signal sur bruit
Ps = sum(abs(X))/N; %puissance signal x(t)
R = randn(N,1);

for i=1:3
    sig(i) = sqrt(Ps * 10^(-RSB(i)/10));
    noise(i) = mu + sig(i)*R;

y = x + noise; %signal bruité

Y = fftshift(fft(y)).^2/N;
DSP_y = abs(H).^2;

figure
subplot 211
plot(y); 
title("Représentation temporelle du signal bruité");
ylabel('Amplitude');

subplot 212
plot(f,abs(Y));
hold on;
plot(f,DSP_y,'LineWidth',2);
title("Spectre et densité spectrale de puissance");
xlabel('Fréquence normalisée');
ylabel('Amplitude');

end
