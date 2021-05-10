# Study the growth and metabolic behavior of a cell population into a reactor

Hypothesis:
* the cell population is homogeneous
* the cell population growth is exponential
* the environment is homogeneous (well-stired)
* the population volume is negligible compared to the reactor volume


Units are given but might be adapted. In that case, the formulas may change

## Reactor volume
### Variable and parameters
* ![formula](https://render.githubusercontent.com/render/math?math=V)(L) *volume of the reactor*
* ![formula](https://render.githubusercontent.com/render/math?math=F_{in}) (L/h) *input flow*
* ![formula](https://render.githubusercontent.com/render/math?math=F_{out}) (L/h) *output flow*

### Differential equation

![formula](https://render.githubusercontent.com/render/math?math=\frac{dV}{dt}=F_{in}-F_{out})

## Cell population
### Variable and parameters
* ![formula](https://render.githubusercontent.com/render/math?math=x_b) (nbcell/mL) (number of cells per unit of volume) *biomass*
* ![formula](https://render.githubusercontent.com/render/math?math=\mu{}) (/h) *growth rate of the cell population*

### Differential equation
![formula](https://render.githubusercontent.com/render/math?math=\frac{dx_b}{dt}=\mu{}x_b-\frac{F_{in}}{V}x_b)

### Origin
![formula](https://render.githubusercontent.com/render/math?math=(x_bV)) is the number of cells in the reactor. The variation of this number is given by

![formula](https://render.githubusercontent.com/render/math?math=\frac{d(x_bV)}{dt}=\mu{}(x_bV)-F_{out}x_b)

where
* ![formula](https://render.githubusercontent.com/render/math?math=\mu{}(x_bV)) is due to the exponential growth hypothesis
* ![formula](https://render.githubusercontent.com/render/math?math=F_{out}x_b) is the number of cells that leave the reactor through the output flow

By using ![formula](https://render.githubusercontent.com/render/math?math=\frac{d(x_bV)}{dt}=V\frac{dx_b}{dt}%2Bx_b\frac{dV}{dt}) and the previous differential equation, we obtain the differential equation for this variable.

## Extracellular metabolites
(metabolites that are directly in the reactor) 
### Variable and parameters
* ![formula](https://render.githubusercontent.com/render/math?math=x_e) (mol/L) *concentration vector of extracellular metabolites in the reactor*
* ![formula](https://render.githubusercontent.com/render/math?math=S_e) (no unit) *rows of the stoichiometric matrix concerning the extracellular metabolites*
* ![formula](https://render.githubusercontent.com/render/math?math=\nu{}) (mol/nbcell/h) (quantity of matter per number of cells per unit of time) *reaction rate vector*
* ![formula](https://render.githubusercontent.com/render/math?math=C_{in}) (mol/L) *concentration vector of extracellular metabolites in the input flow*

### Differential equation
![formula](https://render.githubusercontent.com/render/math?math=\frac{dx_e}{dt}=S_e\nu{}x_b%2B\frac{F_{in}}{V}(C_{in}-x_e))

### Origin
![formula](https://render.githubusercontent.com/render/math?math=(x_eV)) is the total amount of matter for each extracellular metabolite. Its variation is given by

![formula](https://render.githubusercontent.com/render/math?math=\frac{d(x_eV)}{dt}=S_e\nu{}(x_bV)%2BF_{in}C_{in}-x_eF_{out})

where
* ![formula](https://render.githubusercontent.com/render/math?math=\frac{d(x_eV)}{dt}=S_e\nu{}(x_bV)) is the rate of production/consumption of each metabolite by the total amount of cells
* ![formula](https://render.githubusercontent.com/render/math?math=F_{in}C_{in}) is the amount of metabolites brought by the input flow
* ![formula](https://render.githubusercontent.com/render/math?math=x_eF_{out}) is the amount of metabolites leaving the reactor through the output flow


By using ![formula](https://render.githubusercontent.com/render/math?math=\frac{d(x_eV)}{dt}=V\frac{dx_e}{dt}%2Bx_e\frac{dV}{dt}) and the previous differential equations, we obtain the differential equation for this variable.

## Intracellular metabolites
(metabolites that are in the cells)
### Variable and parameters
* ![formula](https://render.githubusercontent.com/render/math?math=x_i) (mol/nbcell) (quantity of matter per number of cells) *"concentration" vector of intracellular metabolites in the cells*
* ![formula](https://render.githubusercontent.com/render/math?math=S_i) (no unit) *rows of the stoichiometric matrix concerning the intracellular metabolites*
* ![formula](https://render.githubusercontent.com/render/math?math=\nu{}) (mol/nbcell/h) (quantity of matter per number of cells per unit of time) *reaction rate vector* **same as in the extracellular metabolites section**

### Differential equation
![formula](https://render.githubusercontent.com/render/math?math=\frac{dx_i}{dt}=S_i\nu{}-\mu{}x_i)

### Origin
![formula](https://render.githubusercontent.com/render/math?math=(x_ix_bV)) is the total amount of matter for each intracellular metabolite. Its variation is given by

![formula](https://render.githubusercontent.com/render/math?math=\frac{d(x_ix_bV)}{dt}=S_i\nu{}(x_bV)-F_{out}x_bx_i)

where
* ![formula](https://render.githubusercontent.com/render/math?math=S_i\nu{}(x_bV)) is the rate of production/consumption of each metabolite by the total amount of cells
* ![formula](https://render.githubusercontent.com/render/math?math=F_{out}x_bx_i) is the amount of intracellular metabolites leaving the reactor through the output flow

By using ![formula](https://render.githubusercontent.com/render/math?math=\frac{d(x_ix_bV)}{dt}=x_bV\frac{dx_i}{dt}%2Bx_iV\frac{dx_b}{dt}%2Bx_ix_b\frac{dV}{dt}) and the previous differential equations, we obtain the differential equation for this variable.


## The system
![formula](https://render.githubusercontent.com/render/math?math=\frac{dV}{dt}=F_{in}-F_{out})

![formula](https://render.githubusercontent.com/render/math?math=\frac{dx_b}{dt}=\mu{}x_b-\frac{F_{in}}{V}x_b)

![formula](https://render.githubusercontent.com/render/math?math=\frac{dx_e}{dt}=S_e\nu{}x_b%2B\frac{F_{in}}{V}(C_{in}-x_e))

![formula](https://render.githubusercontent.com/render/math?math=\frac{dx_i}{dt}=S_i\nu{}-\mu{}x_i)

This system could be adapted to different type of reactor
* batch reactor ![formula](https://render.githubusercontent.com/render/math?math=F_{in}=F_{out}=0)
* fedbatch reactor ![formula](https://render.githubusercontent.com/render/math?math=F_{out}=0) and ![formula](https://render.githubusercontent.com/render/math?math=F_{in}>=0)
* chemostat ![formula](https://render.githubusercontent.com/render/math?math=F_{in}=F_{out}>0)
