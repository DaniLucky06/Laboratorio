% Pulisco la console e svuoto le variabili
clear
clc

% Eseguo i calcoli necessari
run('/Users/giacomovanzelli/MATLAB/Esperienza proietto/calcoli.m');

% Vettori per l'asse X (numero progressivo del lancio per ciascun angolo)
n_25 = 1:length(g_25_vet);
n_45 = 1:length(g_45_vet);
n_65 = 1:length(g_65_vet);

% Vettori per le barre d'errore (uso lo STESSO sigma_g per tutti)
err_25 = sigma_g * ones(size(g_25_vet));
err_45 = sigma_g * ones(size(g_45_vet));
err_65 = sigma_g * ones(size(g_65_vet));

% Impostazioni estetiche
c_def = [0, 0.4470, 0.7410]; % Colore di default di MATLAB
sz = 20; % Dimensione dei pallini
cs = 3;  % Dimensione dei "cappelli" delle barre d'errore

% --- 25° --- %
figure;
hold on;

errorbar(n_25, g_25_vet, err_25, 'LineStyle', 'none', 'Color', c_def, 'CapSize', cs, 'HandleVisibility', 'off');
scatter(n_25, g_25_vet, sz, c_def, 'filled');
yline(g_med(1), '--', 'Color', c_def, 'LineWidth', 1.5);

% Calcolo dei margini (Asse X)
min_x = 1; max_x = length(g_25_vet);
range_x = max_x - min_x;
margine_x = range_x * 0.10;
if margine_x == 0; margine_x = 1; end 
xlim([min_x - margine_x, max_x + margine_x]);

% Calcolo dei margini (Asse Y)
min_y = min(g_25_vet); max_y = max(g_25_vet);
range_y = max_y - min_y;
margine_y = range_y * 0.10;
ylim([min_y - margine_y, max_y + margine_y]);

xlabel('Numero del lancio');
ylabel('Gittata (cm)');
title('Dispersione delle gittate - Angolo di 25°');
legend('Dati sperimentali', 'Valore medio', 'Location', 'northeast');

grid on;
hold off;

% --- 45° --- %
figure;
hold on;

errorbar(n_45, g_45_vet, err_45, 'LineStyle', 'none', 'Color', c_def, 'CapSize', cs, 'HandleVisibility', 'off');
scatter(n_45, g_45_vet, sz, c_def, 'filled');
yline(g_med(2), '--', 'Color', c_def, 'LineWidth', 1.5);

% Calcolo dei margini (Asse X)
min_x = 1; max_x = length(g_45_vet);
range_x = max_x - min_x;
margine_x = range_x * 0.10;
if margine_x == 0; margine_x = 1; end
xlim([min_x - margine_x, max_x + margine_x]);

% Calcolo dei margini (Asse Y)
min_y = min(g_45_vet); max_y = max(g_45_vet);
range_y = max_y - min_y;
margine_y = range_y * 0.10;
ylim([min_y - margine_y, max_y + margine_y]);

xlabel('Numero del lancio');
ylabel('Gittata (cm)');
title('Dispersione delle gittate - Angolo di 45°');
legend('Dati sperimentali', 'Valore medio', 'Location', 'northeast');

grid on;
hold off;

% --- 65° --- %
figure;
hold on;

errorbar(n_65, g_65_vet, err_65, 'LineStyle', 'none', 'Color', c_def, 'CapSize', cs, 'HandleVisibility', 'off');
scatter(n_65, g_65_vet, sz, c_def, 'filled');
yline(g_med(3), '--', 'Color', c_def, 'LineWidth', 1.5);

% Calcolo dei margini (Asse X)
min_x = 1; max_x = length(g_65_vet);
range_x = max_x - min_x;
margine_x = range_x * 0.10;
if margine_x == 0; margine_x = 1; end
xlim([min_x - margine_x, max_x + margine_x]);

% Calcolo dei margini (Asse Y)
min_y = min(g_65_vet); max_y = max(g_65_vet);
range_y = max_y - min_y;
margine_y = range_y * 0.10;
ylim([min_y - margine_y, max_y + margine_y]);

xlabel('Numero del lancio');
ylabel('Gittata (cm)');
title('Dispersione delle gittate - Angolo di 65°');
legend('Dati sperimentali', 'Valore medio', 'Location', 'northeast');

grid on;
hold off;

% --- Uniti --- %
figure;
hold on;

% Barre d'errore per il grafico unito
errorbar(n_25, g_25_vet, err_25, 'LineStyle', 'none', 'Color', c_def, 'CapSize', cs, 'HandleVisibility', 'off');
errorbar(n_45, g_45_vet, err_45, 'LineStyle', 'none', 'Color', 'r', 'CapSize', cs, 'HandleVisibility', 'off');
errorbar(n_65, g_65_vet, err_65, 'LineStyle', 'none', 'Color', 'g', 'CapSize', cs, 'HandleVisibility', 'off');

% Disegno i punti: Alpha impostato a 0.7 per un fade del 30%
s1 = scatter(n_25, g_25_vet, sz, c_def, 'filled');
s2 = scatter(n_45, g_45_vet, sz, 'r', 'filled', 'MarkerFaceAlpha', 0.7, 'MarkerEdgeAlpha', 0.7);
s3 = scatter(n_65, g_65_vet, sz, 'g', 'filled', 'MarkerFaceAlpha', 0.7, 'MarkerEdgeAlpha', 0.7);

% Disegno le linee medie abbinate
m1 = yline(g_med(1), '--', 'Color', c_def, 'LineWidth', 1.5);
m2 = yline(g_med(2), '--r', 'LineWidth', 1.5);
m3 = yline(g_med(3), '--g', 'LineWidth', 1.5);

% Calcolo dei margini (Asse X)
min_x = 1; max_x = max([length(g_25_vet), length(g_45_vet), length(g_65_vet)]);
range_x = max_x - min_x;
margine_x = range_x * 0.10;
if margine_x == 0; margine_x = 1; end
xlim([min_x - margine_x, max_x + margine_x]);

% Calcolo dei margini (Asse Y) globale
min_y = min([min(g_25_vet), min(g_45_vet), min(g_65_vet)]);
max_y = max([max(g_25_vet), max(g_45_vet), max(g_65_vet)]);
range_y = max_y - min_y;
margine_y = range_y * 0.10;
ylim([min_y - margine_y, max_y + margine_y]);

xlabel('Numero del lancio');
ylabel('Gittata (cm)');
title('Dispersione delle gittate in funzione dell''angolo di lancio');

% Salvo la legenda in una variabile e la posiziono a destra
lgd = legend([s1, s2, s3, m1, m2, m3], 'Dati 25°', 'Dati 45°', 'Dati 65°', ...
       'Media 25°', 'Media 45°', 'Media 65°', ...
       'Location', 'east', 'NumColumns', 2);

% Legenda abbassata a 0.55
lgd.Position(2) = 0.55; 

grid on;
hold off;