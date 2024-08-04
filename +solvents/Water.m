classdef Water
    % Properties of water
    
    properties(Constant = true)
        % Molar mass
        molarmass = 18.01528;  % g/mol

        % Viscosity
        % Dortmund Data Bank (DDB) - Vogel Equation
        viscosity20C = 1.00166e-3;  % Pa s
        viscosity25C = 0.892112e-3;  % Pa s

        % Density
        % DIPPR105 Equation
        density20C = 1002.09;  % kg/m3
        density25C = 998.946;  % kg/m3
    end

    methods(Static)
        function visc = calcViscosityVogel(T)
            % Calculate viscosity of water using Vogel Equation.
            %
            % visc = e^(A + B/(C + T)) 
            % where T in K and visc in mPa s. Valid from 273 K to 373 K.
            % 
            % Arguments
            %   T : temperature in K.
            %
            % Returns
            %   Viscosity in Pa s.
            % 
            % References
            %   Dortmund Data Bank (DDB) (http://ddbonline.ddbst.de/VogelCalculation/VogelCalculationCGI.exe).

            if T < 273 || T > 373
                warning('Temperature is outside the equation validity range: 273 < T < 373 K.')
            end

            A = -3.7188;
         	B = 578.919;
            C = -137.546;
            visc = exp( A + B/(C + T) );  % viscosity in mPa s
            visc = visc * 0.001;  % viscosity in Pa s
        end

        function dens = calcDensityDIPPR105(T)
            % Calculate density of water using DIPPR105 Equation.
            %
            % dens = A / ( B^(1 + (1-T/C)^D ) ) 
            % where T in K and dens in kg/m3. Valid from 273 K to 648 K.
            % 
            % Arguments
            %   T : temperature in K.
            %
            % Returns
            %   Density in kg/m3.
            % 
            % References
            %   Dortmund Data Bank (DDB) (http://ddbonline.ddbst.com/DIPPR105DensityCalculation/DIPPR105CalculationCGI.exe).

            if T < 273 || T > 648
                warning('Temperature is outside the equation validity range: 273 < T < 648 K.')
            end

            A = 0.14395;
         	B = 0.0112;
            C = 649.727;
            D = 0.05107;
            dens = A / ( B^(1 + (1-T/C)^D ) ) ;  % density in kg/m3
        end
    end
end