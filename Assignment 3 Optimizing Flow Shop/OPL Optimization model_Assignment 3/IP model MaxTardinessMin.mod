/*********************************************
 * OPL 22.1.1.0 Model
 * Author: springnuance
 * Creation Date: 21 Feb 2024 at 19.04.38
 *********************************************/


int I = ...; 				// Number of jobs 
int K = ...; 				// Number of process stages
int M = ...;				// Large number M
 
float P[1..I][1..K] = ...;
float DD[1..I] = ...;

dvar float+ t[1..I][1..K];  		// Starting times of jobs on machines
dvar boolean y[1..I][1..I][1..K]; 	// Takes value 1, if job i is before job j on machine k
dvar float+ f[1..I]; 			// Tardiness of job i

// Objective: Minimization of max of tardinesses
minimize max (i in 1..I)f[i];

// Constraints:
subject to{

    // Tardiness at the last machine K for all jobs i
    forall (i in 1..I) t[i][K] + P[i][K] - DD[i] <= f[i]; 
    
    // Line: job may only be started on machine k+1 after it has finished on machine k  
    forall (i in 1..I, k in 1..K-1) t[i][k] + P[i][k] <= t[i][k+1];          

    // If y[i][j][k] is 0, job i is processed after job j has finished on machine k
    forall (i in 1..I-1, j in i+1..I, k in 1..K) M * y[i][j][k] + (t[i][k] - t[j][k]) >= P[j][k];  

    // If y[i][j][k] is 1, job j is processed after job i  has finished on machine k
    forall (i in 1..I-1, j in i+1..I, k in 1..K) M * (1-y[i][j][k]) + (t[j][k] - t[i][k]) >= P[i][k]; 
}