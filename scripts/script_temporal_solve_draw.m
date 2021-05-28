% Script to run a simulation and draw every variables and reaction rates
% the files are supposed to be in the path (addpat or pathdef)

% Loading the parameters and the initial conditions
load param.mat
load ci.mat

% Get the order
order = getOrder();

% Integration time
tf = 100;

% Running the simulation
[t,x,fluxes,dxdts] = solveODE(ciZero,param,order,tf);

% Drawing every variables
drawMatrix(t,x,order,'-b');

% Drawing every reaction rates
[reactions fluxesM] = mapToMatrix(fluxes);
% WARNING transpose the matrix
fluxesM = fluxesM';
drawMatrix(t,fluxesM,reactions,'-r');
