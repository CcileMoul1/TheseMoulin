% functions that returns Michaelis Menten ratio : c /(c+k).
% where k is the Michaelis constant
% and c is the concentration, or a vector of concentrations
function x = mm(c,k)
	x = c./(c+k);
end
