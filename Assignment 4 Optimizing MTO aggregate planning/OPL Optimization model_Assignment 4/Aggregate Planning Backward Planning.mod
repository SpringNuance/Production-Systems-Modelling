/*********************************************
 * OPL 22.1.1.0 Model
 * Author: springnuance
 * Creation Date: 23 Feb 2024 at 15.03.43
 *********************************************/

int I = ...;
int K = ...;
int T = ...;

int P[1..I] = ...;	// Job durations
int D[1..I] = ...;	// Due dates of orders
int A[1..I] = ...;	// Earliest starting times of orders
float WC[1..I][1..K] = ...;	// Work contents of jobs

dvar int C[1..I];	// Completion times of jobs, auxiliary variable
dvar float+ R[1..I][1..K][1..T-4];	// Resource workloads form jobs
dvar float+ f[1..K];		// Resource load peaks
dvar boolean c[1..I][1..T];	// Job completion indicator
dvar float S[1..I][1..T-4];	// Job workload, auxiliary variable for drawing resource profiles

maximize sum(i in 1..I)(C[i] - P[i]);	// Maximizing sum of starting time (as late as possible)

subject to{
    forall (i in 1..I) C[i] == sum(t in 1..T) t * c[i][t];	// Setting completion time
	forall (i in 1..I) sum(t in 1..T) c[i][t] == 1;	// Jobs are completed once
	forall (i in 1..I) D[i] - C[i] >= 0;	// Due date must be respected
	forall (i in 1..I) C[i] - P[i] >= A[i];	// Earliest possible starting time
	forall (i in 1..I, k in 1..K, t in 1..T-4) R[i][k][t] == WC[i][k]/P[i] * sum(u in t..t+P[i]-1)c[i][u];	// Load calculation
	forall (t in 1..T-4, k in 1..K) f[k] - sum(i in 1..I)R[i][k][t] >= 0;	// Setting of load peak
	forall (i in 1..I, t in 1..T-4) S[i][t] == sum(k in 1..K)R[i][k][t];	// Setting of S
}