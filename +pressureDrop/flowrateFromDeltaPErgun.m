function Q = flowrateFromDeltaPErgun(deltaP, mu, rho, epsilon, dp, Dc, L)
% Calculate the maximum allowed flowrate for a given pressure drop using the Ergun equation.
%
% deltaP/L = 150*mu/dp^2 * (1-epsilon)^2/epsilon^3*u0 + 1.75*rho/dp * (1-epsilon)/epsilon^3*u0^2
% 
% Arguments
%   deltaP : Pressure drop through the bed in Pa.
%   mu : Fluid viscosity in Pa s.
%   rho : Fluid density in kg/m3.
%   epsilon : Porosity.
%   dp : Particle diameter in m.
%   Dc : Bed internal diameter in m.
%   L : Bed length in m.
%
% Returns
%   Flowrate in m3/s.
% 
% References
%   https://en.wikipedia.org/wiki/Ergun_equation

coeffs = [
    1.75*rho/dp * (1-epsilon)/epsilon^3;
    150*mu/dp^2 * (1-epsilon)^2/epsilon^3;
    -deltaP / L
];  % coefficients of the quadratic equation obtained from solving Ergun Eq. for u0
u0 = max( roots(coeffs) );  % m/s, superficial velocity
A = pi() * Dc^2 / 4;  % m2, cross-section area
Q = u0 * A;
end