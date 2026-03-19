% LE MISURE DI LUNGHEZZA SONO TUTTE IN CENTIMETRI

% Pulisco la console e svuoto le variabili
clear
clc

% --- ANALISI DATI --- %

% Eseguo il file startup.m, contiene variabili generalmente utili
run('/Users/giacomovanzelli/MATLAB/startup.m');

% Per sicurezza
g = g * 100;

% Importo i dati
T = readmatrix('/Users/giacomovanzelli/MATLAB/Esperienza proietto/dati.csv');

% Dati non presenti nel file
dx = 4.6;
angoli = deg2rad([25, 45, 65]);

% Risoluzioni degli strumenti utilizzati
ris_g = .1;
ris_a = deg2rad(1);

% Errori riferiti alle risoluzioni
err_ris_g = ris_g / sqrt(12);
err_ris_a = ris_a / sqrt(12);
err_ris_dx = dx / sqrt(12);

% Vettori gittate
g_25_vet = sum(T(T(:,1) == 25, 2:end),2);
g_45_vet = sum(T(T(:,1) == 45, 2:end),2);
g_65_vet = sum(T(T(:,1) == 65, 2:end),2);
g_vet = [g_25_vet, g_45_vet, g_65_vet];

% Gittate medie
g_med = mean(g_vet, 1);

% Incertezza strumentale sulla gittata
sigma_g = rssq([err_ris_g, err_ris_g, err_ris_g]);

% Deviazioni standard gittate
dev_std_g = std(g_vet, 1, 1);

% Incertezza su g_med
err_g_med = dev_std_g ./ sqrt(size(g_vet, 1));

% Incertezza totale
err_tot = sqrt(sigma_g^2 + err_g_med.^2);

% --- CALCOLI --- %

% Gittata caratteristica del sistema cannone-palla
U_mg = g_med ./ (2 .* sin(2 .* angoli)) + dx .* sin(angoli);

% Derivate parziali rispetto alle gittate
dU_mg_dg_med = 1 ./ (2 .* sin(2 .* angoli));

% Derivate parziali rispetto agli angoli
dU_mg_da = dx .* cos(angoli) - g_med .* cos(2 .* angoli) ./ sin(2 .* angoli).^2;

% derivate parziali rispetto a dx
dU_mg_ddx = cos(angoli);

% Incertezza U_mg
sigma_U_mg = sqrt((dU_mg_dg_med .* err_tot).^2 + (dU_mg_da .* err_ris_a).^2 + (dU_mg_ddx .* err_ris_dx).^2);

% U_mg media
U_mg_med = mean(U_mg);

% Incertezza su U_mg medio
sigma_U_mg_med = rssq(sigma_U_mg) / 3;

% Gittata considerando U_mg
g_teo = 2 .* sin(2 .* angoli) .* (U_mg_med - dx .* sin(angoli));

% Incertezza gittata teorica
sigma_g_teo = 2 .* sin(2 .* angoli) .* sigma_U_mg_med;