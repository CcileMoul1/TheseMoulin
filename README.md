(Repository in progress)
# TheseMoulin
Scripts and models used in my PhD thesis: [Metabolic network analysis during the cell cycle : application to the cancer metabolism](http://www.theses.fr/2020UPASG022). The manuscript is available in French [here](https://tel.archives-ouvertes.fr/tel-03164566).

The hybrid automaton is an upgraded version of the one described in my article [Using a Hybrid Approach to Model Central Carbon Metabolism Across the Cell Cycle, Moulin et al. 2019](https://link.springer.com/chapter/10.1007/978-3-030-28042-0_9).

## functions (LINK)
All the functions to make the code works but not specific to the models. Store these files directly in the same folder as the other files or add them temporarily to the [path](https://fr.mathworks.com/help/matlab/ref/addpath.html) or definitively with [```pathdef.m```](https://fr.mathworks.com/help/matlab/ref/savepath.html) (```pathdef.m``` is a Matlab file).

## metabolic_model

## metabolic_model_cancer

## parameters and initial conditions


## [add-ons](https://github.com/CcileMoul1/TheseMoulin/tree/main/add-ons)
Other files that may help to understand the models

### [differential_system.md](https://github.com/CcileMoul1/TheseMoulin/blob/main/add-ons/differential_system.md)
In this file, I describe how I build a differential system to study the growth and the metabolic behvior of a population of cells inside a reactor. This system is adaptable to different kind of reactors. In my thesis I assumed the cell population to be in a batch reactor where the extracellular metabolite concentrations are constant.

