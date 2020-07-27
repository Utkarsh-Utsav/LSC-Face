%% This is the main script of fingerprint LSC which calls all the functions
clc;
clear;

%% Global Parameters
%[EER, confInterEER, OP, confInterOP, DI, xx, yy, xROC, yROC]=EER_DET(genscore,impscore,0.01,10000)
global n_sub n_bits n_block L K T ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n_sub = 10; % Number of subjects in the database
n_bits = 32256; % Number of bits in the original IrisCode
n_block = 12; % Number of Blocks in each IrisCode
 L = 100; % Number of Hash functions/Hash Tables
K = 30; % Size of each Hash function
T = 0.75; % Threshold(security) parameter 
% 
% 
hashGenerate(n_sub,n_bits,n_block,L,K,T);
LSCGenerate(n_sub,n_bits,n_block,L,K,T);
compare(n_sub,n_bits,n_block,L,K,T,2);
compare(n_sub,n_bits,n_block,L,K,T,1);
% % 
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 
% % 
% % 
% %L = 100; % Number of Hash functions/Hash Tables
% K = 30; % Size of each Hash function
% T = 0.25; % Threshold(security) parameter 
% hashGenerate(n_sub,n_bits,n_block,L,K,T);
% LSCGene
% rate(n_sub,n_bits,n_block,L,K,T);
% compare(n_sub,n_bits,n_block,L,K,T,1);
% compare(n_sub,n_bits,n_block,L,K,T,2);
% % % 
% % % 
% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % 
% % % 
% % %L = 100; % Number of Hash functions/Hash Tables
% K = 30; % Size of each Hash function
% T = 0.5; % Threshold(security) parameter 
% % 
% hashGenerate(n_sub,n_bits,n_block,L,K,T);
% LSCGenerate(n_sub,n_bits,n_block,L,K,T);
% compare(n_sub,n_bits,n_block,L,K,T,1);
% compare(n_sub,n_bits,n_block,L,K,T,2);
% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% K = 20; % Size of each Hash function
% T = 0.75; % Threshold(security) parameter 
% hashGenerate(n_sub,n_bits,n_block,L,K,T);
% LSCGenerate(n_sub,n_bits,n_block,L,K,T);
% compare(n_sub,n_bits,n_block,L,K,T,1);
% compare(n_sub,n_bits,n_block,L,K,T,2);
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% 
% 
% % %L = 100; % Number of Hash functions/Hash Tables
% % K = 20; % Size of each Hash function
% % T = 0.25; % Threshold(security) parameter 
% % hashGenerate(n_sub,n_bits,n_block,L,K,T);
% % LSCGenerate(n_sub,n_bits,n_block,L,K,T);
% % compare(n_sub,n_bits,n_block,L,K,T,1);
% % compare(n_sub,n_bits,n_block,L,K,T,2);
% % % 
% % % 
% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % 
% % % 
% % %L = 100; % Number of Hash functions/Hash Tables
% % K = 20; % Size of each Hash function
% % T = 0.50; % Threshold(security) parameter 
% % hashGenerate(n_sub,n_bits,n_block,L,K,T);
% % LSCGenerate(n_sub,n_bits,n_block,L,K,T);
% % compare(n_sub,n_bits,n_block,L,K,T,1);
% % compare(n_sub,n_bits,n_block,L,K,T,2);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% 
% % %L = 100; % Number of Hash functions/Hash Tables
% % K = 15; % Size of each Hash function
% % T = 0.75; % Threshold(security) parameter 
% % hashGenerate(n_sub,n_bits,n_block,L,K,T);
% % LSCGenerate(n_sub,n_bits,n_block,L,K,T);
% % compare(n_sub,n_bits,n_block,L,K,T,1);
% % compare(n_sub,n_bits,n_block,L,K,T,2);
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %L = 100; % Number of Hash functions/Hash Tables
% K = 15; % Size of each Hash function
% T = 0.50; % Threshold(security) parameter 
% hashGenerate(n_sub,n_bits,n_block,L,K,T);
% LSCGenerate(n_sub,n_bits,n_block,L,K,T);
% compare(n_sub,n_bits,n_block,L,K,T,1);
% compare(n_sub,n_bits,n_block,L,K,T,2);
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %L = 100; % Number of Hash functions/Hash Tables
% K = 15; % Size of each Hash function
% T = 0.25; % Threshold(security) parameter 
% hashGenerate(n_sub,n_bits,n_block,L,K,T);
% LSCGenerate(n_sub,n_bits,n_block,L,K,T);
% compare(n_sub,n_bits,n_block,L,K,T,1);
% compare(n_sub,n_bits,n_block,L,K,T,2);
% 
% 
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 
% % L = 100; % Number of Hash functions/Hash Tables
% % K = 10; % Size of each Hash function
% % T = 0.25; % Threshold(security) parameter 
% % hashGenerate(n_sub,n_bits,n_block,L,K,T);
% % LSCGenerate(n_sub,n_bits,n_block,L,K,T);
% % compare(n_sub,n_bits,n_block,L,K,T,1);
% % compare(n_sub,n_bits,n_block,L,K,T,2);
% % 
% % 
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 
% % L = 100; % Number of Hash functions/Hash Tables
% % K = 10; % Size of each Hash function
% % T = 0.50; % Threshold(security) parameter 
% % hashGenerate(n_sub,n_bits,n_block,L,K,T);
% % LSCGenerate(n_sub,n_bits,n_block,L,K,T);
% % compare(n_sub,n_bits,n_block,L,K,T,1);
% % compare(n_sub,n_bits,n_block,L,K,T,2);
% % 
% % 
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 
% % 
% % L = 100; % Number of Hash functions/Hash Tables
% % K = 10; % Size of each Hash function
% % T = 0.75; % Threshold(security) parameter 
% % hashGenerate(n_sub,n_bits,n_block,L,K,T);
% % LSCGenerate(n_sub,n_bits,n_block,L,K,T);
% % compare(n_sub,n_bits,n_block,L,K,T,1);
% % compare(n_sub,n_bits,n_block,L,K,T,2);
% 
% 
% 
