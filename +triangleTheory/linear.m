function [flowrates, tsw, outputs] = linear(Lc, Dc, epsb, H, Q1_SMB, beta, gamma23, draw_region, show_gamma14)

arguments
    Lc (1,1) double  % column length
    Dc (1,1) double  % column internal diameter
    epsb (1,1) double  % bulk porosity
    H (1,2) double  % linear equilibrium constants
    Q1_SMB (1,1) double  % flow rate in zone 1 of the SMB
    beta (1,1) double {mustBeGreaterThanOrEqual(beta, 1)} = 1.0  % safetry factor (beta >= 1)
    gamma23 = []
    draw_region = true
    show_gamma14 = false
end

%% Determine operating conditions
H = [min(H), max(H)];  % equilibrium constant: [less retained compound (A), more retained compound (B)]

F = (1 - epsb) / epsb;
F_H = F * H;  % (1-epsb)/epsb * H

A = pi() * Dc^2 / 4;  % column cross-section area
Vc = A * Lc;  % column volume

% Flow rate ratios
gamma1_TMB = F * H(2) * beta;
gamma4_TMB = F * H(1) / beta;

tsw = epsb * Vc / Q1_SMB * (gamma1_TMB + 1);  % switch time

% If no operating point is selected, select the vertex of the triangle
if isempty(gamma23)
    gamma23 = [F_H(1) F_H(2)];
end

gamma_TMB = [gamma1_TMB, gamma23(1), gamma23(2), gamma4_TMB];

gamma_SMB = gamma_TMB + 1;

% SMB flow rates
Qj = epsb * Vc / tsw * gamma_SMB;  % internal SMB flow rates

flowrates.QE = Qj(1) - Qj(4);
flowrates.QX = Qj(1) - Qj(2);
flowrates.QF = Qj(3) - Qj(2);
flowrates.QR = Qj(3) - Qj(4);
flowrates.Q1 = Qj(1);
flowrates.Q2 = Qj(2);
flowrates.Q3 = Qj(3);
flowrates.Q4 = Qj(4);

outputs = flowrates;
outputs.tsw = tsw;
outputs.gamma_TMB = gamma_TMB;
outputs.gamma_SMB = gamma_SMB;
outputs.m = [gamma1_TMB/F, gamma23(1)/F, gamma23(2)/F, gamma4_TMB/F];
outputs.Vc = Vc;


%% Draw separation region
if draw_region
    % Find plot range
    r = triangleTheory.getPlotRange(F_H);
    
    % Plot gamma2-gamma3 separation region
    plot(r, r, '-k', LineWidth=2)  % diagonal
    hold on;
    plot([F_H(1) F_H(1) F_H(2)], [F_H(1) F_H(2) F_H(2)], '-k', LineWidth=2)  % gamma2-gamma3 triangle
    plot(gamma_TMB(2), gamma_TMB(3), 'or', MarkerFaceColor='r')  % gamma2-gamma3operation point
    
    % Plot the gamma1-gamma4 region
    if show_gamma14
        plot([F_H(2) F_H(2) r(2)], [r(1) F_H(1) F_H(1)], '-k', LineWidth=2)  % gamma1-gamma4 square
        plot(gamma_TMB(1), gamma_TMB(4), 'or', MarkerFaceColor='r')  % gamma1-gamma4 operation point
        % p = get(gca, 'Position');
        % w = 0.03;
        % h = 0.06;
        % annotation('textbox', [(p(1)+p(3)-4*w) (p(2)) w h], 'String', 'm_1', 'EdgeColor', 'none');
        % annotation('textbox', [(p(1)+p(3)-w) (p(2)+h) w h], 'String', 'm_4', 'EdgeColor', 'none', 'HorizontalAlignment', 'right');
    end
    
    % Format plot
    axis([r(1) r(2)  r(1) r(2)]);
    xlabel('{\gamma}_2')
    ylabel('{\gamma}_3')
    grid on;
    grid minor;
    drawnow;
end

end
