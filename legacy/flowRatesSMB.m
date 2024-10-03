% Calculate SMB flow-rates 
% Simple mass balance calculation to obtain classic 4-zone SMB flow rates. 
% Provides valus for EgiChem SMB unit pumps P1 - P4 and MFC.
% José Aniceto


%% Inputs
% Provide fow flowrates. Provide values for QE, QF and Q1. Also provide either QR or QX.
QE = 2/1;
QF = 1/1;
QX = 1.5/1;
Q1 = 3/1;

% If pump position is changed in SMB configuration, make the correct adjustments below.
P1 = 'QE';
P2 = 'QX';
P3 = 'Q3';
P4 = 'QF';
Cor = 'Q2';


%% Calculations
if exist('QE', 'var') && exist('QX', 'var') && exist('QF', 'var') && exist('Q1', 'var')
    % Eluent, extract, feed and zone 1 are provided.
    Q2 = Q1 - QX;
    Q3 = Q2 + QF;
    Q4 = Q1 - QE;
    QR = Q3 - Q4;

elseif exist('QE', 'var') && exist('QR', 'var') && exist('QF', 'var') && exist('Q1', 'var')
    % Eluent, feed, raffinate, and zone 1 are provided.
    Q4 = Q1 - QE;
    Q3 = Q4 + QR;
    Q2 = Q3 - QF;
    QX = Q1 - Q2;

else
error('Insuficient flow rates were provided. Provide values for QE, QF and Q1. Also provide either QR or QX.')
end


%% Print results
fprintf('\nFlow-rates obtained from mass balance:\n')
fprintf('Q1 = %-2.2f  |  Q2 = %-2.2f  |  Q3 = %-2.2f  |  Q4 = %-2.2f\n', Q1, Q2, Q3, Q4)
fprintf('QF = %-2.2f  |  QR = %-2.2f  |  QE = %-2.2f  |  QX = %-2.2f\n\n', QF, QR, QE, QX)

fprintf([ ...
    'Flow-rates for SMB:\n' ...
    'P1  (%s) = %.2f \n' ...
    'P2  (%s) = %.2f \n' ...
    'P3  (%s) = %.2f \n' ...
    'P4  (%s) = %.2f \n' ...
    'Cor (%s) = %.2f\n\n' ...
], P1, eval(P1), P2, eval(P2), P3, eval(P3), P4, eval(P4), Cor, eval(Cor))
