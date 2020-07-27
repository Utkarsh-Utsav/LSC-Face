%% This is the main program for calling the mated_non_mated function repeatedly


% Define the Global paremeters

%global n_sub n_bits n_block L K T datab method n_tokens;
n_sub = 134; % Number of subjects in the database
n_bits = 442368; % Number of bits in the original IrisCode
n_block = 6; % Number of Blocks in each IrisCode
 L = 150; % Number of Hash functions/Hash Tables
K = 30; % Size of each Hash function
T = 0.50; % Threshold(security) parameter 
datab = 'FVC2004-DB3'; % The Iris database used
method = 'ZT'; % The feature extractor used
n_tokens = 6; % The number of instances for each database


% Call the function

mated_non_mated (n_sub,n_bits,n_block,L,K,T,datab,method,n_tokens,1);
mated_non_mated (n_sub,n_bits,n_block,L,K,T,datab,method,n_tokens,2);
mated_non_mated (n_sub,n_bits,n_block,L,K,T,datab,method,n_tokens,3);
mated_non_mated (n_sub,n_bits,n_block,L,K,T,datab,method,n_tokens,4);

