% Load Bronkhorst FlowSuit flow rate data from Coriolis

%% INPUTS
datafiles = {
    % 'sample-files/Bronkhorst FlowSuite Export 1 sec 2025_01_17 13_41_34-almoco.csv',
    % 'sample-files/Bronkhorst FlowSuite Export 1 sec 2025_01_17 16_10_20.csv'
    % 'Z:\SMB Tests\2025-02-11\Bronkhorst FlowSuite Export 1 sec 2025_02_11 15_44_14.csv',
    'Z:\SMB Tests\2025-02-11\Bronkhorst FlowSuite Export 1 sec 2025_02_11 16_03_23.csv'
};


%% LOAD AND PROCESS DATA
n_files = numel(datafiles);

if n_files > 3
    warning('Too many data files may make plots difficult to read. Try reducing the number of datafiles to analyze at once.')
end

ymax = 1;  % initial y-axis max range

for i = 1:n_files

    % Load CSV file
    filename = datafiles{i};
    data = readtable(filename, 'Delimiter', ';', 'DecimalSeparator', ',');
    
    % Calculate elapsed time
    data.ElapsedTime = minutes(data.TimeStamp - data.TimeStamp(1));
    
    % Plot flow-rates
    figure(1)
    subplot(n_files, 1, i)
    plot(data.ElapsedTime, data{:,3}, LineStyle='-')  % Coriolis 1 flow
    hold on;
    plot(data.ElapsedTime, data{:,2}, LineStyle='--')  % Coriolis 1 set-point
    plot(data.ElapsedTime, data{:,5}, LineStyle='-')  % Coriolis 2 flow
    plot(data.ElapsedTime, data{:,4}, LineStyle='--')  % Coriolis 2 set-point

    % Get y-axis max value and update final ymax if needed
    current_ymax = max(data{:,3});
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
legend({'MFC1 setpoint', 'MFC1 flow', 'MFC2 setpoint', 'MFC2 flow'}, Location="northeast")