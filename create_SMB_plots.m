function create_SMB_plots(smb_filepath, bronkhorst_filepath)
% Create plots from an SMB run.
%
% Arguments:
%   smb_filepath (char) : path to SMB log file
%   bronkhorst_filepath (char) : path to Bronkhorst log file
%
% Example:
%   experimental.create_SMB_plots('sample-files/chrom_DHAEE_0_2_C18.txt', 'sample-files/Bronkhorst FlowSuite Export 1 sec 2025_01_17 16_10_20.csv')
%
% Author: José Aniceto

% 
% Process log data
smb_data = experimental.process_SMB_log(smb_filepath, false);
coriolis_data = experimental.process_Bronkhorst(bronkhorst_filepath, "all", false);

% Determine time range
time_max = max( [max(smb_data.time), max(coriolis_data.time)] );

% Set default styles for plots
set(0, 'DefaultLineLineWidth', 1.5);

figure
% subplot(2,1,1)
utils.subaxis(2,1,1, 'SpacingVert',0.02);
plot(smb_data.time, smb_data.pump1P, '-')
hold on;
plot(smb_data.time, smb_data.pump2P, '-')
plot(smb_data.time, smb_data.pump3P, '-')
plot(smb_data.time, smb_data.pump4P, '-')
xlim([0 time_max])
set(gca,'XTickLabel',[]);
ylabel('Pump pressure (bar)')
legend('Pump 1', 'Pump 2', 'Pump 3', 'Pump 4', 'Box', 'off', Location='best')

utils.subaxis(2,1,2)
plot(coriolis_data.time, coriolis_data.setpoint1, '--')
hold on;
plot(coriolis_data.time, coriolis_data.flow1, '-')
xlim([0 time_max])
xlabel('Time (min)')
ylabel('Coriolis flow (ml/min)')
legend('Set point', 'Flow', 'Box', 'off', Location='best')

end

