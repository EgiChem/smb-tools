% Load Bronkhorst FlowSuit flow rate data from Coriolis

%% INPUTS
datafiles = {
    'sample-files/Bronkhorst FlowSuite Export 1 sec 2025_01_17 16_10_20.csv'
};

signals = 'all';  % which signals to plot (all, one or two)


%% LOAD AND PROCESS DATA
n_files = numel(datafiles);

if n_files > 3
    warning('Too many data files may make plots difficult to read. Try reducing the number of datafiles to analyze at once.')
end

% Set default styles for plots
set(0, 'DefaultLineLineWidth', 1.5);

fprintf('Processing data from log file... \n');

ymax = 1;  % initial y-axis max range
for i = 1:n_files

    % Load CSV file
    filepath = datafiles{i};
    fprintf('%s \n', filepath);
    data = readtable(filepath, 'Delimiter', ';', 'DecimalSeparator', ',');
    
    % Calculate elapsed time
    data.ElapsedTime = minutes(data.TimeStamp - data.TimeStamp(1));
    
    % Plot flow-rates
    figure(1)
    subplot(n_files, 1, i)
    legend_array = {};
    if strcmp(signals, 'one') || strcmp(signals, 'all')
        plot(data.ElapsedTime, data{:,3}, LineStyle='-')  % Coriolis 1 flow
        hold on;
        plot(data.ElapsedTime, data{:,2}, LineStyle='--')  % Coriolis 1 set-point
        legend_array = [legend_array, {'MFC1 flow', 'MFC1 setpoint'}];
    end
    if strcmp(signals, 'two') || strcmp(signals, 'all')
        plot(data.ElapsedTime, data{:,5}, LineStyle='-')  % Coriolis 2 flow
        hold on;
        plot(data.ElapsedTime, data{:,4}, LineStyle='--')  % Coriolis 2 set-point
        legend_array = [legend_array, {'MFC2 flow', 'MFC2 setpoint'}];
    end

    % Get y-axis max value and update final ymax if needed
    current_ymax = max( [max(data{:,3}), max(data{:,5})] );
    if current_ymax > ymax
        ymax = current_ymax;
    end

end

% Format plots
for i = 1:n_files
    subplot(n_files, 1, i)
    ylim([0 ymax])
    ylabel('Flow (ml/min)')
end
xlabel('Time (min)')
legend(legend_array, Location="southeast")

% Print info
fprintf('Plot ranges:\n');
fprintf('x-axis: 0 - %.2f\n', max(data.ElapsedTime));
fprintf('y-axis: 0 - %.2f\n', ymax);
fprintf('To change plot axis you can run the following command: \n');
fprintf('axis([xmin xmax  ymin ymax])\n\n');
