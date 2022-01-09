(Repository in progress)
# TheseMoulin
Scripts and models used in my PhD thesis: [Metabolic network analysis during the cell cycle : application to the cancer metabolism](http://www.theses.fr/2020UPASG022). The manuscript is available in French [here](https://tel.archives-ouvertes.fr/tel-03164566).

The hybrid automaton is an upgraded version of the one described in my article [Using a Hybrid Approach to Model Central Carbon Metabolism Across the Cell Cycle, Moulin et al. 2019](https://link.springer.com/chapter/10.1007/978-3-030-28042-0_9).

:exclamation: Disclaimer: the codes here have been written progressively, each features added when needed. So it's probably not optimal but it works.

## Installation
First use: (1. and 2. can be inversed)
1. Launch Matlab 
2. Go to this folder
3. run ```initiate_path``` to create a [```pathdef.m```](https://fr.mathworks.com/help/matlab/ref/savepath.html) file
4. You can run every scripts or functions

Other uses: (the order is important for Matlab to find the pathdef file)
1. Go to this folder
2. Lauch Matlab
3. You can run every scripts or functions


## add-ons
Other files that may help to understand the models

### [differential_system.md](https://github.com/CcileMoul1/TheseMoulin/blob/main/differential_system.md)
In this file, I describe how I build a differential system to study the growth and the metabolic behvior of a population of cells inside a reactor. This system is adaptable to different kind of reactors. In my thesis I assumed the cell population to be in a batch reactor where the extracellular metabolite concentrations are constant.

### [```initiate_path.m```](https://github.com/CcileMoul1/TheseMoulin/blob/main/initiate_pathdef.m)

Add to the path all the folders and then create [```pathdef.m```](https://fr.mathworks.com/help/matlab/ref/savepath.html) file to save this configuration.

[//]: # (Commentaire de séparation)

## [functions](https://github.com/CcileMoul1/TheseMoulin/tree/main/functions)
All the functions or procedures to make the code works but not specific to the models.

### [```activation.m```](https://github.com/CcileMoul1/TheseMoulin/blob/main/functions/activation.m)
:warning: this function is needed by the models themself.

Returns the Michaelis-Menten ratio of an activated reaction (non-essential activation model by [Segel](https://www.google.com/search?q=ISBN+978-0-471-30309-1&client=ubuntu&hs=fOB&ei=JoaaYI2uEJuHjLsPoMi_mA0&oq=ISBN+978-0-471-30309-1&gs_lcp=Cgdnd3Mtd2l6EANQ_yhYsDdgzj1oAXAAeACAATyIAcoCkgEBNpgBAKABAaoBB2d3cy13aXrAAQE&sclient=gws-wiz&ved=0ahUKEwiN2dXL3cHwAhWbA2MBHSDkD9MQ4dUDCA4&uact=5)): 

![formula](https://render.githubusercontent.com/render/math?math=\frac{(1%2B\frac{\beta{}}{\alpha{}K_a}A)S}{(1%2B\frac{1}{K_a}A)K_m%2B(1%2B\frac{1}{\alpha{}K_a}A)S})

#### Usage
```v = activation(S,A,Km,Ka,alpha,beta);```

```v``` is a vector of the same size as S and A containing the activated Michaelis-Menten ratio.
The parameters of this function are:
* ```S``` a vector containing the concentrations of the substrate
* ```A``` a vector containing the concentrations of the activator. :exclamation: ```A``` and ```S``` should have the same length.
* ```Km``` is the dissociation constant of the enzyme-substrate complex but could also be its Michaelis constant (these two values are often confounded) :exclamation: same unit as ```S```
* ```Ka``` is the dissociation constant of the enzyme-activator complex, also known as activation constant :exclamation: same unit as ```A```
* ```alpha``` and ```beta``` are two constants of the activation :exclamation: without unit


### [```allFluxes.m```](https://github.com/CcileMoul1/TheseMoulin/blob/main/functions/allFluxes.m)
:warning: this function is needed by solveODE and solveODE_long.

This function is thought to get all the reaction rates of a simulation (for every time) from a system similar to those I present here ie with a function that returns the reaction rates at time t as a [Map Container](https://fr.mathworks.com/help/matlab/map-containers.html). The description bellow corresponds to this point of view but this function could be used differently.

#### Usage
```fluxes = allFluxes(getFlux,T,X);```


The parameters of this function are:
* ```getFlux``` is a [function handle](https://fr.mathworks.com/help/matlab/matlab_prog/creating-a-function-handle.html) that uses two parameters (the function handle uses two parameters. The initial function could use more than two parameters): a positive real number t corresponding to a time and a vector x (with m elements) corresponding to the state of the system. This function returns a Map Container with the reaction rates calculated at time t and according to the vector x. It should be similar to ```flux.m``` (```param``` and ```order``` should be given in the handle. See the example).
* ```T``` is a time vector of n elements
* ```X``` is a matrix of m rows and n columns. Each column correspond to a state of the system.

```fluxes``` is a Map Container containing the same keys as the Map Container returned by ```getFlux```. When ```getFlux``` returns one element for each reaction rate (at time t, corresponding to the state x), ```fluxes``` contains the reaction rates for each time of ```T``` and the corresponding state vector of ```X```. ```fluxes(reactionName)``` is a vector such that the ith element is the reaction rate of ```reactionName``` for ```getFlux(T(i),X(:,i))```.

#### Example
```MATLAB
[T X] = ode(...) % Integration of a differential system 
fluxes = allFluxes(@(t,x) flux(t,x,param,order),T,X); %param and order are defined before
```
To have a better example, see ```solveODE.m``` and ```solveODE_long.m```.

### drawMatrix procedures

Procedures to draw curves from matrices.
All of these procedures are based on ```drawMatrix.m```.

#### [```drawMatrix.m```](https://github.com/CcileMoul1/TheseMoulin/blob/main/functions/drawMatrix.m)

Draw curves from one matrice.

##### Usage
```drawMatrix(t,x,names,color);```

* ```t``` is a vector of n elements. It is used as the abscissa vector,
* ```x``` is a matrice of n rows and m colums. Each row is used as the ordinate vector,
* ```names``` is a cell array of m strings,
* ```color``` is a string that could describe the color, the type of line, the symbol used to draw the curves. These information are used for each curves. (examples for ```color``` : ```-```, ```*```, ```-dc```...)

This procedure creates as many figures as needed. On each figure, there are 12 subplots (4 rows and 3 columns) maximum. On each of the m subplots, the curve ```(t,x(:,i))``` is drawn and its title is ```names{i}```.
By default, the drawing function is ```plot``` (linear axis) and the ```LineWidth``` is 2.

#### [```drawMatrix2.m```](https://github.com/CcileMoul1/TheseMoulin/blob/main/functions/drawMatrix2.m)

Draw curves from two matrices.

##### Usage
```drawMatrix2(t,x,t2,x2,names,color1,color2)```

* ```t``` and ```t2``` are vectors of n1 and n2 elements. They are used as the abscissa vectors,
* ```x``` and ```x2``` are matrices of n1 and n2 rows and m colums. Each row is used as the ordinate vector,
* ```names``` is a cell array of m strings,
* ```color``` and ```color2``` are strings that could describe the color, the type of line, the symbol used to draw the curves. ```color``` is used for ```(t,x)``` curves, ```color2``` for ```(t2,x2)```

Similar to ```drawMatrix``` but on each subplot, two curves are drawn : ```(t,(x(:,i))``` with ```color``` and ```(t2,x2(:,i))``` with ```color2```.

#### [```drawMatrix3.m```](https://github.com/CcileMoul1/TheseMoulin/blob/main/functions/drawMatrix3.m)

Similar to ```drawMatrix2.m``` but with 3 curves: ```drawMatrix3(t,x,t2,x2,t3,x3,names,color1,color2,color3)```

#### [```drawMatrix_.m```](https://github.com/CcileMoul1/TheseMoulin/blob/main/functions/drawMatrix_.m)

Draw curves for r matrices.

##### Usage
```drawMatrix_(ts,xs,names,colors)```

* ```ts``` is a cell array containing r vectors used as abscissa vectors,
* ```xs``` is a cell array containing r matrices of m columns. The number of rows of the matrice ```xs{i}``` is the number of element of the vector ```ts{i}```
* ```names``` is a cell array of m strings,
* ```colors``` is a cell array containing r strings.

Similar to ```drawMatrix```. On each subplot, r curves are drawn.

### [fullscreen.m](https://github.com/CcileMoul1/TheseMoulin/blob/main/functions/fullscreen.m)
:warning: this procedure is used in scripts

Procedure to put into fullscreen every open figure.


### [```getIndex.m```](https://github.com/CcileMoul1/TheseMoulin/blob/main/functions/getIndex.m)
:warning: this function is needed by the models themself

Returns a structure (a [Map Container](https://fr.mathworks.com/help/matlab/map-containers.html)) to get all the index position of the element in a list of strings (a [Cell Array of string](https://fr.mathworks.com/help/matlab/matlab_prog/cell-arrays-of-strings.html)).

This function allows us to externalise the management of the variables' order in differential systems.

#### Usage
```index = getIndex(order);```

```index``` is a Map Container such that ```index(name)``` is equal to the index position of ```name``` in the Cell Array ```order```.
In other words: for ```i``` in ```[1,length(order)]```, ```index(order{i})``` is equal to ```i```.

### [```inhibition.m```](https://github.com/CcileMoul1/TheseMoulin/blob/main/functions/inhibition.m)
:warning: this function is needed by the models themself

Returns the ratio that changes the reaction rate due to an inhibition. Let the reaction rate of a reaction be ![formula](https://render.githubusercontent.com/render/math?math=\nu{}) when there is no inhibition and ![formula](https://render.githubusercontent.com/render/math?math=\nu{}i) when the reaction is inhibited. Then ```inhibition.m``` returns ![formula](https://render.githubusercontent.com/render/math?math=i) which is the non-competitive inhibition model described by [Segel](https://www.google.com/search?q=ISBN+978-0-471-30309-1&client=ubuntu&hs=fOB&ei=JoaaYI2uEJuHjLsPoMi_mA0&oq=ISBN+978-0-471-30309-1&gs_lcp=Cgdnd3Mtd2l6EANQ_yhYsDdgzj1oAXAAeACAATyIAcoCkgEBNpgBAKABAaoBB2d3cy13aXrAAQE&sclient=gws-wiz&ved=0ahUKEwiN2dXL3cHwAhWbA2MBHSDkD9MQ4dUDCA4&uact=5):

![formula](https://render.githubusercontent.com/render/math?math=\frac{K_i}{K_i%2BI})

#### Usage
```v = inhibition(I,Ki);```

```v``` is a vector of the same size as I containing the inhibition ratio.
The parameters of this function are:
* ```I``` a vector containing the concentrations of the inhibitor
* ```Ki``` is the inhibition constant :exclamation: same unit as ```I```


### [```mapToMatrix.m```](https://github.com/CcileMoul1/TheseMoulin/blob/main/functions/mapToMatrix.m)
:warning: this function is used in scripts

Transform a [Map Container](https://fr.mathworks.com/help/matlab/map-containers.html) into a matrix.

#### Usage
```[names, matrice] = mapToMatrix(map,ordre_name);```

* ```map``` is a Map Container where each value is a row vector of size n containing numbers,
* ```ordre_name``` is an optional parameter. It is a subset of ```keys(map)``` and it fixes the order and the content of ```matrice```
* ```names``` is either ```ordre_name``` when this parameter is given or ```keys(map)``` when ```ordre_name``` is not given,
* ```matrice``` is  matrice of n columns and as many rows as there are elements in ```name```. For every i from 1 to the length of ```name```, ```matrice(i,:)=map(ordre_name{i});```



### [```mm.m```](https://github.com/CcileMoul1/TheseMoulin/blob/main/functions/mm.m)
:warning: this function is needed by the models themself

Returns the Michaelis-Menten ratio without the ![formula](https://render.githubusercontent.com/render/math?math=k_{cat}E) product or ![formula](https://render.githubusercontent.com/render/math?math=\nu_{max}):

![formula](https://render.githubusercontent.com/render/math?math=\frac{S}{S%2BK_m})

#### Usage
```v = mm(S,Km);```

```v``` is a vector of the same size as S containing the Michaelis-Menten ratio.
The parameters of this function are:
* ```S``` a vector containing the concentrations of the substrate
* ```Km``` is the Michaelis constant of the reaction :exclamation: same unit as ```S```

### [```myApplyFun.m```](https://github.com/CcileMoul1/TheseMoulin/blob/main/functions/myApplyFun.m)
:warning: this function is needed by solveODE and solveODE_long.

This function is thought to replace [```arrayfun```](https://fr.mathworks.com/help/matlab/ref/arrayfun.html). It applies the function given in parameter on every element of (T(i),X(:,i)) or (T(i),X(i,:)).

#### Usage
```res = myApplyFun(fun,T,X,dim);```

* ```fun``` is a [function handle](https://fr.mathworks.com/help/matlab/matlab_prog/creating-a-function-handle.html) that uses two parameters (the function handle uses two parameters. The initial function could use more than two parameters): a positive real number t and a vector x (with m elements). This function returns a **column** vector of size r (r could be 1).
* ```T``` is a vector of n elements
* ```X``` is a matrix of m rows and n columns or n rows and m columns.
* ```dim``` indicates on which dimension of the matrix ```X``` we want to apply the function: 1 for the rows ```(T(i),X(i,:))```, 2 or another value for the columns ```(T(i),X(:,i))```.
* ```res``` is a matrix containing the results of the application of ```fun``` on ```T``` and ```X```. This matrix has n rows and r columns or r rows and n columns.

When ```dim==1```, ```X``` has n rows and m columns. ```fun``` is then applied to ```(T(i),X(i,:))``` (for i in [1,n]) and ```res``` is a matrix with n rows and r columns. To sum up: ```res(i,:) = fun(T(i),X(i,:))```
When ```dim~=1```, ```X``` has m rows and n columns. ```fun``` is then applied to ```(T(i),X(:,i))``` (for i in [1,n]) and ```res``` is a matrix with r rows and n columns.  To sum up: ```res(:,i) = fun(T(i),X(:,i))```

### [saveAll.m](https://github.com/CcileMoul1/TheseMoulin/blob/main/functions/saveAll.m)
:warning: this procedure is used in scripts

Procedure to save all the open figures.

#### Usage
```saveAll(dossier,format_fig);```

This procedure saves every open figures into the folder ```dossier``` to the format ```format_fig```. If the figure has a name, this name will be the name of the file. Else, the file is named ```figure_i``` with i the number of the figure.

### [```solveODE_long.m```](https://github.com/CcileMoul1/TheseMoulin/blob/main/functions/solveODE_long.m)
:warning: this function is used in the scripts.

This function solves the differential system given in parameters or directly

#### Installation
```solveODE.m``` and ```solveODE_long.m``` use ```allFluxes.m``` and ```myApplyFun.m```.

#### Usage
```[t,x,fluxes,dxdts] = solveODE_long(x0,tf,solve,equadiff,getFlux);```

* ```x0``` is the initial condition: a vector of m elements
* ```tf``` is either the final time of the simulation (the interval of integration is then ```interval = [0 tf]```), or directly the interval of integration (```interval = tf```). 
* ```solve``` is a [function handle](https://fr.mathworks.com/help/matlab/matlab_prog/creating-a-function-handle.html) of a solver (```ode45```, ```ode15s```,...). This function handle has to take as inputs: ```system_function``` (the differential system),```interval``` (the interval of integration) and ```x0``` (the initial condition). The option used by the solver have to be defined directly in the function handle (see example bellow).
* ```equadiff``` is a function handle of the function describing the differential system. The function handle has to take two inputs: a positive number that represent the time and a vector of m elements representing the state of the system. It returns a **column** vector of m elements.
* ```getFlux``` is a function handle of the flux function. This function handle has to take two inputs: a positive number that represent the time and a vector of m elements representing the state of the system. It returns a [Map container](https://fr.mathworks.com/help/matlab/map-containers.html) that contains all the reaction rates at the state and time described by the given parameters.

* ```t``` is the column vector of n elements returned by the solver: it contains the evaluation points. If ```interval``` contains two values, then ```t``` contains the internal evaluation points used to perform the integration. If ```interval``` contains more than two values, then ```t``` is equal to ```interval```.
* ```x``` is the solution of the integration returned as matrix of n rows and m columns. Each row in ```x``` corresponds to the solution at the value returned in the corresponding row of ```t```.
* ```fluxes``` is a Map Container where ```fluxes(reactionName)``` is a vector of n elements, corresponding to the reaction rate of the reaction ```reactionName``` at every time of ```t```.
* ```dxdts``` is a matrix of n rows and m columns. The ith row in ```dxdts``` corresponds to ```equadiff(t(i),x(i,:))'```. :exclamation: ```equadiff``` returns a column vector but the results are store as rows in ```dxdts```.

#### [```solveODE.m```](https://github.com/CcileMoul1/TheseMoulin/blob/main/functions/solveODE.m)
This function is the short version of ```solveODE_long.m```. Instead of giving the solver, the differential system and the flux function in parameter, there are defined in the function (:exclamation: change the file when you want to change the system you study). ```solveODE.m``` is thought to be a shortcut for ```solveODE_long.m``` and to avoid the repetition of ```param``` and ```order``` that may lead to errors. ```solveODE.m``` is thought to be used with systems similar to the systems I present here (with ```param``` and ```order```). If your system does not use ```param``` and ```order```, prefer the use of ```solveODE_long.m```.

To use this function: ```[t,x,fluxes,dxdts] = solveODE(x0,param,order,tf);```. 

#### Example
```solveODE_long.m```:

```MATLAB
optionsode = odeset();
solve = @(ode_function,interval,x0) ode45(ode_function,interval,x0,optionsode);
equadiff = @(t,x) systeme(t,x,param,order);
getFlux = @(t,x) flux(t,x,param,order);
[t,x,fluxes,dxdts] = solveODE_long(x0,tf,solve,equadiff,getFlux);
```
```optionsode``` is an [```odeset```](https://fr.mathworks.com/help/matlab/ref/odeset.html) to define the options used by the solver.

or directly
```MATLAB
optionsode = odeset();
[t,x,fluxes,dxdts] = solveODE_long(x0,tf,@(ode_function,interval,x0) ode45(ode_function,interval,x0,optionsode),@(t,x) systeme(t,x,param,order),@(t,x) flux(t,x,param,order));
```

[//]: # (Commentaire de séparation)

## [metabolic_model](https://github.com/CcileMoul1/TheseMoulin/tree/main/metabolic_model)

Files to describe the metabolic model I built the other models upon

### [```flux.m```](https://github.com/CcileMoul1/TheseMoulin/blob/main/metabolic_model/flux.m)
:warning: this function is needed by ```systeme.m```

Computes the reaction rates.

#### Installation
This file needs ```getIndex.m```, ```activation.m```, ```inhibition.m``` and ```mm.m``` to calculate the reaction rates.

#### Usage
```fluxes = flux(t,x,param,order)```

```fluxes``` is a [Map container](https://fr.mathworks.com/help/matlab/map-containers.html) that contains all the reaction rates at the state and time described by the given parameters (see below). ```fluxes(nameReaction)```  is the reaction rate of the reaction ```nameReaction```. You can have the list of ```nameReaction``` with ```keys(fluxes)``` or in ```systeme.m```, in ```flux.m``` or in ```model.txt``` (names in ```fluxes``` are the names in ```model.txt``` with a V at the beginning. The case matters). If a reaction is reversible, you have access to the two sub-reaction by adding ```dir``` (direct reaction) or ```rev``` (reverse reaction) at the end of the name.
* ```t``` is a positive real number describing the time (in hour)
* ```x``` is a vector containing the state of the system
* ```param``` is a Map container with the value of each parameter: ```param(nameParameter) = valueParameter```. My version of ```param``` is available in ```param.mat``` or in ```param.ods```. You can have the list of ```nameParameter``` with ```keys(param)``` or in ```flux.m```
* ```order``` is a ```cell array``` containing the names of the variables. It fixes the order of the variables in the vector. A version of ```order``` is available with ```getOrder.m```.


### [```getOrder.m```](https://github.com/CcileMoul1/TheseMoulin/blob/main/metabolic_model/getOrder.m)
Returns all the variables' name in a fixed order. It determines the order of the variables in the vector.

#### Usage
```order = getOrder()```

```order``` is a cell array containing all the variables' name. It determines the order of the variables in the vector: the state of the variable named ```order{i}``` is stored in ```x(i)```.

### [model.txt](https://github.com/CcileMoul1/TheseMoulin/blob/main/metabolic_model/model.txt)
This file is just a textual description of the model. It contains the list of reactions in the format close to the [Metatool ones](https://pinguin.biologie.uni-jena.de/bioinformatik/networks/metatool/metatool5.0/ecoli_networks.html) (```=>``` irreversible reaction, ```=``` reversible reaction). It also contains the list of elements that change the rates (regulations and ratio).

In this model, EGLC, EGLN and O2 are supposed to be constant. Their concentrations are stored in ```param``` : ```param('Conc_EGLC')``` is the concentration of EGLC.

In this file, the metabolites with an asterix ```*``` are indicated only to balance the reactions but are not considered in the model.

### [```systeme.m```](https://github.com/CcileMoul1/TheseMoulin/blob/main/metabolic_model/systeme.m)
Constitutes the system of differential equations.

#### Installation
This file needs ```flux.m``` and ```getIndex.m```

#### Usage
```dxdt = systeme(t,x,param,order);```

```dxdt``` is the vector containing the rate of changes of the 27 variables at the state and time described by the given parameters : 
* ```t``` is a positive real number describing the time (in hour)
* ```x``` is a vector containing the state of the system
* ```param``` is a ```containers.Map``` with the value of each parameter: ```param(nameParameter) = valueParameter```. My version of ```param``` is available in ```param.mat``` and ```param.ods```. You can have the list of ```nameParameter``` with ```keys(param)``` or in ```flux.m```
* ```order``` is a ```cell array``` containing the names of the variables. It fixes the order of the variables in the vector. A version of ```order``` is available with ```getOrder.m```.

[//]: # (Commentaire de séparation)

## metabolic_model_cancer

[//]: # (Commentaire de séparation)

## [parameters and initial conditions](https://github.com/CcileMoul1/TheseMoulin/tree/main/param_ci)

### [```param.mat```](https://github.com/CcileMoul1/TheseMoulin/blob/main/param_ci/param.mat)
is the file containing the Map container ```param``` with all the parameters of the metabolic model. The file [```param.ods```](https://github.com/CcileMoul1/TheseMoulin/blob/main/param_ci/param.ods) is the spreadsheet version of ```param.mat``` with the unit of each parameter in addition.

#### Usage
```MATLAB
load param.mat
``` 
loads ```param``` into your workspace.

### [```ci.mat```](https://github.com/CcileMoul1/TheseMoulin/blob/main/param_ci/ci.mat)
contains an example of initial condition vector: ```ci```. It is the main initial condition I used in my thesis: the concentration of all metabolites are 0 except for the currency metabolites (ATP, ADP, AMP, NAD, NADH, NADP, NADPH) and the biomass which have more biological initial value.
The file [```ci.ods```](https://github.com/CcileMoul1/TheseMoulin/blob/main/param_ci/ci.ods) is the spreadsheet version of ```ci.mat```.

#### Usage
```MATLAB
load ci.mat
``` 
loads ```ci``` into your workspace. ```ci``` is a vector of 27 float values. The order of this vector is fixed by ```getOrder.m```.
:warning: if you create an initial condition you have to follow the same order as in ```getOrder.m``` or your own order.

[//]: # (Commentaire de séparation)

## [scripts](https://github.com/CcileMoul1/TheseMoulin/tree/main/scripts)
Examples to show how to use the functions and the models.

### [```script_temporal_solve_draw.m```](https://github.com/CcileMoul1/TheseMoulin/blob/main/scripts/script_temporal_solve_draw.m)
Example of a simple simulation from 0 to tf. The script also draws the variables and the reaction rates



