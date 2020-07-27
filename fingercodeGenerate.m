%% This is the function which generates the binary codes for fingerprints

clc;
clear;
close all;

datab = 'FVC2004-DB3'; % The Iris database used
method = 'ZT'; % The binarization technique used
n_sub = 100; % The number of subjects in the database

if (strcmp(method,'ZT'))
    tkpca_zt(n_sub,datab,method);
else
    tkpca_dq(n_sub,datab,method);
end


