function [unknown_sol, all_flowrates] = flowrates(known_flowrates)
% Calculate SMB flowrates by mass balance.
% 
% Input four known flowrates and the function returns the four remaining
% unknown flowrates. Input must be a structure with four fields. Possible
% fieldnames are 'Q1', 'Q2', 'Q3', 'Q4', 'QE', 'QX', 'QF', 'QR'. 
% 
% Returns a structure of four fields corresponding to the solution of the
% unknown flowrates.
%
% Example:
% fr.QE = 2;
% fr.QF = 1;
% fr.QX = 1.5;
% fr.Q1 = 3;
% flowrates(fr)

% Get list of know and unknown variables
all_vars = {'Q1'; 'Q2'; 'Q3'; 'Q4'; 'QE'; 'QX'; 'QF'; 'QR'};
known_vars = fieldnames(known_flowrates);
unknown_vars = setdiff(all_vars, known_vars);

% Create and assign variables for the known flowrates, e.g., Q1 = 5
for i = 1:numel(known_vars)
    known_var_name = known_vars{i};  % Get the field name
    known_var_value = known_flowrates.(known_var_name);  % Get the field value
    eval([known_var_name, ' = ', num2str(known_var_value), ';']);
end

% Set unknown variables as symbolic variables, e.g., Q2 = sym('Q2')
for i = 1:numel(unknown_vars)
    unknown_var_name = unknown_vars{i};  % Get the field name
    sym_var = sym(unknown_var_name);  % Create a symbolic variable
    eval([unknown_var_name, ' = sym_var;'])  % Set the correct variable name
end

% Create system of equations containing the mass balance
eq1 = Q1 - QX == Q2;
eq2 = Q2 + QF == Q3;
eq3 = Q3 - QR == Q4;
eq4 = Q4 + QE == Q1;
eqs = [eq1, eq2, eq3, eq4];

% Solve the system for the unknowns
sym_sol = solve(eqs, unknown_vars);

unknown_sol = convertSymToDouble(sym_sol);

% Create a sturcture with all flowrates
all_flowrates = known_flowrates;
for i = 1:numel(unknown_vars)
    field_name = unknown_vars{i};
    all_flowrates.(field_name) = unknown_sol.(field_name);
end




function double_struct = convertSymToDouble(sym_struct)
% Initialize an empty struct for the result
double_struct = struct();

% Get the field names of the input structure
fields = fieldnames(sym_struct);

% Loop through each field and convert the symbolic value to double
for i = 1:numel(fields)
    field_name = fields{i};
    
    % Convert symbolic field value to double and store in the new struct
    double_struct.(field_name) = double(sym_struct.(field_name));
end
