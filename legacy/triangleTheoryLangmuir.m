% Calculate SMB operation conditions using the Triangle Theory
% Langmuir Isotherm
% José Aniceto

%% Inputs
Q = [17.544	17.606];  % Langmuir isotherm constant Q (capacity)
b = [0.103	0.109];  % Langmuir isotherm constant b (b1 < b2)
% Q = 5.874;  % Langmuir isotherm constant Q (capacity)
% b = [1.807 0.1547];  % Langmuir isotherm constant b (b1 < b2)
epsb = 0.4;
Lc = 10;  % cm
Dc = 2.1;  % cm
Q1 = 35;  % ml/min
Cfeed = [2 2];
m2m3 = 0;


%% Calculation
clc;

[tsw, Qint, QF, QX, QR, QE, m, gamma] = runTriangleTheoryLangmuir(Q, b, Cfeed, epsb, Lc, Dc, Q1);



%% Functions
function [tsw, Qint, QF, QX, QR, QE, m, gamma] = runTriangleTheoryLangmuir(Q, b, Cfeed, epsb, Lc, Dc, Q1, m2m3)

lambda = b .* Q;
Vc = pi() * (Dc^2)/4 * Lc;

% Calculation of wG e wF (wG > wF > 0)
coeffs = [
    1 + b(1)*Cfeed(1) + b(2)*Cfeed(2)
    -( lambda(1) * (1 + b(2) * Cfeed(2)) + lambda(2) * (1 + b(1) * Cfeed(1)) )
    lambda(1) * lambda(2)
];

w = roots(coeffs);
wg = max(w);
wf = min(w);

% Separation region
point_a = [lambda(1) ; lambda(1)];

point_b = [lambda(2) ; lambda(2)];

point_r = [
    wg^2 / lambda(2) ;
    wg * (wf*(lambda(2)-wg)*(lambda(2)-lambda(1)) + lambda(1)*wg*(lambda(2)-wf)) / ( lambda(1)*lambda(2)*(lambda(2)-wf) )
];

point_w = [
    lambda(1) * wg / lambda(2) ;
    wg * ( wf*(lambda(2)-lambda(1)) + lambda(1)*(lambda(1) - wf) ) / (lambda(1)*(lambda(2) - wf))
];


curve_rb_m2 = linspace(point_r(1), point_b(1))';
curve_rb_m3 = curve_rb_m2 + ( sqrt(lambda(2)) - sqrt(curve_rb_m2) ).^2 / ( b(2) * Cfeed(2) );


% Create separation region plot
plot([floor(lambda(1)) ceil(lambda(2))], [floor(lambda(1)) ceil(lambda(2))], '-k', LineWidth=2)  % diagonal
hold on;

plot([point_w(1), point_a(1)], [point_w(2), point_a(2)], '-k', LineWidth=2)  % line wa

plot([point_w(1), point_r(1)], [point_w(2), point_r(2)], '-k', LineWidth=2)  % line wr

plot(curve_rb_m2, curve_rb_m3, '-k', LineWidth=2)  % curve rb



if exist('m2_m3', 'var')
    plot(m2_m3(1), m2_m3(2), 'or', MarkerFaceColor='r')  % operation point
end

xlabel('{\itm}_2')
ylabel('{\itm}_3')
grid on;
grid minor;
drawnow;


% Print results
% fprintf('\n-------------- TRIANGLE THEORY (LANGMUIR ISOTHERM) --------------\n\n')
% 
% fprintf('Column volume:  Vc = %.2f (free volume, epsilon*Vc = %.2f)\n', Vc, epsb*Vc)
% 
% fprintf([ ...
%     'SMB flow rates (ml/min) and switch time (min)\n' ...
%     'Q1 = %-6.2f   |   Q2 = %-6.2f   |   Q3 = %-6.2f   |   Q4 = %-6.2f\n' ...
%     'QX = %-6.2f   |   QF = %-6.2f   |   QR = %-6.2f   |   QE = %-6.2f\n' ...
%     'tsw = %-6.2f\n\n' ...
% ], Qint(1), Qint(2), Qint(3), Qint(4), QX, QF, QR, QE, tsw);
% 
% fprintf([ ...
%     'Flow rate ratios\n' ...
%     '[TMB]   m1     = %-3.2f  |  m2     = %-3.2f  |  m3     = %-3.2f  |  m4     = %-3.2f\n' ...
%     '[TMB]   gamma1 = %-3.2f  |  gamma2 = %-3.2f  |  gamma3 = %-3.2f  |  gamma4 = %-3.2f\n' ...
%     '[SMB]   gamma1 = %-3.2f  |  gamma2 = %-3.2f  |  gamma3 = %-3.2f  |  gamma4 = %-3.2f\n' ...
% ], m(1), m(2), m(3), m(4), gamma(1), gamma(2), gamma(3), gamma(4), gammaSMB(1), gammaSMB(2), gammaSMB(3), gammaSMB(4))
% 
% fprintf('\n---------------------------------------------\n\n')

end
