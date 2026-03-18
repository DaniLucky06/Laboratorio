cl
% Esegue il file startup-m - MODIFICARE IL PATH
run('/Users/giacomovanzelli/MATLAB/startup.m')

% Assegno alla variabile T la tabella integrale dei dati raccolti + cose
tabella = readtable('dati_esperienza_pendolo.csv');

numero_misure = 100;
distanza_tavolo_perno = 761;
distanza_tavolo_massa = 41;
altezza_massa = 19.05;
lunghezza = distanza_tavolo_perno - (distanza_tavolo_massa + altezza_massa / 2);

% Periodo atteso
periodo_atteso = 2 * pi * sqrt(lunghezza / (g * 1000));

% Converto la tabella in una matrice
matrice = table2array(tabella);

% Calcolo la media dei periodi
media = mean(matrice, "all") / 5;

% Calcolo la deviazione standard
deviazione_standard = std(matrice, 1, "all") / 5;

% Calcolo l'errore sulla media
errore_sulla_media = deviazione_standard / sqrt(numero_misure);

% Risoluzioni misure
risoluzione_distanza_tavolo_perno = 1;
risoluzione_distanza_tavolo_massa = 1;
risoluzione_altezza_massa = 0.05;
risoluzione_tempo = 0.01;

% Calcolo degli errori sulla risoluzione
errore_lunghezza = sqrt((risoluzione_distanza_tavolo_perno^2 + risoluzione_distanza_tavolo_massa^2 + risoluzione_altezza_massa^2) / 12);
errore_tempo = risoluzione_tempo / sqrt(12);

% Calcolo l'errore totale tempo
errore_totale_tempo = rssq([errore_sulla_media, errore_tempo]);

% Calcolo la media dei periodi set per set
media_set = mean(matrice, 1) / 5;

deviazione_standard_fra_set = std(media_set, 1);