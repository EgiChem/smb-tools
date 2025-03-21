% Prepare a SMB run 
%
% Set up necessary info for input in SMB control software. This script performs the following tasks:
%   1) Provided four flowrates, calculates the remaining four by mass balance for a classic 4-zone SMB. 
%   2) Provided the pumps-zones correspondance, it provides values for EgiChem SMB unit pumps P1 - P4 and MFC (Coriolis).
%   3) Create generate a recipe file from the calculated flowrates
%
% José Aniceto

clear;

%% Inputs
% Provide any four flow flowrates in mL/min.
fr.QE = 9.40;
fr.QF = 1.54;
fr.QX = 7.32;
fr.Q1 = 15;

% Define the roles of each pump in the SMB unit. Possibilities: QE, QX, QR, QF, Q1, Q2, Q3, Q4
P1 = 'QE';
P2 = 'Q1';
P3 = 'QR';
P4 = 'QF';
Cor = 'Q2';
CorIPB = 'Q4';

% SMB configuration (columns per section) for genarating recipe
generate_recipe = false;
config = [1 2 2 1];
tsw = 4.51;  % min

% Run conditions
n_cycles = 15;  % number of cycles


%% Tasks
% Calculate flowrates
[~, fr] = smb.flowrates(fr);

flows = dictionary( ...
    'P1', fr.(P1), ...
    'P2', fr.(P2), ...
    'P3', fr.(P3), ...
    'P4', fr.(P4), ...
    'Cor', fr.(Cor), ...
    'CorIPB', fr.(CorIPB) ...
);


% Create recipe
if generate_recipe
    experimental.generateRecipeFile(config, flows, tsw)
end


% Solvent and feed required for a given run
n_cols = sum(config);
Vfeed = fr.QF * (n_cycles * n_cols * tsw);
Veluent = fr.QE * (n_cycles * n_cols * tsw);
Vraffinate = fr.QR * (n_cycles * n_cols * tsw);
Vextract = fr.QX * (n_cycles * n_cols * tsw);


% Print results
fprintf('Flow-rates obtained from mass balance:\n')
fprintf('Q1 = %-2.2f  |  Q2 = %-2.2f  |  Q3 = %-2.2f  |  Q4 = %-2.2f\n', fr.Q1, fr.Q2, fr.Q3, fr.Q4)
fprintf('QF = %-2.2f  |  QR = %-2.2f  |  QE = %-2.2f  |  QX = %-2.2f\n\n', fr.QF, fr.QR, fr.QE, fr.QX)

fprintf([ ...
    'Flow-rates for SMB:\n' ...
    'P1  (%s) = %.2f \n' ...
    'P2  (%s) = %.2f \n' ...
    'P3  (%s) = %.2f \n' ...
    'P4  (%s) = %.2f \n' ...
    'Cor (%s) = %.2f\n' ...
    'CorIPB (%s) = %.2f\n\n' ...
], P1, fr.(P1), P2, fr.(P2), P3, fr.(P3), P4, fr.(P4), Cor, fr.(Cor), CorIPB, fr.(CorIPB))

fprintf('Volumes required for inlets/outlets:\n')
fprintf('Raffinate: %.0f mL | Extract: %.0f mL\n', ceil(Vraffinate), ceil(Vextract))
fprintf('Feed: %.0f mL | Eluent: %.0f mL\n\n', ceil(Vfeed), ceil(Veluent))