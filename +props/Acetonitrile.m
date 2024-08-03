classdef Acetonitrile
    % Properties of acetonitrile
    
    properties(Constant = true)
        % Molar mass
        molarmass = 41.05;  % g/mol

        % Viscosity
        % Refference: Dortmund Data Bank (DDB) - Vogel Equation
        viscosity20C = 0.361646e-3;  % Pa s
        viscosity25C = 0.344449e-3;  % Pa s

        % Density
        % Refference: Dortmund Data Bank (DDB) - DIPPR105 Equation
        density20C = 784.422;  % kg/m3
        density25C = 778.933;  % kg/m3
    end

    methods(Static)
        function visc = calcViscosityVogel(T)
            % Calculate viscosity of acetonitrile using Vogel Equation.
            %
            % visc = e^(A + B/(C + T)) 
            % where T in K and visc in mPa s. Valid from 233 K to 373 K.
            % 
            % Arguments
            %   T : temperature in K.
            %
            % Returns
            %   Viscosity in Pa s.
            % 
            % References
            %   Dortmund Data Bank (DDB) (http://ddbonline.ddbst.de/VogelCalculation/VogelCalculationCGI.exe).

            if T < 233 || T > 373
                warning('Temperature is outside the equation validity range: 233 < T < 373 K.')
            end

            A = -3.15868;
         	B = 459.982;
            C = -78.3648;
            visc = exp( A + B/(C + T) );  % viscosity in mPa s
            visc = visc * 0.001;  % viscosity in Pa s
        end

        function dens = calcDensityDIPPR105(T)
            % Calculate density of acetonitrile using DIPPR105 Equation.
            %
            % dens = A / ( B^(1 + (1-T/C)^D ) ) 
            % where T in K and dens in kg/m3. Valid from 253 K to 547 K.
            % 
            % Arguments
            %   T : temperature in K.
            %
            % Returns
            %   Density in kg/m3.
            % 
            % References
            %   Dortmund Data Bank (DDB) (http://ddbonline.ddbst.com/DIPPR105DensityCalculation/DIPPR105CalculationCGI.exe).

            if T < 253 || T > 547
                warning('Temperature is outside the equation validity range: 253 < T < 547 K.')
            end

            A = 76.9138;
         	B = 0.267818;
            C = 547.85;
            D = 0.353687;
            dens = A / ( B^(1 + (1-T/C)^D ) ) ;  % density in kg/m3
        end
    end
end