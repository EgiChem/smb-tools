function generateRecipeFile(config, flows, tsw)
% Generate a recipe file for loading into EgiChem SMB software.

% Valve patern for 1-2-2-1 SMB with deactivated valves VD and VF (V4 and V6)
valv_pos_1221 = {
    '0;2;3;7;4;7;5;6';
    '6;0;2;7;3;7;4;5';
    '5;6;0;7;2;7;3;4';
    '4;5;6;7;0;7;2;3';
    '3;4;5;7;6;7;0;2';
    '2;3;4;7;5;7;6;0'
};

valv_pos_2222 = {
    '0;1;2;3;4;5;6;7';
    '7;0;1;2;3;4;5;6';
    '6;7;0;1;2;3;4;5';
    '5;6;7;0;1;2;3;4';
    '4;5;6;7;0;1;2;3';
    '3;4;5;6;7;0;1;2'
};

n_switches = sum(config);
if ~exist('tsw', 'var')
    tsw = 99;
end

% Open a new file
current_time = datetime('now','TimeZone','local','Format','yMMdd_HHmmss');
time_str = string(current_time);  
filename = join(['recipe_', time_str, '.txt'], '');
fileID = fopen(filename,'w');  % open text file

fprintf('SMB recipe:\n');
fprintf('tsw Cor P1 P2 P3 P4 VA VB VC VD VE VF VG VH\n');
% Each line (recipe_line) format is:  tsw; Cor; P1; P2; P3; P4; VA; VB; VC; VD; VE; VF; VG; VH
for i = 1:n_switches
    if isequaln(config,[1 2 2 1])
        recipe_line = sprintf( ...
            '%.2f;%.2f;%.2f;%.2f;%.2f;%.2f;%s', ...
            tsw, flows('Cor'), flows('P1'), flows('P2'), flows('P3'), flows('P4'), valv_pos_1221{i} ...
        );  % create a string for the current line (switch)

    elseif isequaln(config,[2 2 2 2])
        recipe_line = sprintf( ...
            '%.2f;%.2f;%.2f;%.2f;%.2f;%.2f;%s', ...
            tsw, flows('Cor'), flows('P1'), flows('P2'), flows('P3'), flows('P4'), valv_pos_2222{i} ...
        );  % create a string for the current line (switch)
    end
    recipe_line = strrep(recipe_line,'.',',');  % replace '.' by ','
    fprintf('%s \n', strrep(recipe_line,';',' '));  % print string to command line
    fprintf(fileID, '%s\r\n', recipe_line);  % print string to file
    % fprintf(fileID, '\r\n');  % print newline character to file
end

fclose(fileID);
