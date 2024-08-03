function deltaP = deltaPFromFlowrateErgun(Q, mu, rho, epsilon, dp, Dc, L)
% Calculate the pressure drop through a packed bed using the Ergun equation.
%
% deltaP/L = 150*mu/dp^2 * (1-epsilon)^2/epsilon^3*u0 + 1.75*rho/dp * (1-epsilon)/epsilon^3*u0^2
% 
% Arguments
%   Q : Flowrate in m3/s.
%   mu : Fluid viscosity in Pa s.
%   rho : Fluid density in kg/m3.
%   epsilon : Porosity.
%   dp : Particle diameter in m.
%   Dc : Bed internal diameter in m.
%   L : Bed length in m.
%
% Returns
%   Pressure drop through the bed in Pa.
% 
% References
%   https://en.wikipedia.org/wiki/Ergun_equation

A = pi() * Dc^2 / 4;  % m2, cross-section area
u0 = Q / A;  % m/s, superficial velocity

deltaP = L * ( 150*mu/dp^2 * (1-epsilon)^2/epsilon^3*u0 + 1.75*rho/dp * (1-epsilon)/epsilon^3*u0^2 );
end

