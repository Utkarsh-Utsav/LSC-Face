%function tkpca_dq(n_sub)
clc;
clear;
n_sub = 10;
dim = 299;

%% Statistical Analysis
% Compute mean feature vector
for num = 1:n_sub
    for ii = 4:8
        file = strcat(pwd,'\Data\realdata\', num2str(num), '_', num2str(ii),'.mat');
        load(file);
        localMat(ii-3,:) = Ftemplate;
    end
    meanlocalMat(num,:) = mean(localMat);
end

% Compute grand mean vector
for ii = 4:8
    file = strcat(pwd,'\Data\realdata\', num2str(1), '_', num2str(ii),'.mat');
    load(file);
    localMatA(ii-3,:) = Ftemplate;
end
for num = 2:n_sub
    for ii = 4:8
        file = strcat(pwd,'\Data\realdata\', num2str(num), '_', num2str(ii),'.mat');
        load(file);
        localMat(ii-3,:) = Ftemplate;
    end
    localMatA = vertcat(localMatA,localMat);
end
meanglobalMat = mean(localMatA);

% Within-class variance vector
for num = 1:n_sub
    for ii = 4:8
        file = strcat(pwd,'\Data\realdata\', num2str(num), '_', num2str(ii),'.mat');
        load(file);
        localMat(ii-3,:) = Ftemplate;
    end
    withinVarMat(num,:) = var(localMat);
end

% Between-class variance vector
betweenVarMat = var(localMatA);

% Signal-to-Noise Ratio
for num = 1:n_sub
   eps(num,:) = rdivide(betweenVarMat,withinVarMat(num,:)); 
end

%% Reliability weight computation








%end

