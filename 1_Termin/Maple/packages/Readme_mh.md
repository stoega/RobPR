# ModelingHelper
## What is ModelingHelper?
*ModelingHelper* is a *Maple* module that supports the user in creating kinematics and dynamics models.
It provides frequently used functionality such as creating differentiable variables (e.g. depending on time ```t```), computing a Jacobian matrix and a spin matrix.


## Usage

### Requirements
* tested on *Maple* 2015 and newer (but likely to work with older versions as well)

### Loading the module
Load the *ModelingHelper* module with
```
read(path_to_ModelingHelper);
with(ModelingHelper):
```
wherein `path_to_ModelingHelper` is a string containing the absolute or relative path to the module file `ModelingHelper.mpl`.
Note that, at least in *Windows*, *Maple* needs to be started by double-clicking on the worksheet file in order to accept paths relative to the worksheet file.

#### Create a *ModelingHelper* instance
Create an instance of *ModelingHelper*, here called `mh`, by evaluating

```
mh := ModelingHelper():
```
In most cases it is sufficient to use a single *ModelingHelper* in one *Maple* worksheet.

#### Create differentiable variables
By default, variables with dependencies on another variable ```t``` have to be declared as ```q(t) := ...``` which may yield bloated and confusing code.
*ModelingHelper* allows to transparently define variables for which it interally stores the dependency on other variables. 

To the user, such variables appear as algebraic without dependency. If the *ModelingHelper* differentiation operation ```diff_t``` is applied, the declared dependency is used.

##### Same-name vector variables
A new variable is added by
```
q, q_dot := mh:-add_time_var(q, dim=1, der=1);
```
wherein on the right hand side ```q``` is the (previously undefined) symbol representing the variable.
```dim``` is its (single) dimension and ```der``` is the number of non-zero derivatives w.r.t. ```t```.
The return values are the vectors holding the created variables. The (left hand side) variable ```q``` is the newly created vector of variables (now dependent on ```t```) and ```q_dot``` is the vector of first derivatives.

Default values: ```dim=1``` and ```der=1```, these arguments are optional.

*Example*
```
q, q_dot := mh:-add_time_var(q, dim=2, der=2);
```
results in
```
q, q_dot, q_ddot := Vector[column](2, [q1, q2]), Vector[column](2, [q1_dot, q2_dot]), Vector[column](2, [q1_ddot, q2_ddot])
```
creates vector variabes ```q, q_dot, q_ddot``` of dimension 2 up to the second derivative.

##### Different-name vector variables
A new variable is added by
```
q, q_dot := mh:-add_time_var(<alpha,beta>, der=1);
```
wherein on the right hand side ```<alpha,beta>``` is the vector representing the variables ```q```.
```der``` is the number of non-zero derivatives w.r.t. ```t```.
The return values are the vectors holding the created variables. The (left hand side) variable ```q``` is the newly created vector of variables (now dependent on ```t```) and ```q_dot``` is the vector of first derivatives.

*Example*
```
q, q_dot := mh:-add_time_var(<alpha,beta>, der=2);
```
results in
```
q, q_dot, q_ddot := Vector[column](2, [alpha, beta]), Vector[column](2, [alpha_dot, beta_dot]), Vector[column](2, [alpha_ddot, beta_ddot])
```
creates vector variabes ```q, q_dot, q_ddot``` of dimension 2 up to the second derivative.

#### Deriatives w.r.t. ```t```
Variables created through a *ModelingHelper* instance, i.e. using ```add_time_var```, can be used the same way as any other algebraic variables.
With the function ```mh:-diff_t(expr)``` an expression ```expr``` is derived w.r.t. ```t```.

*Example*
```
q, q_dot := mh:-add_time_var(<alpha,beta>, der=2);
expr := 1/2*q_dot^%T.q_dot:
res := mh:-diff_t(expr);
```
results in
```
res := alpha_ddot*alpha_dot+beta_ddot*beta_dot
```

Expressions can be scalar, vector or matrix valued.


#### Jacobian Matrix
A Jacobian represent a derivative of a scalar or vector valued quantity w.r.t. to a vector of variables.
This functionality is provided by the ```Jacobi(expr, vec)``` function which is a nicer-to-use wrapper for *Maple*'s own ```VectorCalculus[Jacobian](vec, list)``` function.

*Example*
```
q := <q1, q2, q3, q4>;
expr := 1/2*q^%T.q;
jac := Jacobi(expr, q);
```
results in
```
jac := Matrix(1, 4, {(1, 1) = q1, (1, 2) = q2, (1, 3) = q3, (1, 4) = q4})
```

Note, that this Function works without variables defined using ```add_time_var```.

#### Spin Matrix
Computation of the spin matrix of a vector of size 3 is provided by

*Example*
```
u := <x, y, z>;
spinmat := Spin(u);
```
results in
```
Matrix(3, 3, {(1, 1) = 0, (1, 2) = -z, (1, 3) = y, (2, 1) = z, (2, 2) = 0, (2, 3) = -x, (3, 1) = -y, (3, 2) = x, (3, 3) = 0})
```

Note, that this Function works without variables defined using ```add_time_var```.
