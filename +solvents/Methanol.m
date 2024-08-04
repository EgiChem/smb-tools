classdef Methanol
    % Properties of methanol
    
    properties(Constant = true)
        % Molar mass
        molarmass = 32.04;  % g/mol

        % Viscosity
        % Refference: Dortmund Data Bank (DDB) - Vogel Equation
        viscosity20C = 0.570928e-3;  % Pa s
        viscosity25C = 0.526483e-3;  % Pa s

        % Density
        % Refference: Dortmund Data Bank (DDB) - DIPPR105 Equation
        density20C = 792.344;  % kg/m3
        density25C = 787.727;  % kg/m3
    end

    methods(Static)
        function visc = calcViscosityVogel(T)
            % Calculate viscosity of methanol using Vogel Equation.
            %
            % visc = e^(A + B/(C + T)) 
            % where T in K and visc in mPa s. Valid from 183 K to 463 K.
            % 
            % Arguments
            %   T : temperature in K.
            %
            % Returns
            %   Viscosity in Pa s.
            % 
            % References
            %   Dortmund Data Bank (DDB)
            %   (http://ddbonline.ddbst.de/VogelCalculation/VogelCalculationCGI.exe).

            if T < 183 || T > 463
                warning('Temperature is outside the equation validity range: 183 < T < 463 K.')
            end

            A = -6.7562;
         	B = 2337.24;
            C = 84.0853;
            visc = exp( A + B/(C + T) );  % viscosity in mPa s
            visc = visc * 0.001;  % viscosity in Pa s
        end

        function dens = calcDensityDIPPR105(T)
            % Calculate density of methanol using DIPPR105 Equation.
            %
            % dens = A / ( B^(1 + (1-T/C)^D ) ) 
            % where T in K and dens in kg/m3. Valid from 181 K to 513 K.
            % 
            % Arguments
            %   T : temperature in K.
            %
            % Returns
            %   Density in kg/m3.
            % 
            % References
            %   Dortmund Data Bank (DDB) (http://ddbonline.ddbst.com/DIPPR105DensityCalculation/DIPPR105CalculationCGI.exe).

            if T < 181 || T > 513
                warning('Temperature is outside the equation validity range: 181 < T < 513 K.')
            end

            A = 54.566;
         	B = 0.233211;
            C = 513.16;
            D = 0.208875;
            dens = A / ( B^(1 + (1-T/C)^D ) ) ;  % density in kg/m3
        end
    end
end
