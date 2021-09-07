function createRecipe()

%% INPUTS
filename = 'recipe2';
tsw = 1;
Cor = 1.5; 
P1 = 2; 
P2 = 1.5; 
P3 = 1; 
P4 = 1;


%% CREATE RECIPE FILE
valv_pos = {'4;5;6;7;0;1;2;3';
            '5;6;7;0;1;2;3;4';
            '6;7;0;1;2;3;4;5';
            '7;0;1;2;3;4;5;6';
            '0;1;2;3;4;5;6;7';
            '1;2;3;4;5;6;7;0';
            '2;3;4;5;6;7;0;1';
            '3;4;5;6;7;0;1;2'};
        
fileID = fopen(strcat(filename,'.txt'),'a');  % open text file

% Each line (recipe_line) format is:  tsw; Cor; P1; P2; P3; P4; VA; VB; VC; VD; VE; VF; VG; VH
for i=1:8
    recipe_line = sprintf('%.2f;%.2f;%.2f;%.2f;%.2f;%.2f;%s',tsw,Cor,P1,P2,P3,P4,valv_pos{i});  % create a string for the current line (switch)
    recipe_line = strrep(recipe_line,'.',',');  % replace '.' by ','
    fprintf(fileID,'%s',recipe_line);  % print string to file
    fprintf(fileID,'\r\n');  % print newline character to file
end

fclose(fileID);
