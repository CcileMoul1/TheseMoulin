% Transforms a map container into a matrix and returns this matrix with the list of keys. We suppose that every values of the map is a vector of the same size.
% If a list of names is given (ordre_name), the matrix will be built according to this list : ordre_name imposes its order and its size. Warning every element of ordre_name has to be a key of the map.

function [names, matrice] = mapToMatrix(map,ordre_name)
	names = keys(map);
	if nargin==2
		names = ordre_name;
	end
	n = length(names);
		
	matrice = [];
	
	for i = 1:n
		matrice = [matrice ; map(names{i})];
	end

end
