function hashGenerate (n_sub,n_bits,n_block,L,K,T)

%% This programme generates distinct Hash sequences for every user in a Iris database

blocksize = n_bits/n_block; 

% Delete previous files (if any)
myFolder = strcat('D:\bsif_code_and_data\hashfunction');
if ~isdir(myFolder)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return;
end
filePattern = fullfile(myFolder, '*.mat'); 
theFiles = dir(filePattern);
for k = 1 : length(theFiles)
  baseFileName = theFiles(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  delete(fullFileName);
end


%% Hash sequence creation
for num = 1:n_sub       
    fprintf('Creation of Hash Sequence of user %d',num);
    % Randomly generate a sequence of 'L' set of indices size K (which would act as the Hash functions)
    for i = 1:L
        hashseq(i,:) = randperm(blocksize,K);
%        hashseq(i,:) = randi([1 blocksize],1,K);     
    end
    file_name = strcat('D:\bsif_code_and_data\hashfunction\fn',num2str(num),'.mat');
    save(file_name,'hashseq');
    fprintf('...done...\n');  
end
clear;
clc;
end
