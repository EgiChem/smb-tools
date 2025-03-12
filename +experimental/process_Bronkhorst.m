function out = process_Bronkhorst(filepath, signals, make_plots)
% Load Bronkhorst FlowSuit2 flow rate data from Coriolis.
%
% Input the CSV log file path (including extension) in the filepath variable.
% The script creates flow-rate plot.
%
% Arguments:
%   filepath (char) : path to log file
%   signals (char) : if the script should process all Coriolis data ('all') or only
%   Corioris 1 ('one') or Coriolis 2 ('two').
%
% Returns:
%   (struct) : Structure containing all collected data: time, flow rate set
%   point and value for each Coriolis.
%
% Example:
%   experimental.process_Bronkhorst('sample-files/Bronkhorst FlowSuite Export 1 sec 2025_01_17 16_10_20.csv')
%
% Author: José Aniceto


arguments
    filepath (1,:) char
    signals (1,:) char {mustBeMember(signals, {'all', 'one', 'two'})} = 'all'
    make_plots = true
end

fprintf('Processing data from log file... \n');

ymax = 1;  % initial y-axis max range

% Load CSV file
fprintf('%s \n', filepath);
data = readtable(filepath, 'Delimiter', ';', 'DecimalSeparator', ',');

% Number of signals
n_cols = width(data);
n_signals = (n_cols - 1) / 2;  % there are 2 columns per signal (setpoint and flow) and a time column

% Calculate elapsed time
data.time = minutes(data.TimeStamp - data.TimeStamp(1));

out.time = data.time;
for i = 1:n_signals
    out.(sprintf('setpoint%i', i)) = data{:,1+i};
    out.(sprintf('flow%i', i)) = data{:,1+i+1};
end

% Plot flow-rates
if make_plots
    % Set default styles for plots
    set(0, 'DefaultLineLineWidth', 1.5);

    figure(1)
    legend_array = {};
    
    if strcmp(signals, 'one') || strcmp(signals, 'all')
        plot(data.time, data{:,3}, LineStyle='-')  % Coriolis 1 flow
        hold on;
        plot(data.time, data{:,2}, LineStyle='--')  % Coriolis 1 set-point
        legend_array = [legend_array, {'MFC1 flow', 'MFC1 setpoint'}];
        ymax = max( [ymax, max(data{:,3})] );
    end
    
    if strcmp(signals, 'two') || strcmp(signals, 'all')
        plot(data.time, data{:,5}, LineStyle='-')  % Coriolis 2 flow
        hold on;
        plot(data.time, data{:,4}, LineStyle='--')  % Coriolis 2 set-point
        legend_array = [legend_array, {'MFC2 flow', 'MFC2 setpoint'}];
        ymax = max( [ymax, max(data{:,5})] );
    end
    
    % Get y-axis max value and update final ymax if needed
    % current_ymax = max( [max(data{:,3}), max(data{:,5})] );
    % if current_ymax > ymax
    %     ymax = current_ymax;
    % end
    
    % Format plots
    for i = 1:1
        subplot(1, 1, i)
        ylim([0 ymax])
        ylabel('Flow (ml/min)')
    end
    xlabel('Time (min)')
    legend(legend_array, Location="southeast")
    
    % Print info
    fprintf('Plot ranges:\n');
    fprintf('x-axis: 0 - %.2f\n', max(data.time));
    fprintf('y-axis: 0 - %.2f\n', ymax);
    fprintf('To change plot axis you can run the following command: \n');
    fprintf('axis([xmin xmax  ymin ymax])\n\n');

end
