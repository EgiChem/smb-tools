function plotLinearSepRegion(H, m2_m3)
% Plots the triangular separation region for a Linear isotherm.

arguments
    H (1,2) double
    m2_m3 = []
end

K = [min(H) max(H)];

% Plot separation region
plot([K(1) K(1) K(2)], [K(1) K(2) K(2)], '-k', LineWidth=2)
hold on;
plot([floor(K(1)) ceil(K(2))], [floor(K(1)) ceil(K(2))], '-k', LineWidth=2)

% Plot the operation point
if ~isempty(m2_m3)
    plot(m2_m3(1), m2_m3(2), 'or', MarkerFaceColor='r')  % operation point
end

% Set plot range
r = triangleTheory.getPlotRange(K);
axis([r(1) r(2)  r(1) r(2)]);

% Format plot
xlabel('{\itm}_2')
ylabel('{\itm}_3')
grid on;
grid minor;
drawnow;
