function [t,x,fluxes,dxdts] = solveODE_long(x0,tf,optionsode,solve,equadiff,getFlux)	
	% Definition of the interval
	interval = tf;
    if(length(tf)==1)
        interval = [0 tf];
    end
    
    % Solving the ode   
    [t x] = solve(equadiff,interval,x0,optionsode);
    % Finding for each time what are the reaction rates...
    fluxes = allFluxes(getFlux,t,x');
    %... the variations of x
    dxdts = myApplyFun(equadiff,t,x,1);    
end