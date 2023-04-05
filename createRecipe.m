% Create a SMB recipe file to use in the SMB control program.

%% INPUTS
filename = 'recipe';
columns = 4;
tsw = 1;
Cor = 1.5; 
P1 = 2; 
P2 = 1.5; 
P3 = 1; 
P4 = 1;


%% Checks
if ~ismember(columns, [4 8])
    error('Number of columns is not supported.')
end


%% Create recipe
valv_pos_8cols = {'6;7;0;1;2;3;4;5';
                  '5;6;7;0;1;2;3;4';
                  '4;5;6;7;0;1;2;3';
                  '3;4;5;6;7;0;1;2';
                  '2;3;4;5;6;7;0;1';
                  '1;2;3;4;5;6;7;0';
                  '0;1;2;3;4;5;6;7';
                  '7;0;1;2;3;4;5;6'};
              
valv_pos_4cols = {'6;1;0;1;2;1;4;1';
                  '4;1;6;1;0;1;2;1';
                  '2;1;4;1;6;1;0;1';
                  '0;1;2;1;4;1;6;1'};
        
fileID = fopen(strcat(filename,'.txt'),'w');  % open text file

% Each line (recipe_line) format is:  tsw; Cor; P1; P2; P3; P4; VA; VB; VC; VD; VE; VF; VG; VH
for i=1:columns
    if columns == 4
        recipe_line = sprintf('%.2f;%.2f;%.2f;%.2f;%.2f;%.2f;%s',tsw,Cor,P1,P2,P3,P4,valv_pos_4cols{i});  % create a string for the current line (switch)
    elseif columns == 8
        recipe_line = sprintf('%.2f;%.2f;%.2f;%.2f;%.2f;%.2f;%s',tsw,Cor,P1,P2,P3,P4,valv_pos_8cols{i});  % create a string for the current line (switch)
    end
    recipe_line = strrep(recipe_line,'.',',');  % replace '.' by ','
    fprintf(fileID,'%s',recipe_line);  % print string to file
    fprintf(fileID,'\r\n');  % print newline character to file
end

fclose(fileID);
