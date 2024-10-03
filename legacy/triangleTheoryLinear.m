% Calculate SMB operation conditions using the Triangle Theory
% Linear Isotherm
% José Aniceto

%% Inputs
H = [0.8386 1.6034];  % linear equilibrium constant
epsb = 0.4;
Lc = 10;  % cm
Dc = 2.1;  % cm
Q1 = 35;  % ml/min
beta = 1.1;  % safety factor


%% Calculation
clc;

[tsw, Qint, QF, QX, QR, QE, m, gamma] = runTriangleTheoryLinear(H, epsb, Lc, Dc, Q1, beta);



%% Functions
function [tsw, Qint, QF, QX, QR, QE, m, gamma] = runTriangleTheoryLinear(H, epsb, Lc, Dc, Q1, beta)

K = [min(H) max(H)];
alpha = K(2) / K(1);
Vc = pi() * (Dc^2)/4 * Lc;

% Safety margin (beta)
beta_max = sqrt(K(2) / K(1));
if beta >= beta_max
    fprintf('beta_max = %.4f\n\n', beta_max)
    error('beta >= beta max. Enter a lower safety factor (beta).')
end

% Flow rate ratios in the TMB (gamma_i = (1-epsilon)/epsilon * m_i)
m1TMB = K(2) * beta;  
m4TMB = K(1) / beta;

gamma1TMB = (1-epsb)/epsb * m1TMB;
gamma4TMB = (1-epsb)/epsb * m4TMB;

tsw = epsb * Vc / Q1 * (gamma1TMB + 1);  % switch time
Qs = (1 - epsb) * Vc / tsw;  % solid flow rate (TMB)

Q4TMB = K(1) * Qs / beta;
QE = (alpha * beta^2 - 1) * Q4TMB;
QX = (alpha - 1) * beta^2 * Q4TMB;
QF = (alpha - beta^2) * Q4TMB;
QR = (alpha - 1) * Q4TMB;

Q1TMB = Q4TMB + QE;
Q2TMB = Q1TMB - QX;
Q3TMB = Q2TMB + QF;
QintTMB = [Q1TMB Q2TMB Q3TMB Q4TMB];  % TMB internal flow rates

Qint = QintTMB + epsb/(1-epsb) * Qs;  % SMB internal flow rates

% TMB flow rate ratios
m = QintTMB / Qs;
gamma = (1-epsb)/epsb * m;

% SMB flow rate ratios
gammaSMB = gamma + 1;

% Create separation region plot
plot([K(1) K(1) K(2)], [K(1) K(2) K(2)], '-k', LineWidth=2)
hold on;
plot([floor(K(1)) ceil(K(2))], [floor(K(1)) ceil(K(2))], '-k', LineWidth=2)
if beta > 1
    hold on
    plot(m(2), m(3), 'or', MarkerFaceColor='r')
end
xlabel('{\itm}_2')
ylabel('{\itm}_3')
grid on;
grid minor;
drawnow;


% Print results
fprintf('\n-------------- TRIANGLE THEORY (LINEAR ISOTHERM) --------------\n\n')

fprintf('Column volume:  Vc = %.2f (free volume, epsilon*Vc = %.2f)\n', Vc, epsb*Vc)
fprintf('Selectivity:    alpha = %.2f\n', alpha)
fprintf('Safety factor:  1 <= beta <= %.4f\n\n', beta_max)

fprintf([ ...
    'SMB flow rates (ml/min) and switch time (min)\n' ...
    'Q1 = %-6.2f   |   Q2 = %-6.2f   |   Q3 = %-6.2f   |   Q4 = %-6.2f\n' ...
    'QX = %-6.2f   |   QF = %-6.2f   |   QR = %-6.2f   |   QE = %-6.2f\n' ...
    'tsw = %-6.2f\n\n' ...
], Qint(1), Qint(2), Qint(3), Qint(4), QX, QF, QR, QE, tsw);

fprintf([ ...
    'Flow rate ratios\n' ...
    '[TMB]   m1     = %-3.2f  |  m2     = %-3.2f  |  m3     = %-3.2f  |  m4     = %-3.2f\n' ...
    '[TMB]   gamma1 = %-3.2f  |  gamma2 = %-3.2f  |  gamma3 = %-3.2f  |  gamma4 = %-3.2f\n' ...
    '[SMB]   gamma1 = %-3.2f  |  gamma2 = %-3.2f  |  gamma3 = %-3.2f  |  gamma4 = %-3.2f\n' ...
], m(1), m(2), m(3), m(4), gamma(1), gamma(2), gamma(3), gamma(4), gammaSMB(1), gammaSMB(2), gammaSMB(3), gammaSMB(4))

fprintf('\n---------------------------------------------------------------\n\n')

end
