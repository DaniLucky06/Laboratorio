clc, clear
run('calcoli_proietto.m');

% angolo di offset ideale
offset = delta_optimal;

% GRAFICA
wid = 2;
col2 = 'green';
col3 = 'red';
alpha2 = .4;
alpha3 = .4;

limiti_x = [20, 70];
limiti_y = [100, 162];

% vogliamo plottare:

%   1) la gittata in funzione dell'angolo senza correzzione energia
g_theta = @(theta) mean(g_med ./ sin(2 .* angoli)) .* sin(2 .* theta);

%   2) la gittata con correzione energia --> g_teo(theta)

%   3) la gittata con correzione energia e offset angolo
U_mg_theta_offset = mean(g_med ./ (2 .* sin(2 .* (angoli + offset))) + dx .* sin(angoli + offset));
g_teo_offset = @(theta) 2 .* sin(2 .* (theta + offset)) .* (U_mg_theta_offset - dx .* sin(theta + offset));

sigma_U_mg_offset = @(theta, off) 2 .* sin(2 .* (theta + off)) .* sigma_U_mg_med;

% array x per i grafici
x = limiti_x(1):1:limiti_x(2);
x_rad = deg2rad(x);
x_fill = [x, fliplr(x)];


% --- DISEGNO GRAFICI --- %
figure;
hold on; grid on; box on;

% grafico 2) area
y2 = g_teo(x_rad);
y_upper2 = y2 + sigma_U_mg_offset(x_rad, 0);
y_lower2 = y2 - sigma_U_mg_offset(x_rad, 0);
y_fill2 = [y_upper2, fliplr(y_lower2)];
f2 = fill(x_fill, y_fill2, col2, 'FaceAlpha', alpha2, 'DisplayName', 'Previsione senza offset angolo', 'EdgeColor', 'k');

% grafico 3) area
y3 = g_teo_offset(x_rad);
y_upper3 = y3 + sigma_U_mg_offset(x_rad, offset);
y_lower3 = y3 - sigma_U_mg_offset(x_rad, offset);
y_fill3 = [y_upper3, fliplr(y_lower3)];
f3 = fill(x_fill, y_fill3, col3, 'FaceAlpha', alpha3, 'DisplayName', 'Previsione corretta', 'EdgeColor', 'k');

% - linee centrali - %
% plot(x, y2, col2, 'LineWidth', wid, 'HandleVisibility', 'off');
plot(x, y3, col3, 'LineWidth', wid, 'HandleVisibility', 'off');


% grafico 1)
p1 = plot(x, g_theta(x_rad), ':b', 'LineWidth', wid + 2, 'DisplayName', 'Previsione iniziale');

% plotta i punti misurati
% errorbar(rad2deg(angoli), g_med, err_tot, err_tot, err_ris_a, err_ris_a, 'k', 'MarkerFaceColor', 'black',  'MarkerSize', 3, 'HandleVisibility', 'off', 'LineWidth', .5, 'LineStyle','none');
plot(rad2deg(angoli), g_med, 'k+', 'MarkerFaceColor', 'black',  'MarkerSize', 10, 'LineWidth', 2, 'HandleVisibility', 'off');

angoli_gradi = rad2deg(angoli);
for i = 1:length(angoli_gradi)
    label_testo = sprintf('%d^\\circ', round(angoli_gradi(i)));
    
    text(angoli_gradi(i) - 1, g_med(i) + 1, label_testo, ...
        'HorizontalAlignment', 'right', ...
        'VerticalAlignment', 'bottom', ...
        'FontSize', 20, ...
        'FontWeight', 'bold', ...
        'Color', 'k', ...
        'BackgroundColor', [.9 .9 .9]);
end

% Dettagli estetici finali
ylim(limiti_y);


axis('normal')
set(gca, 'FontSize', 17)
xlabel('Angolo di lancio [Gradi]', 'FontWeight','bold', 'FontSize',20);
ylabel('Gittata [cm]', 'FontWeight','bold', 'FontSize', 20);
l = legend([p1, f2, f3], 'Location','south', 'FontSize', 18);
hold off;
