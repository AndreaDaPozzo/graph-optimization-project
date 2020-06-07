
#PARAMETERS

#number of request for web services
param N; 

#ammount of traffic for request i
param w{1..N};

#computing capacity for request i
param cpu{1..N};

#memory for request i
param m{1..N};

#number of virtual machines
param M;

#maximum amount of traffic supported by a virtual machine
param B_c;

#overall computy capacity for a VM
param B_CPU;

#total memory available in a VM
param B_m;

#cost of installing a VM
param C;

			##################### 
			#  ILP FORMULATION  # 
			#####################

#VARIABLES

#x equals 1 if request i is assigned to a VM 
var x{1..N,1..M} binary;
			
#y equals 1 if VM j is activated
var y{1..M} binary;

#OBJECTIVE

#Objective function
minimize VM_Instal: 
	sum{j in 1..M} y[j];

#CONSTRAINTS

#assign each request i to a VM j
subject to Assign{i in 1..N}:
	sum{j in 1..M} x[i,j] = 1;

#capacity contrastraint 1: Traffic
subject to Traffic{j in 1..M}:
	sum{i in 1..N} w[i]*x[i,j] <= B_c;

#capacity contrastraint 2: CPU
subject to Cpu{j in 1..M}:
	sum{i in 1..N} cpu[i]*x[i,j] <= B_CPU;

#capacity contrastraint 3: Memory
subject to Memory{j in 1..M}:
	sum{i in 1..N} m[i]*x[i,j] <= B_m;

#consistency contstraint 
subject to Consistency{i in 1..N,j in 1..M}:
	x[i,j] <= y[j];
