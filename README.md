(Repository in progress)
# TheseMoulin
Scripts and models used in my PhD thesis: [Metabolic network analysis during the cell cycle : application to the cancer metabolism](http://www.theses.fr/2020UPASG022). The manuscript is available in French [here](https://tel.archives-ouvertes.fr/tel-03164566).

The hybrid automaton is an upgraded version of the one described in my article [Using a Hybrid Approach to Model Central Carbon Metabolism Across the Cell Cycle, Moulin et al. 2019](https://link.springer.com/chapter/10.1007/978-3-030-28042-0_9).

## [add-ons](https://github.com/CcileMoul1/TheseMoulin/tree/main/add-ons)
Other files that may help to understand the models

### [differential_system.md](https://github.com/CcileMoul1/TheseMoulin/blob/main/add-ons/differential_system.md)
In this file, I describe how I build a differential system to study the growth and the metabolic behvior of a population of cells inside a reactor. This system is adaptable to different kind of reactors. In my thesis I assumed the cell population to be in a batch reactor where the extracellular metabolite concentrations are constant.

[//]: # (Commentaire de séparation)

## [functions](https://github.com/CcileMoul1/TheseMoulin/tree/main/functions)
All the functions to make the code works but not specific to the models. Store these files directly in the same folder as the other files or add them temporarily to the [path](https://fr.mathworks.com/help/matlab/ref/addpath.html) or definitively with [```pathdef.m```](https://fr.mathworks.com/help/matlab/ref/savepath.html) (```pathdef.m``` is a Matlab file).

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
```dxdt = systeme(t,x,param,order)```

```dxdt``` is the vector containing the rate of changes of the 27 variables at the state and time described by the given parameters : 
* ```t``` is a positive real number describing the time (in hour)
* ```x``` is a vector containing the state of the system
* ```param``` is a ```containers.Map``` with the value of each parameter: ```param(nameParameter) = valueParameter```. My version of ```param``` is available in ```param.mat``` and ```param.ods```. You can have the list of ```nameParameter``` with ```keys(param)``` or in ```flux.m```
* ```order``` is a ```cell array``` containing the names of the variables. It fixes the order of the variables in the vector. A version of ```order``` is available with ```getOrder.m```.

[//]: # (Commentaire de séparation)

## metabolic_model_cancer

[//]: # (Commentaire de séparation)

## parameters and initial conditions

### ```param.mat``` link :soon:
:soon:
### ```ci.mat``` link :soon:
:warning: if you create an initial condition you have to follow the same order as in ```getOrder.m``` or your own order

[//]: # (Commentaire de séparation)

## scripts
