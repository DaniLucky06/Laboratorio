% Esegue il file "calcoli_esperienza_pendolo.m" per utilizzarne le variabili - CAMBIARE IL PATH 
run('/Users/giacomovanzelli/MATLAB/Esperienza pendolo/calcoli_esperienza_pendolo.m');

% Estraggo tutti i periodi come vettore colonna
periodi = matrice(:) / 5;

figure;
histogram(periodi, 'BinWidth', 0.005);

xlabel('Periodo (s)');
ylabel('Frequenza assoluta');
title('Istogramma dei periodi');
grid on;