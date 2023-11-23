# SimCode C
## What is SimCode C?
*SimCode C* is a *Maple* package for code generation for *MATLAB/Simulink*.
It transforms *Maple* representations of equations of motion (EoM) resulting from modeling mechanical systems as well as algebraic functions to C programming language functions to be used from *MATLAB* (also MEX function though class wrapper) and *Simulink* (C/*MATLAB* S-Function, MATLAB Function).

**Key features**
* Support for equations of motion of mechanical systems
  * redundant and minimal coordinate formulation
  * non-holonomic velocity coordinates
  * conditional, redundant constraints (resolution by SVD with optional zeroing threshold)
* Support for algebraic functions
* Multiple parameter vectors
* Multiple inputs/outputs
* Code generation of
  * *MATLAB* Class Wrapper (for use in *MATLAB*)
  * C-S-Function (for use in *Simulink*)
  * MATLAB Level-2 S-Function (for use in *Simulink*)
  * MATLAB Function-based dynamics implementation (for use in *Simulink*)
  * Simulink model (S-Function block/Subsystem with MATLAB Functions with mask with annotated ports)
  * Makefile (for all the above)
  * Intialization file (with dummy values of correct dimensions)

## Usage

### Requirements
* *Maple* 2015 or newer (but might work with older versions as well)
* *MATLAB/Simulink* 2015b or higher and a supported C compiler
* (only for C code generation) [GNU Scientific Library (GSL) 2.5](https://www.gnu.org/software/gsl/)
  * dynamic object files in folder specified by environment variable `SimCodeC_lib` (check out the GSL binaries that come with *SimCode C*; built from original sources using the cmake script from [the version provided by AMPL](https://github.com/ampl/gsl))
  * `SimCodeC_lib` is in the user path (NOT MATLAB path; otherwise the GSL DLLs will not be found)
  * headers availabe in subfolder `gsl` placed in `include` folder specified by environment variable `SimCodeC_include`
  
  These environment variables can be conveniently set in *MATLAB* by
  ```
  setenv('SimCodeC_lib', 'path/to/lib_folder');
  setenv('SimCodeC_include', '/path/to/include_folder');
  ```
  You can place these commands in your [*MATLAB* startup file](https://mathworks.com/help/matlab/ref/startup.html).
### Installation and Loading
#### Compiled Library (`SimCodeC.mla`)
Download `SimCodeC.mla` and place it in diretory accessible from *Maple*, e.g. on a Windows machine `C:\Users\user\SimCodeC`.

To load the release version of *SimCode C*, enter
```
march('open', path_to_SimCodeC);
with(SimCodeCPackage);
```
wherein `path_to_SimCodeC` is a placeholder for the absolute or relative path to the library file `SimCodeC.mla`, e.g. for the example path above `C:/Users/user/SimCodeC/SimCodeC.mla`.
Make sure you replace `\` by `/`.

#### Source Code (`SimCodeC.mpl`)
Download the module file `SimCodeC.mpl` and place it in directory accessible from *Maple*, e.g. on a Windows machine `C:\Users\user\SimCodeC`.

To load the (non-compiled) source code version of *SimCode C*, enter
```
read(path_to_SimCodeC);
```
wherein `path_to_SimCodeC` is a string containing the absolute or relative path to the module file `SimCodeC.mpl`.
Note that, at least in *Windows*, *Maple* needs to be started by double-clicking on the worksheet file in order to accept paths relative to the worksheet file.

### Usage
#### Create a *SimCode C* instance
Create an instance of *SimCode C*, here called `scc`, by evaluating

```
scc := SimCodeC("modelname"):
```
wherein the string argument is optional. It is used in header files and for naming blocks in *Simulink* models.

Note that multiple instance of *SimCode C* type objects can be used troughout one *Maple* worksheet.
#### Parameters
Parameters are variables specified by the user that do not change during the computation of functions and dynamics.
Multiple scalar or vector valued parameters can be specified, parameters in list form are not supported.
##### Example
A scalar parameter variable `p1` is added by 

```
addParameter(scc, p1, "p1_name");
```
wherein `p1_name` represents the parameter's literal name to be displayed in Simulink masks.
##### Example
Another scalar parameter `p2` is added likewise, i.e.

```
addParameter(scc, p2);
```
This parameter is unnamed, a literal name will be automatically generated.
##### Example
A vector valued parameter with the elements `p3` and `p4` is added by

```
addParameter(scc, <p3, p4>);
```
#### Inputs
Inputs are variables specified by the user that may change during the computation of functions and dynamics.
Multiple scalar or vector valued inputs can be specified.
##### Example
A scalar input variable `in1` is added by 

```
addInput(scc, in1, "input1");
```
Therein, the last parameter, `input1`, specifies the display name and is optional.
##### Example
Another scalar input `in2` is added likewise

```
addInput(scc, in2, "in2_name");
```
wherein the optional string parameter `in2_name` is the input's literatal name.
##### Example
Also vectors are supported as inputs, e.g. the vector with the elements `in3` and `in4` is added by

```
addInput(scc, <in3, in4>);
```
#### Outputs
Outputs are scalar or vector valued expressions made up by symbolic variables occuring somewhere in the computations performed by *SimCode*.
Such expressions may consist of
* inputs
* results of dynamics
  * state 
  * state derivative wrt. time
  * constraint forces

##### Example
For example, the product of the input `in1` and the parameter `p1` is added by 

```
addOutput(scc, in1*p1);
```
##### Example
In certain cases, e.g. a *SimCode* variable was already defined elsewhere in the *Maple* worksheet, the evaluation of the output expression needs to be [delayed](https://www.maplesoft.com/applications/view.aspx?SID=1526&view=html) by using single quotes (unevaluation quotes) around *each* variable, i.e. for the example above

```
addOutput(scc, 'in1'*'p1', "in1_by_p1");
```
Therein, the last parameter, `in1_by_p1`, specifies the display name and is optional.

##### Example
Another combined output expression might be vector valued, e.g. for the product of the scalar parameter `p1` and the vector valued dynamics variable `qq` type

```
addOutput(scc, p2*qq);
```
#### First-Order Dynamic Systems
First order dynamics are given by the state-space representation
**x_dot = f(x, u)**
wherein **x** denotes the state of the dynamic system and **u** the input to the system. **f** is a function that is in general non-linear w.r.t. the **x** and **u**.
```
addStateSpace(scc, 'x', 'x_dot', f);
```
wherein `f` may access the state `x`, but also *SimCode C* variables such as inputs, parameters, or function results.

Note that second-order dynamics, see below, can be rewritten as first-order dynamics in *Maple* if the mass Matrix **M** can be inverted symbolically. This may yield increased performance as the system of linear equations **M(q) s_ddot = h(q, s_dot)** does not need to be solved. 

#### Second Order Dynamic Systems
In *SimCode C*, the dynamics of a mechatronic system is given by a system of second-order ordinary differential equations, e.g. representing its equations of motion

**M(q) s_ddot = h(q, s_dot)** 

wherein **q** denotes coordinates which may be minimal or non-minimal, **s_dot** are velocities which may be holonomic (in which case **q_dot** = **s_dot** holds) or non-holonomic (in which case there exists a transformation **q_dot = H(q) s_dot**).
**M** denotes the mass matrix (symmetric and positive definite).
**h(q, s_dot)** denotes a in general non-linear function.

Additionally there may be geometric constraints **g(q) = 0** that result in kinematic constraints **g_dot(q, q_dot) = G(q) q_dot = 0** by derivation wrt. time.
Pure kinematic constraints whith no corresponding geometric constraints may also be specified.


##### Holonomic Coordinates
An ODE

**M(q) q_ddot = h(q, q_dot)** 

with holonomic velocities **q_dot** is implemented as
```
addDynamics(scc, q, q_dot, q_ddot, M, h);
```
wherein `h` may access *SimCode C* variables such as inputs, parameters, or function results.

##### Holonomic Coordinates with Constraints

The above ODE can be constrained by introducing constraint **lam** forces such that the specified constraints are satisfied:

**M(q) q_ddot = h(q, q_dot) + G^T lam** 

wherein **G** is the velocity level constraint matrix.

##### Example
A constraint such as `constr1` is entered as a list. The complete set of constraints, i.e. `constraints`, is entered as a list of lists.
The entered constraints may be redundant, therefore a singular value decomposition of the matrix **G.[M\G^T ]** is performed to remove redundant constraints. Therein, a threshold `SVD_thres` can be specified below which singular values are considered zero. For `SVD_thres := 0` the internal threshold of GNU Scientific Libary is used.
```
constr1 := [condition1, lam1, g1, G1, G1_dot, K1, D1]; 
constr2 := ... 
constraints := [constr1, constr2, ...]
addDynamics(scc, q, q_dot, q_ddot, M, h, constr=constraints, lindep_method="svd", lindep_svd_thresh=SVD_thres);
```
The parameters `lindep_method` (default: `"svd"`) and `lindep_svd_thresh` (for `lindep_method="svd"`; default: 0) and `lindep_pinv_weights` (for `lindep_method="pinv"`; default: vector of ones) are optional.

**Constraint list syntax**
* `condition1` represents a boolean expression. If true, the constraint becomes active.

* `lam1` denotes the constraint force variable. 
* `g1` is the vector of geometric constraints. If `g1 := []`, only velocity-level constraints are considered.
* `G1` is the velocity constraint matrix, i.e. the velocity constraint is given as `
G1.q_dot=0`. 
* `G1_dot` is the time derivative of `G1` 
* `K1`,  `D1`: Matrices for Baumgarte stabilization.

##### Non-holonomic Coordinates
An ODE

**M(q) s_ddot = h(q, s_dot)** 

with non-holonomic velocities **s_dot** is implemented as
```
addDynamics(scc, q, s_dot, s_ddot, M, h, nonholonomic_H=H);
```
wherein `H` denotes the transformation **q_dot = H(q) s_dot**.

See section *Holonomic Coordinates* for further details.

##### Non-holonomic Coordinates with Constraints
The constrained ODE with non-holonomic velocity coordinates

**M(q) s_ddot = h(q, s_dot) + G^T lam** 
```
addDynamics(scc, q, s_dot, s_ddot, M, h, nonholonomic_H=H, constr=constraints, lindep_method="svd", lindep_svd_thresh=SVD_thres);
```
wherein `H` denotes the transformation **q_dot = H(q) s_dot** and **G** is the velocity level constraint matrix.
The parameters `lindep_method` (default: `"svd"`) and `lindep_svd_thresh` (for `lindep_method="svd"`; default: 0) and `lindep_pinv_weights` (for `lindep_method="pinv"`; default: vector of ones) are optional.

##### Example
A constraint such as `constr1` is entered as a list. The complete set of constraints, i.e. `constraints`, is entered as a list of lists.
The entered constraints may be redundant, therefore a singular value decomposition of the matrix **G.[M\G^T ]** is performed to remove redundant constraints. Therein, a threshold `SVD_thres` can be specified below which singular values are considered zero. For `SVD_thres := 0` the internal threshold of GNU Scientific Libary is used.
```
constr1 := [condition1, lam1, g1, G1, G1_dot, K1, D1]; 
constr2 := ... 
constraints := [constr1, constr2, ...]
addDynamics(scc, q, s_dot, s_ddot, M, h, nonholonomic_H=H, constr=constraints, lindep_method="svd", lindep_svd_thresh=SVD_thres);
```
**Constraint list syntax**
* `condition1` represents a boolean expression. If true, the constraint becomes active.

* `lam1` denotes the constraint force variable. 
* `g1` is the vector of geometric constraints. If `g1 := []`, only velocity-level constraints are considered.
* `G1` is the velocity constraint matrix, i.e. the velocity constraint is given as `
G1.s_dot=0`. 
* `G1_dot` is the time derivative of `G1`
* `K1`,  `D1`: Matrices for Baumgarte stabilization.

#### Code Generation
##### Simulink C S-Function
```
cSfun(scc, "model_sfun.c", overwrite=true);
```
wherein the optional boolean argument `overwrite` allows to overwrite existing files.
##### Simulink MATLAB S-Function
```
mSfun(scc, "model_sfun.m", overwrite=true);
```
wherein the optional boolean argument `overwrite` allows to overwrite existing files.
##### MATLAB Class Wrapper Function
A *MATLAB* class represent all algebraic (input-output) functions and dynamics functions (input-state derivative, input-accelerations and constraint forces) in an object oriented framework.
Numerical evaluation performance is optionally increased by using a compiled C MEX-Function that replaces the evaluation of *MATLAB* scripts.
```
mClass(scc, "Model.m", overwrite=true, create_cmex=true);
```
wherein the optional boolean argument `overwrite` allows to overwrite existing files, the default value is `false`.
The optional argument `create_cmex` allows to create a *MATLAB* C MEX-Function for faster numerical evaluation, the default value is `false`. In the above case the source file "ModelMEX.c" will be created.

Note, that use of results of dynamics, i.e. state derivatives, accelerations or constraint forces, are not supported by this type of function and therefore skipped (a warning is displayed).


##### MATLAB Function (in Simulink)
A model (with or without dynamics) can also be implemented using MATLAB Functions and a state integrator. The Makefile, see below, allows to generate a *Simulink* model that containts such a representation. Check the the `mfun` target of the Makefile.
##### Makefile
Invoke
```
makefile(scc, "make_model.m", overwrite=true);
```
*after* generating *MATLAB*/*Simulink* files to include the respective build commands in the makefile.
The optional boolean argument `overwrite` allows to overwrite existing files.

Typical targets are
* `all`: all available targets are built
* `csfun`: C S-Function
* `csfun_model`: *Simulink* model that instatiates the C S-Function (also invokes target `csfun`)
* `msfun`: *MATLAB* Level-2 S-Function
* `msfun_model`: *Simulink* model that instatiates the *MATLAB* Level-2 S-Function (also invokes target `msfun`)
* `mfun_model`: *Simulink* model that instatiates *MATLAB* Functions (formerly known as *MATLAB* Embedded Functions)
* `clean`: deletes C S-Function MEX file

Rebuilds are performed economically, i.e. C files are only recompiled if changes of the source file were detected.

##### Initialization File
Write an init file that includes dummy parameters (of correct dimensions).
```
initfile(scc, "init_model.m", overwrite=true);
```
wherein the optional boolean argument `overwrite` allows to overwrite existing files.

## Examples
Examples are found in the corresponding subfolder of this repository.

## Known Limitations
* Simulink: Due to the internal computation order of outputs and dynamics of an S-Function, accelerations and constraint forces used in outputs are delayed by one time step.
* In case of discontinuities in system dynamics such as Coulomb friction implemented with a sign function, the quality of simulation results may be degraded.

## Further Information
* For switching constraints, the generalized momentum is preserved, cf.
  Müller, A. (2016). Forward dynamics of variable topology mechanisms—The case of constraint activation. Proceedings of the Institution of Mechanical Engineers, Part K: Journal of Multi-body Dynamics, 230(4), 442-454. [Paper Download](http://journals.sagepub.com/doi/abs/10.1177/1464419316631862)

## Todo
* Resolution of redundant constraints: pseudo-inverse solution with (relative) weights specified for each constraint.
* Subsystems
* Order-n solution of the EoM
* *MATLAB* class wrapper CasADi support for dynamics (linear algebra, DAE handling)
* Fix preservation of generalized momentum during constraint activation
* Improve examples and documentation
* mClass wrapper: automatically re-write state-dependent functions as input-output functions
