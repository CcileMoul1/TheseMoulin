%fonction qui a partir d'une fonction qui retourne des flux et d'une matrice de concentration retourne un dictionnaire qui pour chaque réaction contient le vecteur des flux
%Params et ordre sont à donner dans getFlux (même façon que pour les paramètres avec ode)
function fluxes = allFluxes(getFlux,t,x)
	fluxes = containers.Map;
	%On initialise. Comme on doit le faire une fois pour avoir les réactions, autant déjà récupérer les premières valeurs
	flux = getFlux(t(1),x(:,1));
	keySet = keys(flux);
	nk = length(keySet);
	
	for i = 1:nk
		key = keySet{i};
		fluxes(key) = [flux(key)];
	end
% 	keyboard
	%On fait pour les autres temps
	nt = length(t);
	for i = 2:nt
%         keyboard
		flux = getFlux(t(i),x(:,i));
		for j = 1 : nk
			key = keySet{j};
			fluxes(key) = [fluxes(key) flux(key)];
		end
	end
	
end
