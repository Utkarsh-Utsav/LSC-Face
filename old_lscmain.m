clc;
clear;

%% Global Parameters
global n_sub n_bits n_block L K T;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n_sub = 5; % Number of subjects in the database
n_bits = 576*768; % Number of bits in the original IrisCode
n_block = 48 ; % Number of Blocks in each IrisCode
L = 50; % Number of Hash functions/Hash Tables
K = 20; % Size of each Hash function
T = 0.40; % Threshold(security) parameter 
 hashGenerateg(n_sub,n_bits,n_block,L,K,T);
 LSCGenerateg(n_sub,n_bits,n_block,L,K,T);
compare_GENUINE(n_sub,n_bits,n_block,L,K,T);

 hashGenerate(n_sub,n_bits,n_block,L,K,T);
 LSCGenerate(n_sub,n_bits,n_block,L,K,T);
compare(n_sub,n_bits,n_block,L,K,T,2);