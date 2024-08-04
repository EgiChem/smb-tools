classdef Ethanol
    % Properties of ethanol
    
    properties(Constant = true)
        % Molar mass
        molarmass = 46.068;  % g/mol

        % Viscosity
        % Refference: Dortmund Data Bank (DDB) - Vogel Equation
        viscosity20C = 1.17339e-3;  % Pa s
        viscosity25C = 1.06067e-3;  % Pa s

        % Density
        % Refference: Dortmund Data Bank (DDB) - DIPPR105 Equation
        density20C = 788.886;  % kg/m3
        density25C = 783.924;  % kg/m3

    end

    methods(Static)
        function visc = calcViscosity(T)
            % Calculate viscosity of liquid ethanol.
            %
            % ln(visc) = A + B/T + C*T + D*T^2 
            % where T in K and visc in cP. Valid from 168.15 K to 516.15 K.
            % 
            % Arguments
            %   T : temperature in K.
            %
            % Returns
            %   Viscosity in Pa s.
            % 
            % References
            %   "Pure Component Properties". Chemical Engineering Research Information Center. 
            %   https://www.cheric.org/research/kdb/hcprop/showprop.php?cmpid=818
            
            arguments
                T (1,1) double
            end

            if T < 168.15 || T > 516.15
                warning('Temperature is outside the equation validity range: 168.15 < T < 516.15 K.')
            end
            
            A = -6.21;
            B = 1614;
            C = .00618;
            D = -1.132e-05;
            visc = exp( A + B/T + C*T + D*T^2 );  % viscosity in cP
            visc = visc * 0.001;  % viscosity in Pa s
        end

        
        function dens = calcDensity(T)
            % Calculate density of liquid ethanol.
            %
            % density [g/cm3] = −8.461834×10−4 T [°C] + 0.8063372
            % where T in °C and density in g/cm3.
            % 
            % Arguments
            %   T : temperature in K.
            %
            % Returns
            %   Density in kg/m3.
            % 
            % References
            %   Lange, Norbert Adolph (1967). John Aurie Dean (ed.). Lange's Handbook of Chemistry (10th ed.). McGraw-Hill.
            
            arguments
                T (1,1) double
            end

            dens = -8.461834e-4 * (T - 273.15) + 0.8063372;  % density in g/cm3
            dens = dens * 1000;  % density in kg/m3
        end

        function visc = calcViscosityVogel(T)
            % Calculate viscosity of ethanol using Vogel Equation.
            %
            % visc = e^(A + B/(C + T)) 
            % where T in K and visc in mPa s. Valid from 159 K to 516 K.
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

            if T < 159 || T > 516
                warning('Temperature is outside the equation validity range: 159 < T < 516 K.')
            end

            A = -7.37146;
         	B = 2770.25;
            C = 74.6787;
            visc = exp( A + B/(C + T) );  % viscosity in mPa s
            visc = visc * 0.001;  % viscosity in Pa s
        end

        function dens = calcDensityDIPPR105(T)
            % Calculate density of ethanol using DIPPR105 Equation.
            %
            % dens = A / ( B^(1 + (1-T/C)^D ) ) 
            % where T in K and dens in kg/m3. Valid from 191 K to 513 K.
            % 
            % Arguments
            %   T : temperature in K.
            %
            % Returns
            %   Density in kg/m3.
            % 
            % References
            %   Dortmund Data Bank (DDB) (http://ddbonline.ddbst.com/DIPPR105DensityCalculation/DIPPR105CalculationCGI.exe).

            if T < 191 || T > 513
                warning('Temperature is outside the equation validity range: 191 < T < 513 K.')
            end

            A = 99.3974;
         	B = 0.310729;
            C = 513.18;
            D = 0.305143;
            dens = A / ( B^(1 + (1-T/C)^D ) ) ;  % density in kg/m3
        end
    end
end