function [flowrates, tsw, outputs] = linearLangmuir(Lc, Dc, epsb, m, Q, b, Cfeed, Q1_SMB, beta, gamma23, draw_region, show_gamma14)

arguments
    Lc (1,1) double  % column length
    Dc (1,1) double  % column internal diameter
    epsb (1,1) double  % bulk porosity
    m (1,1) double  % Linear term constant m 
    Q (1,2) double  % Langmuir term constant Q = [Q1, Q2]
    b (1,2) double  % Langmuir term constant b = [b1, b2]
    Cfeed (1,2) double  % feed concentration of each compound
    Q1_SMB (1,1) double  % flow rate in zone 1 of the SMB
    beta (1,1) double {mustBeGreaterThanOrEqual(beta, 1)} = 1.0  % safetry factor (beta >= 1)
    gamma23 = []
    draw_region = true
    show_gamma14 = false
end

%% Determine operating conditions
lambda = Q .* b;  % linear term for Langmuir isotherm: [Q*b1, Q*b2]
lambda = [min(lambda), max(lambda)];  % [less retained compound (A), more retained compound (B)]

F = (1 - epsb) / epsb;
F_lambda = F * lambda;  % (1-epsb)/epsb * lambda

[flowrates, tsw, outputs] = triangleTheory.langmuir(Lc, Dc, epsb, Q, b, Cfeed, Q1_SMB, beta, gamma23, false);



%% Draw separation region
if draw_region
    quad_a = 1 + b(1)*Cfeed(1) + b(2)*Cfeed(2);
    quad_b = -( lambda(1)*(1 + b(2)*Cfeed(2)) + lambda(2)*(1 + b(1)*Cfeed(1)) );
    quad_c = lambda(1)*lambda(2);
    wg = (-quad_b + sqrt(quad_b^2 - 4*quad_a*quad_c)) / (2*quad_a);
    wf = (-quad_b - sqrt(quad_b^2 - 4*quad_a*quad_c)) / (2*quad_a);

    % Separation region in m2-m3
    point_a = [lambda(1) ; lambda(1)] + m;
    point_b = [lambda(2) ; lambda(2)] + m;
    point_r = [
        wg^2 / lambda(2) + m ;
        wg * (wf*(lambda(2)-wg)*(lambda(2)-lambda(1)) + lambda(1)*wg*(lambda(2)-wf)) / ( lambda(1)*lambda(2)*(lambda(2)-wf) ) + m
    ];
    point_w = [
        lambda(1) * wg / lambda(2) + m ;
        wg * ( wf*(lambda(2)-lambda(1)) + lambda(1)*(lambda(1) - wf) ) / (lambda(1)*(lambda(2) - wf)) + m
    ];
    curve_rb_m2 = linspace(point_r(1), point_b(1))';
    curve_rb_m3 = curve_rb_m2 + ( sqrt(lambda(2)) - sqrt(curve_rb_m2) ).^2 / ( b(2) * Cfeed(2) );
    
    % Separation region in gamma2-gamma3: 
    point_a_gammas = point_a * F;
    point_b_gammas = point_b * F;
    point_r_gammas = point_r * F;
    point_w_gammas = point_w * F;
    curve_rb_gammas = [(curve_rb_m2+m) * F, (curve_rb_m3+m) * F];

    % If no operating point is selected, select the vertex of the triangle
    if isempty(gamma23)
        gamma23 = point_w_gammas;
    end

    % Find plot range
    % r = triangleTheory.getPlotRange(lambda * F + m);
    r = triangleTheory.getPlotRange([point_a_gammas(1), point_b_gammas(1)]);

    plot(r, r, '-k', LineWidth=2)  % diagonal
    hold on;
    plot([point_w_gammas(1), point_a_gammas(1)], [point_w_gammas(2), point_a_gammas(2)], '-k', LineWidth=2)  % line wa
    plot([point_w_gammas(1), point_r_gammas(1)], [point_w_gammas(2), point_r_gammas(2)], '-k', LineWidth=2)  % line wr
    plot(curve_rb_gammas(:,1), curve_rb_gammas(:,2), '-k', LineWidth=2)  % curve rb
    plot(gamma23(1), gamma23(2), 'or', MarkerFaceColor='r')  % gamma2-gamma3 operation point

    % Plot the gamma1-gamma4 region
    if show_gamma14
        plot([F_lambda(2) F_lambda(2) r(2)], [r(1) F_lambda(1) F_lambda(1)], '-k', LineWidth=2)  % gamma1-gamma4 square
        plot(outputs.gamma_TMB(1), outputs.gamma_TMB(4), 'or', MarkerFaceColor='r')  % gamma1-gamma4 operation point
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
