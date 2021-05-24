%fonction qui a partir d'une fonction qui retourne des flux et d'une matrice de concentration retourne un dictionnaire qui pour chaque réaction contient le vecteur des flux
function fluxes = allFluxes(getFlux,t,x)
	fluxes = containers.Map;
	%Initialisation. As we have to do it to get the reactions, we do it on the initial time.
	flux = getFlux(t(1),x(:,1));
	keySet = keys(flux);
	nk = length(keySet);
	
	for i = 1:nk
		key = keySet{i};
		fluxes(key) = [flux(key)];
	end
	%For the other element of t
	nt = length(t);
	for i = 2:nt
		flux = getFlux(t(i),x(:,i));
		for j = 1 : nk
			key = keySet{j};
			fluxes(key) = [fluxes(key) flux(key)];
		end
	end
	
end
