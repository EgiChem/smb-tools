function process_1col_log(filepath, pump, detector)
% Process chromatogram data from SMB unit log file. Creates pressure and 
% absorbance plots.
%
% filepath : Log file path (including extension)
% pump (optional) : Pump number. Must be 1, 2, 3, or 4. Default is 1.
% detector (optional) : Detector number. Must be 1 or 2. Default is 1.
%
% This function is a simpler version of the process_log.m script.
%
% José Aniceto

arguments
    filepath char;
    pump (1,1) double {mustBeMember(pump, [1 2 3 4])} = 1
    detector (1,1) double {mustBeMember(detector, [1 2])} = 1
end

%% Read data from file
% Read into table
data = readtable(filepath, 'ReadRowNames', true, 'DecimalSeparator',',', 'VariableNamingRule','preserve');

% Table columns to array
time = arrayfun(@time_string_to_seconds, data{:,1}) / 60;  % min, elapsed time
pumpQ = data{:,pump+1};  % mL/min, pump flow-rate
pumpP = data{:,pump+6};  % bar, pump pressure
detect = data{:,detector+10};  % mAU, detector absorbance


%% Process data
% Set default styles for plots
set(0, 'DefaultLineLineWidth', 1.5);

% Print file data
fprintf('Processing data from log file... \n');
fprintf('%s \n', filepath);
fprintf('%s \n\n', data.Properties.RowNames{1});

% Pressure
figure
plot(time, pumpP, '-')
xlabel('{\itt} (min)')
ylabel('{\itP} (bar)')

% Detector
figure
plot(time, detect, '-')
xlabel('{\itt} (min)')
ylabel('{\itA} (mAU)')



%% Helper functions
function s = time_string_to_seconds(time_str)
% Convert a time string (e.g. '14:35:59.812') into seconds.

[~, ~, ~, h, min, s] = datevec(time_str);
s = h*3600 + min*60 + s;