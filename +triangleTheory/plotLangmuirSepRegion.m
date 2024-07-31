function plotLangmuirSepRegion(Q, b, Cfeed, m2_m3)
% Plots the triangular separation region for a Langmuir isotherm.

arguments
    Q (1,2) double
    b (1,2) double
    Cfeed (1,2) double
    m2_m3 = []
end

lambda = b .* Q;

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


% Plot the operation point
if ~isempty(m2_m3)
    plot(m2_m3(1), m2_m3(2), 'or', MarkerFaceColor='r')  % operation point
end

% Set plot range
r = triangleTheory.getPlotRange(lambda);
axis([r(1) r(2)  r(1) r(2)]);

% Format plot
xlabel('{\itm}_2')
ylabel('{\itm}_3')
grid on;
grid minor;
drawnow;
