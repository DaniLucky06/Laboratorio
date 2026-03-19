% Pulisco la console e svuoto le variabili
clear
clc

% Eseguo i calcoli necessari
run('/Users/giacomovanzelli/MATLAB/Esperienza pendolo/calcoli.m');

% --- SENZA FIT --- %
figure;

h = histogram(t_vet, 'BinMethod', 'fd', 'Normalization', 'pdf');

min_bin = h.BinEdges(1);
max_bin = h.BinEdges(end);
range_x = max_bin - min_bin;
margine_x = range_x * 0.10;

xlim([min_bin - margine_x, max_bin + margine_x]);

max_y = max(h.Values);
margine_y = max_y * 0.10;
ylim([0, max_y + margine_y]);

xlabel('Periodo (s)');
ylabel('Densità di probabilità');
title('Distribuzione del periodo');

grid on;

% --- CON FIT --- %
figure;

h = histogram(t_vet, 'BinMethod', 'fd', 'Normalization', 'pdf');
hold on;

min_bin = h.BinEdges(1);
max_bin = h.BinEdges(end);
range_x = max_bin - min_bin;
margine_x = range_x * 0.10;

xlim([min_bin - margine_x, max_bin + margine_x]);

x_fit = linspace(min_bin - margine_x, max_bin + margine_x, 1000);
y_fit = (1 / (dev_std_t_vet * sqrt(2*pi))) * exp(-0.5 * ((x_fit - t_med) / dev_std_t_vet).^2);

plot(x_fit, y_fit, 'Color', 'b', 'LineWidth', 2);

max_y = max([max(h.Values), max(y_fit)]);
margine_y = max_y * 0.10;
ylim([0, max_y + margine_y]);

xlabel('Periodo (s)');
ylabel('Densità di probabilità');
title('Distribuzione del periodo con Fit');
legend('Dati', 'Fit Gaussiano');

grid on;
hold off;