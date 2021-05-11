% function that returns a containers.Map (equivalent hashtable or dictionnary) such that ind('name') is equal to the position of 'name' in ordre
function ind = getIndex(ordre)
	ind = containers.Map;
	n = length(ordre);
	
	for i = 1:n
		ind(ordre{i}) = i;
	end
end
