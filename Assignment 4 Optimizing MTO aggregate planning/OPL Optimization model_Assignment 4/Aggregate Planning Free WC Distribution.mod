/*********************************************
 * OPL 22.1.1.0 Model
 * Author: springnuance
 * Creation Date: 23 Feb 2024 at 15.03.43
 *********************************************/

int I = ...;	//Only the rows differing from even WC distribution model are commented
int K = ...;
int T = ...;
int M = ...;	
int P[1..I] = ...;
int D[1..I] = ...;
int A[1..I] = ...;
float WC[1..I][1..K] = ...;

dvar int C[1..I];
dvar float+ R[1..I][1..K][1..T-4];
dvar float+ S[1..I][1..T-4];
dvar float+ f[1..K];
dvar boolean c[1..I][1..T];
dvar boolean X[1..I][1..T-4];	//Auxiliary variable that = 1 if work i is ongoing

minimize sum(k in 1..K)f[k];

subject to{
    forall (i in 1..I) C[i] == sum(t in 1..T) t * c[i][t];
	forall (i in 1..I) sum(t in 1..T) c[i][t] == 1;
	forall (i in 1..I) D[i] - C[i] >= 0;
	forall (i in 1..I) C[i] - P[i] >= A[i];
	forall (i in 1..I, t in 1..T-4) X[i][t] == sum(u in t..t+P[i]-1)c[i][u];  // setting of X
	forall (i in 1..I, k in 1..K, t in 1..T-4) R[i][k][t] <= M * X[i][t];	//Workload only if work i ongoing
	forall (i in 1..I, k in 1..K) sum(t in 1..T-4)R[i][k][t] == WC[i][k];
	forall (t in 1..T-4, k in 1..K) f[k] - sum(i in 1..I)R[i][k][t] >= 0;
	forall (i in 1..I, t in 1..T-4) S[i][t] == sum(k in 1..K)R[i][k][t]; 
	C[1] <= C[2] - P[2];
    	C[2] <= C[4] - P[4];
    	C[3] <= C[4] - P[4];
    	C[5] <= C[6] - P[6];
    	C[6] <= C[8] - P[8];
    	C[7] <= C[8] - P[8];
    	C[9] <= C[10] - P[10];
    	C[10] <= C[12] - P[12];
    	C[11] <= C[12] - P[12];
		C[13] <= C[14] - P[14];
    	C[14] <= C[16] - P[16];
    	C[15] <= C[16] - P[16];
    	C[17] <= C[18] - P[18];
    	C[18] <= C[20] - P[20];
    	C[19] <= C[20] - P[20];
    	C[21] <= C[22] - P[22];
    	C[22] <= C[24] - P[24];
    	C[23] <= C[24] - P[24];
    	C[25] <= C[26] - P[26];
    	C[26] <= C[28] - P[28];
    	C[27] <= C[28] - P[28];
    	C[29] <= C[30] - P[30];
    	C[30] <= C[32] - P[32];
    	C[31] <= C[32] - P[32];
    	C[33] <= C[34] - P[34];
    	C[34] <= C[36] - P[36];
    	C[35] <= C[36] - P[36];
    	C[37] <= C[38] - P[38];
    	C[38] <= C[40] - P[40];
    	C[39] <= C[40] - P[40];
}