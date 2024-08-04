function visc = viscMixingRuleArrhenius(T, v1, solvent1, v2, solvent2)
% Calculate the viscosity of a binary mixture using Arrhenius mixing rule.
% 
% mu = mu1^x1 + m2^x2
% where mu is the viscosity, and x are the mole fractions.
% 
% Arguments
%   T : Temperature in K.
%   v1 : Volume fraction of solvent 1 in v/v.
%   solvent1 : Solvent 1. Must be a solvent class (e.g., solvents.Methanol).
%   v2 : Volume fraction of solvent 2 in v/v.
%   solvent2 : Solvent 2. Must be a solvent class (e.g., solvents.Methanol).
%
% Returns
%   Mixture viscosity in Pa s.

% Pure component viscosities
visc1 = solvent1.calcViscosityVogel(T);
visc2 = solvent2.calcViscosityVogel(T);

% Pure component densities
dens1 = solvent1.calcDensityDIPPR105(T);
dens2 = solvent2.calcDensityDIPPR105(T);

% Moles
n1 = v1 * dens1 / solvent1.molarmass;
n2 = v2 * dens2 / solvent2.molarmass;
ntotal = n1 + n2;

% Molar fractions
x1 = n1 / ntotal;
x2 = n2 / ntotal;

% Mixing rule
visc = visc1^x1 + visc2^x2;
end

