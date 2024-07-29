% Calculate SMB flow-rates
clc

%% INPUTS
P1 = 'QE';
P2 = 'QX';
P3 = 'Q3';
P4 = 'QF';
Cor = 'Q2';

QE = 2/1;
QF = 1/1;
QX = 1.5/1;
Q1 = 3/1;

%% CALCULATIONS
if exist('QE', 'var') && exist('QX', 'var') && exist('QF', 'var') && exist('Q1', 'var')
    Q2 = Q1 - QE;
    Q3 = Q2 + QF;
    Q4 = Q1 - QE;
    QR = Q3 - Q4;

else
    error('Fail')
end


%% PRINT
fprintf('Flow-rates obtained from mass balance:\n')
fprintf('Q1 = %.2f  |  Q2 = %.2f  |  Q3 = %.2f  |  Q4 = %.2f\n', Q1, Q2, Q3, Q4)
fprintf('QF = %.2f  |  QR = %.2f  |  QE = %.2f  |  QX = %.2f\n\n', QF, QR, QE, QX)

fprintf([ ...
    'Flow-rates for SMB:\n' ...
    'P1 (%s): %.2f \n' ...
    'P2 (%s): %.2f \n' ...
    'P3 (%s): %.2f \n' ...
    'P4 (%s): %.2f \n' ...
    'Coriolis (%s): %.2f\n\n' ...
], P1, eval(P1), P2, eval(P2), P3, eval(P3), P4, eval(P4), Cor, eval(Cor))
