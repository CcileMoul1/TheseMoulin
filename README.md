(Repository in progress)
# TheseMoulin
Scripts and models used in my PhD thesis: [Metabolic network analysis during the cell cycle : application to the cancer metabolism](http://www.theses.fr/2020UPASG022). The manuscript is available in French [here](https://tel.archives-ouvertes.fr/tel-03164566).

The hybrid automaton is an upgraded version of the one described in my article [Using a Hybrid Approach to Model Central Carbon Metabolism Across the Cell Cycle, Moulin et al. 2019](https://link.springer.com/chapter/10.1007/978-3-030-28042-0_9).


## [functions](https://github.com/CcileMoul1/TheseMoulin/tree/main/functions)
All the functions to make the code works but not specific to the models. Store these files directly in the same folder as the other files or add them temporarily to the [path](https://fr.mathworks.com/help/matlab/ref/addpath.html) or definitively with [```pathdef.m```](https://fr.mathworks.com/help/matlab/ref/savepath.html) (```pathdef.m``` is a Matlab file).

### [activation.m](https://github.com/CcileMoul1/TheseMoulin/blob/main/functions/activation.m)
:warning: this function is needed by the models themself.

Returns the Michaelis-Menten ratio of an activated reaction (non-essential activation model by [Segel](https://www.google.com/search?q=ISBN+978-0-471-30309-1&client=ubuntu&hs=fOB&ei=JoaaYI2uEJuHjLsPoMi_mA0&oq=ISBN+978-0-471-30309-1&gs_lcp=Cgdnd3Mtd2l6EANQ_yhYsDdgzj1oAXAAeACAATyIAcoCkgEBNpgBAKABAaoBB2d3cy13aXrAAQE&sclient=gws-wiz&ved=0ahUKEwiN2dXL3cHwAhWbA2MBHSDkD9MQ4dUDCA4&uact=5): 

![formula](https://render.githubusercontent.com/render/math?math=\frac{(1%2B\frac{\beta{}}{\alpha{}K_a}A)S}{(1%2B\frac{1}{K_a}A)K_m%2B(1%2B\frac{1}{\alpha{}K_a}A)S})

#### Usage
```v=activation(S,A,Km,Ka,alpha,beta)```

```v``` is a vector of the same size as S and A containing the activated Michaelis-Menten ratio values.
The parameters of this function are:
* ```S``` a vector containing the concentrations of the substrate
* ```A``` a vector containing the concentrations of the activator. :exclamation: ```A``` and ```S``` should have the same length.
* ```Km``` is the dissociation constant of the enzyme-substrate complex but could also be its Michaelis constant (these two values are often confounded) :exclamation: same unit as ```S```
* ```Ka``` is the dissociation constant of the enzyme-activator complex, also known as activation constant :exclamation: same unit as ```A```
* ```alpha``` and ```beta``` are two constants of the activation :exclamation: without unit

### [getIndex.m](https://github.com/CcileMoul1/TheseMoulin/blob/main/functions/getIndex.m)
:warning: this function is needed by the models themself

Returns :soon:

#### Usage
:soon:

### [inhibition.m](https://github.com/CcileMoul1/TheseMoulin/blob/main/functions/inhibition.m)
:warning: this function is needed by the models themself

Returns :soon:

#### Usage
:soon:

### [mm.m](https://github.com/CcileMoul1/TheseMoulin/blob/main/functions/mm.m)
:warning: this function is needed by the models themself

Returns :soon:

#### Usage
:soon:

## metabolic_model

## metabolic_model_cancer

## parameters and initial conditions


## [add-ons](https://github.com/CcileMoul1/TheseMoulin/tree/main/add-ons)
Other files that may help to understand the models

### [differential_system.md](https://github.com/CcileMoul1/TheseMoulin/blob/main/add-ons/differential_system.md)
In this file, I describe how I build a differential system to study the growth and the metabolic behvior of a population of cells inside a reactor. This system is adaptable to different kind of reactors. In my thesis I assumed the cell population to be in a batch reactor where the extracellular metabolite concentrations are constant.

