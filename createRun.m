% Set up necessary info for input in SMB control software
%
% This script performs the following tasks:
%   1) Provided four flowrates, calculates the remaining four by mass balance for a classic 4-zone SMB. 
%   2) Provided the pumps-zones correspondance, it provides values for EgiChem SMB unit pumps P1 - P4 and MFC (Coriolis).
%   3) Create generate a recipe file from the calculated flowrates
%
% José Aniceto


%% Inputs
% Provide flow flowrates. Provide values for QE, QF and Q1. Also provide either QR or QX.
fr = struct();
fr.QE = 2;
fr.QF = 1;
fr.QX = 1.5;
fr.Q1 = 3;

% If pump position is changed in SMB configuration, make the correct adjustments below.
P1 = 'QE';
P2 = 'QX';
P3 = 'Q3';
P4 = 'QF';
Cor = 'Q2';

% SMB configuration (columns per section) for genarating recipe
generate_recipe = false;
config = [1 2 2 1];
tsw = 1;


%% Tasks
% Calculate flowrates
[~, fr] = smb.flowrates(fr);

flows = dictionary( ...
    'P1', fr.(P1), ...
    'P2', fr.(P2), ...
    'P3', fr.(P3), ...
    'P4', fr.(P4), ...
    'Cor', fr.(Cor) ...
);


% Create recipe
if generate_recipe
    smb.generateRecipeFile(config, flows, tsw)
end


% Print results
fprintf('\nFlow-rates obtained from mass balance:\n')
fprintf('Q1 = %-2.2f  |  Q2 = %-2.2f  |  Q3 = %-2.2f  |  Q4 = %-2.2f\n', fr.Q1, fr.Q2, fr.Q3, fr.Q4)
fprintf('QF = %-2.2f  |  QR = %-2.2f  |  QE = %-2.2f  |  QX = %-2.2f\n\n', fr.QF, fr.QR, fr.QE, fr.QX)

fprintf([ ...
    'Flow-rates for SMB:\n' ...
    'P1  (%s) = %.2f \n' ...
    'P2  (%s) = %.2f \n' ...
    'P3  (%s) = %.2f \n' ...
    'P4  (%s) = %.2f \n' ...
    'Cor (%s) = %.2f\n\n' ...
], P1, fr.(P1), P2, fr.(P2), P3, fr.(P3), P4, fr.(P4), Cor, fr.(Cor))
