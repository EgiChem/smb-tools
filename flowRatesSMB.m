function flowRatesSMB()
clc

%% INPUTS:
Qeluent = 2/1;
Qfeed = 1/1;
Qextract = 1.5/1;
Qzone1 = 3/1;

%% CALCULATIONS
Qzone2 = Qzone1 - Qextract;
Qzone3 = Qzone2 + Qfeed;
Qzone4 = Qzone1 - Qeluent;
Qraffinate = Qzone3 - Qzone4;

%% PRINTING RESULTS
fprintf('Flow-rates obtained from mass balance:\n')
fprintf('Q1 = %.2f  |  Q2 = %.2f  |  Q3 = %.2f  |  Q4 = %.2f\n', Qzone1, Qzone2, Qzone3, Qzone4)
fprintf('QF = %.2f  |  QR = %.2f  |  QE = %.2f  |  QX = %.2f\n\n', Qfeed, Qraffinate, Qeluent, Qextract)
fprintf('Flow rates for SMB:\nP1 (eluent): %.2f \nP2 (zone2): %.2f \nP3 (zone4): %.2f \nP4 (feed): %.2f \nCoriolis (extract): %.2f\n', Qeluent, Qzone2, Qzone4, Qfeed, Qextract)
