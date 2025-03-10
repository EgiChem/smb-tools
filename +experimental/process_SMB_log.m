function out = process_SMB_log(filepath, make_plots)
% Process all data from SMB unit log file.
%
% Input the log file path (including extension) in the filepath variable.
% The script creates flow-rate, pressure and absorbance plots.
%
% Arguments:
%   filepath (char) : path to log file
%
% Returns:
%   (struct) : Structure containing all collected data: time, flow rates in
%   each pump and in the flow meter, pressures in each pump, and detectors signals.
%
% Example:
%   experimental.process_SMB_log('sample-files/chrom_DHAEE_0_2_C18.txt')
%
% Author: José Aniceto

arguments
    filepath (1,:) char
    make_plots = true
end

% Read into table
data = readtable(filepath, 'ReadRowNames', true, 'DecimalSeparator',',', 'VariableNamingRule','preserve');

% Table columns to array
time = arrayfun(@time_string_to_seconds, data{:,1}) / 60;  % min, elapsed time
pump1Q = data{:,2};  % mL/min, pump 1 flow-rate
pump2Q = data{:,3};  % mL/min, pump 2 flow-rate
pump3Q = data{:,4};  % mL/min, pump 3 flow-rate
pump4Q = data{:,5};  % mL/min, pump 4 flow-rate
coriQ = data{:,6};  % mL/min, coriolis flow-rate
pump1P = data{:,7};  % bar, pump 1 pressure
pump2P = data{:,8};  % bar, pump 2 pressure
pump3P = data{:,9};  % bar, pump 3 pressure
pump4P = data{:,10};  % bar, pump 4 pressure
detect1 = data{:,11};  % mAU, detector 1 absorbance
detect2 = data{:,12};  % mAU, detector 2 absorbance

% Create a output structure
out = struct( ...
    'time', time, ...
    'pump1Q', pump1Q, 'pump2Q', pump2Q, 'pump3Q', pump3Q, 'pump4Q', pump4Q, 'coriQ', coriQ, ...
    'pump1P', pump1P, 'pump2P', pump2P, 'pump3P', pump3P, 'pump4P', pump4P, 'detect1', detect1, 'detect2', detect2 ...
);

% Print file data
fprintf('Processing data from log file... \n');
fprintf('%s \n', filepath);
fprintf('%s \n\n', data.Properties.RowNames{1});

if make_plots
    % Set default styles for plots
    set(0, 'DefaultLineLineWidth', 1.5);
    
    % Flow-rate
    figure
    subplot(2,3,1)
    plot(time, pump1Q, '-')
    ylabel('{\itQ}_{P1} (mL/min)')
    
    subplot(2,3,2)
    plot(time, pump2Q, '-')
    ylabel('{\itQ}_{P2} (mL/min)')
    
    subplot(2,3,3)
    plot(time, pump3Q, '-')
    subplot(2,3,4)
    ylabel('{\itQ}_{P3} (mL/min)')
    
    plot(time, pump4Q, '-')
    xlabel('{\itt} (min)')
    ylabel('{\itQ}_{P4} (mL/min)')
    
    subplot(2,3,5)
    plot(time, coriQ, '-')
    xlabel('{\itt} (min)')
    ylabel('{\itQ}_{Cor} (mL/min)')
    
    sgtitle('Flow rates') 
    
    % Flow-rates in the same plot
    figure
    plot(time, pump1Q, '-')
    hold on;
    plot(time, pump2Q, '-')
    plot(time, pump3Q, '-')
    plot(time, pump4Q, '-')
    plot(time, coriQ, '-')
    xlabel('{\itt} (min)')
    ylabel('{\itQ} (mL/min)')
    legend('Pump 1', 'Pump 2', 'Pump 3', 'Pump 4', 'Coriolis', Location='best')
    title('Flow rates') 
    
    % Pressure
    figure
    subplot(2,2,1)
    plot(time, pump1P, '-')
    ylabel('{\itP}_{P1} (bar)')
    
    subplot(2,2,2)
    plot(time, pump2P, '-')
    ylabel('{\itP}_{P2} (bar)')
    
    subplot(2,2,3)
    plot(time, pump3P, '-')
    xlabel('{\itt} (min)')
    ylabel('{\itP}_{P3} (bar)')
    
    subplot(2,2,4)
    plot(time, pump4P, '-')
    xlabel('{\itt} (min)')
    ylabel('{\itP}_{P4} (bar)')
    
    sgtitle('Pressures in the pumps') 
    
    % Pressures in the same plot
    figure
    plot(time, pump1P, '-')
    hold on;
    plot(time, pump2P, '-')
    plot(time, pump3P, '-')
    plot(time, pump4P, '-')
    xlabel('{\itt} (min)')
    ylabel('{\itP} (bar)')
    legend('Pump 1', 'Pump 2', 'Pump 3', 'Pump 4', Location='best')
    title('Pressures in the pumps') 
    
    % Detector
    figure
    plot(time, detect1, '-')
    hold on;
    plot(time, detect2, '-')
    xlabel('{\itt} (min)')
    ylabel('{\itA} (mAU)')
    legend('Detector 1', 'Detector 2', Location='best')
    
    figure
    plot(time, detect1, '-')
    xlabel('{\itt} (min)')
    ylabel('{\itA} (mAU)')
    
    figure
    plot(time, detect2, '-')
    xlabel('{\itt} (min)')
    ylabel('{\itA} (mAU)')

end

end


%% Helper functions
function s = time_string_to_seconds(time_str)
% Convert a time string (e.g. '14:35:59.812') into seconds.

[~, ~, ~, h, min, s] = datevec(time_str);
s = h*3600 + min*60 + s;
end