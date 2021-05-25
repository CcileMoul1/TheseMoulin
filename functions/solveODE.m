function [t,x,fluxes,dxdts] = solveODE(x0,param,order,tf)

	% /!\ Define your options here
	optionsode = odeset();
	
	% /!\ Define your solver
	solve = @(system_function,interval,x0) ode15s(system_function,interval,x0,optionsode);
	
	% /!\ Define the default system you want to solve
	
	equadiff = @(t,x) systeme(t,x,param,order);
	getFlux = @(t,x) flux(t,x,param,order);
	
	% Definition of the interval
	interval = tf;
    if(length(tf)==1)
        interval = [0 tf];
    end
    
    % Solving the ode   
    [t x] = solve(equadiff,interval,x0);
    % Finding for each time what are the reaction rates...
    fluxes = allFluxes(getFlux,t,x');
    %... the variations of x
    dxdts = myApplyFun(equadiff,t,x,1);    
end
