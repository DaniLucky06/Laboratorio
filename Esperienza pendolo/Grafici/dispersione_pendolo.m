% Pulisco la console e svuoto le variabili
clear
clc

% Eseguo i calcoli necessari
run('calcoli_pendolo.m');

% Linearizzo la matrice t_vet in un vettore riga per il grafico
t_dati = t_vet(:)';
N_totale = length(t_dati);

% Vettore per l'asse X (numero progressivo della misurazione)
n_misure = 1:N_totale;

% Vettore per le barre d'errore (uso err_ris_t calcolato in calcoli.m per tutti)
err_t = err_ris_t * ones(size(t_dati));

% Impostazioni estetiche
c_def = [0, 0.4470, 0.7410]; % Colore di default di MATLAB
sz = 20; % Dimensione dei pallini
cs = 3;  % Dimensione dei "cappelli" delle barre d'errore

% --- DISPERSIONE DEL PERIODO --- %
figure;
hold on;

errorbar(n_misure, t_dati, err_t, 'LineStyle', 'none', 'Color', c_def, 'CapSize', cs, 'HandleVisibility', 'off');

scatter(n_misure, t_dati, sz, c_def, 'filled');

yline(t_med, '--', 'Color', c_def, 'LineWidth', 1.5);

min_x = 1; max_x = N_totale;
range_x = max_x - min_x;
margine_x = range_x * 0.10;
if margine_x == 0; margine_x = 1; end 
xlim([min_x - margine_x, max_x + margine_x]);

min_y_assoluto = min(t_dati - err_t);
max_y_assoluto = max(t_dati + err_t);

range_y = max_y_assoluto - min_y_assoluto;
margine_y = range_y * 0.10;

if margine_y == 0; margine_y = err_ris_t * 2; end 

ylim([min_y_assoluto - margine_y, max_y_assoluto + margine_y]);

xlabel('Numero della misurazione');
ylabel('Periodo (s)');
title('Dispersione delle misurazioni del periodo');
legend('Dati sperimentali', 'Valore medio', 'Location', 'northeast');

grid on;
hold off;