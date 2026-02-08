# ORR_SOMMERFELD_FD
Finite difference discretization of Orr-Sommerfeld operator for hydrodynamic stability

The code base contains a the following routines:

 1. A main driver script that
    i.   sets up the stability problem for either plane Poiseuille flow (channel flow) or plane Couette flow
    ii.  creates discrete differentiation operators using finite difference approaches
    iii. solves the Orr-Sommerfeld (OS) eigenvalue problem
    iv.  plots the spectrum of linearized OS operator and highlights the least stable mode
 
 2. Subroutines that set up finite difference operators for the first and second derivatives
    i. Can use either E2, E4, C4, or C6 differencing schemes

The code has been validated against the reference eigenvalues in Appendix A of the textbook 
'Stability and Transition in Shear Flows' by Schmid and Henningson, 2001.

Furthermore, the code faithfully reproduces the well known result of plane Poiseuille flow becoming unstable at Re = 5772.22 
and at a streamwise wavenumber of alpha ~ 1.02. The spectrum of this unstable channel case is presented in the attached figure.


<img width="1882" height="1655" alt="ORR_SOMMERFELD_SPECTRUM" src="https://github.com/user-attachments/assets/efb8b1b2-7c8c-4884-a2c6-840dd31d8b6d" />
Specrtum of Orr-Sommerfeld operator at critical Reynolds number of Re = 5772.22, and the critical streamwise wavenumber.


Note that this code was written to help teach computational hydrodynamic stability to myself, as the theory has made
conceptual sense to me (after extensive reading and admittedly large amounts of initial frustration) but the act of 
discretizing and solving the eigenvalue problem did not quite click. In order to remedy this, the present code was written
to help learn. It is hoped that the code will serve a similar purpose for others - though it must be clearly disclaimed that 
this is NOT a research caliber code and should not be used as such.
