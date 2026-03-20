% Pulisco la console e svuoto le variabili
clear
clc

% Eseguo i calcoli necessari
run('calcoli_proietto.m');

% --- SENZA FIT --- %

% 25°
figure;

h = histogram(g_25_vet, 'BinMethod', 'fd', 'Normalization', 'probability');

min_bin = h.BinEdges(1);
max_bin = h.BinEdges(end);
range_x = max_bin - min_bin;
margine_x = range_x * 0.10;

xlim([min_bin - margine_x, max_bin + margine_x]);

max_y = max(h.Values);
margine_y = max_y * 0.10;
ylim([0, max_y + margine_y]);

xlabel('Gittata (cm)');
ylabel('Frequenza relativa');
title('Distribuzione delle gittate - Angolo di 25°');

grid on;

% 45°
figure;

h = histogram(g_45_vet, 'BinMethod', 'fd', 'Normalization', 'probability');

min_bin = h.BinEdges(1);
max_bin = h.BinEdges(end);
range_x = max_bin - min_bin;
margine_x = range_x * 0.10;

xlim([min_bin - margine_x, max_bin + margine_x]);

max_y = max(h.Values);
margine_y = max_y * 0.10;
ylim([0, max_y + margine_y]);

xlabel('Gittata (cm)');
ylabel('Frequenza relativa');
title('Distribuzione delle gittate - Angolo di 45°');

grid on;

% 65°
figure;

h = histogram(g_65_vet, 'BinMethod', 'fd', 'Normalization', 'probability');

min_bin = h.BinEdges(1);
max_bin = h.BinEdges(end);
range_x = max_bin - min_bin;
margine_x = range_x * 0.10;

xlim([min_bin - margine_x, max_bin + margine_x]);

max_y = max(h.Values);
margine_y = max_y * 0.10;
ylim([0, max_y + margine_y]);

xlabel('Gittata (cm)');
ylabel('Frequenza relativa');
title('Distribuzione delle gittate - Angolo di 65°');

grid on;

% Uniti
figure;
hold on;

h1 = histogram(g_25_vet, 'BinMethod', 'fd', 'Normalization', 'probability');
h2 = histogram(g_45_vet, 'BinMethod', 'fd', 'Normalization', 'probability', 'FaceColor', 'r', 'FaceAlpha', 0.5);
h3 = histogram(g_65_vet, 'BinMethod', 'fd', 'Normalization', 'probability', 'FaceColor', 'g', 'FaceAlpha', 0.5);

min_bin = min([h1.BinEdges(1), h2.BinEdges(1), h3.BinEdges(1)]);
max_bin = max([h1.BinEdges(end), h2.BinEdges(end), h3.BinEdges(end)]);

range_x = max_bin - min_bin;
margine_x = range_x * 0.10;
xlim([min_bin - margine_x, max_bin + margine_x]);

max_y = max([max(h1.Values), max(h2.Values), max(h3.Values)]);

margine_y = max_y * 0.10;
ylim([0, max_y + margine_y]);

xlabel('Gittata (cm)');
ylabel('Frequenza relativa');
title('Distribuzione delle gittate in funzione dell''angolo di lancio');

legend('25°', '45°', '65°', 'Location', 'northeast');

grid on;
hold off;

% --- Con fit --- %

% 25°
figure;
hold on;

h = histogram(g_25_vet, 'BinMethod', 'fd', 'Normalization', 'probability');

min_bin = h.BinEdges(1);
max_bin = h.BinEdges(end);
range_x = max_bin - min_bin;
margine_x = range_x * 0.10;

xlim([min_bin - margine_x, max_bin + margine_x]);

% Calcolo della curva Gaussiana (rimosso il fattore length)
x_fit = linspace(min_bin - margine_x, max_bin + margine_x, 1000);
y_fit = (1 / (dev_std_g(1) * sqrt(2*pi))) * exp(-0.5 * ((x_fit - g_med(1)) / dev_std_g(1)).^2) * h.BinWidth;
plot(x_fit, y_fit, 'Color', 'b', 'LineWidth', 2);

max_y = max([max(h.Values), max(y_fit)]);
margine_y = max_y * 0.10;
ylim([0, max_y + margine_y]);

xlabel('Gittata (cm)');
ylabel('Frequenza relativa');
title('Distribuzione delle gittate con Fit - Angolo di 25°');
legend('Dati', 'Fit Gaussiano');

grid on;
hold off;

% 45°
figure;
hold on;

h = histogram(g_45_vet, 'BinMethod', 'fd', 'Normalization', 'probability');

min_bin = h.BinEdges(1);
max_bin = h.BinEdges(end);
range_x = max_bin - min_bin;
margine_x = range_x * 0.10;

xlim([min_bin - margine_x, max_bin + margine_x]);

% Calcolo della curva Gaussiana (rimosso il fattore length)
x_fit = linspace(min_bin - margine_x, max_bin + margine_x, 1000);
y_fit = (1 / (dev_std_g(2) * sqrt(2*pi))) * exp(-0.5 * ((x_fit - g_med(2)) / dev_std_g(2)).^2) * h.BinWidth;
plot(x_fit, y_fit, 'Color', 'b', 'LineWidth', 2);

max_y = max([max(h.Values), max(y_fit)]); 
margine_y = max_y * 0.10;
ylim([0, max_y + margine_y]);

xlabel('Gittata (cm)');
ylabel('Frequenza relativa');
title('Distribuzione delle gittate con Fit - Angolo di 45°');
legend('Dati', 'Fit Gaussiano');

grid on;
hold off;

% 65°
figure;
hold on;

h = histogram(g_65_vet, 'BinMethod', 'fd', 'Normalization', 'probability');

min_bin = h.BinEdges(1);
max_bin = h.BinEdges(end);
range_x = max_bin - min_bin;
margine_x = range_x * 0.10;

xlim([min_bin - margine_x, max_bin + margine_x]);

% Calcolo della curva Gaussiana (rimosso il fattore length)
x_fit = linspace(min_bin - margine_x, max_bin + margine_x, 1000);
y_fit = (1 / (dev_std_g(3) * sqrt(2*pi))) * exp(-0.5 * ((x_fit - g_med(3)) / dev_std_g(3)).^2) * h.BinWidth;
plot(x_fit, y_fit, 'Color', 'b', 'LineWidth', 2);

max_y = max([max(h.Values), max(y_fit)]);
margine_y = max_y * 0.10;
ylim([0, max_y + margine_y]);

xlabel('Gittata (cm)');
ylabel('Frequenza relativa');
title('Distribuzione delle gittate con Fit - Angolo di 65°');
legend('Dati', 'Fit Gaussiano');

grid on;
hold off;

% Uniti
figure;
hold on;

h1 = histogram(g_25_vet, 'BinMethod', 'fd', 'Normalization', 'probability');
h2 = histogram(g_45_vet, 'BinMethod', 'fd', 'Normalization', 'probability', 'FaceColor', 'r', 'FaceAlpha', 0.5);
h3 = histogram(g_65_vet, 'BinMethod', 'fd', 'Normalization', 'probability', 'FaceColor', 'g', 'FaceAlpha', 0.5);

min_bin = min([h1.BinEdges(1), h2.BinEdges(1), h3.BinEdges(1)]);
max_bin = max([h1.BinEdges(end), h2.BinEdges(end), h3.BinEdges(end)]);

range_x = max_bin - min_bin;
margine_x = range_x * 0.10;
xlim([min_bin - margine_x, max_bin + margine_x]);

% Calcolo della curva Gaussiana (rimosso il fattore length)
x_fit = linspace(min_bin - margine_x, max_bin + margine_x, 1000);
y_fit1 = (1 / (dev_std_g(1) * sqrt(2*pi))) * exp(-0.5 * ((x_fit - g_med(1)) / dev_std_g(1)).^2) * h1.BinWidth;
y_fit2 = (1 / (dev_std_g(2) * sqrt(2*pi))) * exp(-0.5 * ((x_fit - g_med(2)) / dev_std_g(2)).^2) * h2.BinWidth;
y_fit3 = (1 / (dev_std_g(3) * sqrt(2*pi))) * exp(-0.5 * ((x_fit - g_med(3)) / dev_std_g(3)).^2) * h3.BinWidth;

plot(x_fit, y_fit1, 'Color', 'b', 'LineWidth', 2);
plot(x_fit, y_fit2, 'Color', 'r', 'LineWidth', 2);
plot(x_fit, y_fit3, 'Color', 'g', 'LineWidth', 2);

max_y = max([max(h1.Values), max(h2.Values), max(h3.Values), max(y_fit1), max(y_fit2), max(y_fit3)]);

margine_y = max_y * 0.10;
ylim([0, max_y + margine_y]);

xlabel('Gittata (cm)');
ylabel('Frequenza relativa');
title('Distribuzione delle gittate con Fit in funzione dell''angolo di lancio');

legend('25°', '45°', '65°', 'Fit 25°', 'Fit 45°', 'Fit 65°', ...
       'Location', 'northeast', 'NumColumns', 2);

grid on;
hold off;