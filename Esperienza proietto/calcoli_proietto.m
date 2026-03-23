% LE MISURE DI LUNGHEZZA SONO TUTTE IN CENTIMETRI

% Pulisco la console e svuoto le variabili
%clear, clc

% --- ANALISI DATI --- %
run('startup.m');

% Per sicurezza
g = g * 100;

% Importo i dati
T = readmatrix('dati_proietto.csv');

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
sigma_g = sqrt(err_ris_g.^2 + err_ris_g.^2 + err_ris_g.^2);

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
sigma_U_mg_med = sqrt(dot(sigma_U_mg, sigma_U_mg)) ./ 3; % da rssq, che è un addon, a sqrt(dot())

% Gittata considerando U_mg -- FUNZIONE -> PRENDE UN ARRAY O UNO SCALARE IN
% INPUT
g_teo = @(theta) 2 .* sin(2 .* theta) .* (U_mg_med - dx .* sin(theta));

% Incertezza gittata teorica -- FUNZIONE -> PRENDE UN ARRAY O UNO SCALARE
% IN INPUT
sigma_g_teo = @(theta) 2 .* sin(2 .* theta) .* sigma_U_mg_med;


% --- SEZIONE RIGUARDO ALLA CORREZIONE DELL'ANGOLO --- %

% array delle 3 derivate di U_mg [25, 45, 65] rispetto a delta (fattore di
% offset) serviranno per minimizzare l'errore quadrato compiuto in funzione
% di delta
function y = U_prime(delta, g_med, angoli, dx)
    y = dx .* cos(delta + angoli) - g_med ./ 2 .* (2 .* cos(2 .* (delta + angoli))) ./ ((sin(2.*(delta + angoli)) .^ 2));
end

% media delle derivate = derivata della media, serve per l'errore
function y = U_mean_prime(delta, g_med, angoli, dx)
    U_prime_ = U_prime(delta, g_med, angoli, dx);
    y = sum(U_prime_) ./ length(U_prime_); 
end

% il delta ottimale si ottiene ponendo uguale a 0 la derivata della
% varianza fra U_mg(delta) e U_mg_mean(delta). Ciò, passando per i calcoli,
% significa porre uguale a 0 il prodotto scalare fra U_mg - U_mg_med e le
% derivate:
function y = to_minimize(delta, g_med, angoli, dx)
    U_curr = g_med ./ (2 .* sin(2 .* (angoli + delta))) + dx .* sin(angoli + delta);
    U_med_curr = mean(U_curr);
    y = dot(U_curr - U_med_curr, U_prime(delta, g_med, angoli, dx) - U_mean_prime(delta, g_med, angoli, dx));
end

fun = @(x) to_minimize(x, g_med, angoli, dx);
delta_optimal = fzero(fun, 0);

% ___ALTERNATIVA, USANDO DIRETTAMENTE LA FUNZIONE MATLAB___ %
% % array con i valori di U_mg per i tre angoli, in funzione dell'offset
% U_delta = @(delta) g_med ./ (2 .* sin(2 .* (angoli + delta))) + dx .* sin(angoli + delta);
% 
% % media delle U in funzione dell'offset
% U_med_delta = @(delta) mean(U_delta(delta));
% 
% error = @(delta) dot(U_delta(delta) - U_med_delta(delta), U_delta(delta) - U_med_delta(delta));
% 
% delta_optimal = fminunc(error, 0)