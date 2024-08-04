function dens = densMixingRuleIdeal(T, v1, solvent1, v2, solvent2)
% Calculate the density of a binary mixture.
% 
% rho_mix = 1 / ( v1/rho1 + v2/rho2 )
% where rho is the density, and v are the volume fractions.
% 
% Note this mixing rule assumes ideal mixing and no volume change upon mixing.
% 
% Arguments
%   T : Temperature in K.
%   v1 : Volume fraction of solvent 1 in v/v.
%   solvent1 : Solvent 1. Must be a solvent class (e.g., solvents.Methanol).
%   v2 : Volume fraction of solvent 2 in v/v.
%   solvent2 : Solvent 2. Must be a solvent class (e.g., solvents.Methanol).
%
% Returns
%   Mixture density in kg/m3.

% Pure component densities
dens1 = solvent1.calcDensityDIPPR105(T);
dens2 = solvent2.calcDensityDIPPR105(T);

% Mixing rule
dens = 1 / ( v1/dens1 + v2/dens2 );
end

