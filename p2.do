mata
covX = (1,0,0\0,1,0.6\0,0.6,1)
sigXY = (0.8\0\0)
invcovX = invsym(covX)
beta = invcovX*sigXY
beta0 = 10 - (15, 10, 10)*beta
end

global usegroupseed 103
capture program drop _all
program define prog_PS1Q2, rclass // Define the name of the program
drop _all
scalar drop _all
matrix drop _all
set more off
set obs 100 // Here you set the sample size (N=30)
matrix C=(1,0.8,0,0\0.8,1,0,0\0,0,1,0.6\0,0,0.6,1) // Here you set the var/cov matrix of the bivariate distribution
matrix m=(10, 15, 10, 10) // Here you set the vector of means of the trivariate distribution
drawnorm y x1 x2 x3, cov(C) means(m)  // This command generates a trivariate standard normal distribution with the parameters defined above
reg y x1 x2 x3
return scalar cons=_b[_cons] // save coefficient of constant in r()
return scalar beta1 = _b[x1] // save coefficient of beta1 in r()
return scalar beta2 = _b[x2]
return scalar beta3 = _b[x3] // save coefficient of beta2 in r()
test (x2=0) (x3=0)					// F-test of beta1=beta2=0
return scalar fstat = r(F) 	// generate a scalar equal to the F-test statistic of the regression 
end

set seed 103
simulate constant= r(cons) ///
beta1=r(beta1) ///
beta2=r(beta2) ///
beta3=r(beta3) ///
Fstat = r(fstat), ///
rep(1000)  /// 1000 repetitions
saving(problem_set_1Q2, replace): prog_PS1Q2 

gen id = _n
scatter Fstat id, yline(3.091)
count if Fstat > 3.091
di r(N)/1000

clear
global usegroupseed 103
capture program drop _all
program define prog_PS1Q2, rclass // Define the name of the program
drop _all
scalar drop _all
matrix drop _all
set more off
set obs 100 // Here you set the sample size (N=30)
matrix C=(1,0.8,0.2,-0.2\0.8,1,0,0\0.2,0,1,0.6\-0.2,0,0.6,1) // Here you set the var/cov matrix of the bivariate distribution
matrix m=(10, 15, 10, 10) // Here you set the vector of means of the trivariate distribution
drawnorm y x1 x2 x3, cov(C) means(m)  // This command generates a trivariate standard normal distribution with the parameters defined above
reg y x1 x2 x3
return scalar cons=_b[_cons] // save coefficient of constant in r()
return scalar beta1 = _b[x1] // save coefficient of beta1 in r()
return scalar beta2 = _b[x2]
return scalar beta3 = _b[x3] // save coefficient of beta2 in r()
test (x2=0) (x3=0)					// F-test of beta1=beta2=0
return scalar fstat = r(F) 	// generate a scalar equal to the F-test statistic of the regression 
end

set seed 103
simulate constant= r(cons) ///
beta1=r(beta1) ///
beta2=r(beta2) ///
beta3=r(beta3) ///
Fstat = r(fstat), ///
rep(1000)  /// 1000 repetitions
saving(problem_set_1Q2, replace): prog_PS1Q2 

gen id = _n
scatter Fstat id, yline(3.091)
count if Fstat > 3.091
di r(N)/1000


