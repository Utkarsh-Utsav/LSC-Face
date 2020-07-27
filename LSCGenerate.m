function LSCGenerate (n_sub,n_bits,n_block,L,K,T)

%% This is the main function which generates the LSC features for fingerprints

%% Pre-computations
blocksize = n_bits/n_block; % Size of each block
T1 = floor(T*(2^K)); % Threshold(security) parameter 


%% Delete previous files (if any)
myFolder = strcat('D:\bsif_code_and_data\hashcode');
if ~isdir(myFolder)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return;
end
filePattern = fullfile(myFolder, '*.mat'); % Change to whatever pattern you need.
theFiles = dir(filePattern);
for k = 1 : length(theFiles)
  baseFileName = theFiles(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  delete(fullFileName);
end


%% Create the LSC features
for num = 1:n_sub         
 
    clearvars -except num n_sub n_rel n_bits n_block blocksize L K T T1 datab method
    
    % Load the fingerprint code
    file = strcat('D:\bsif_code_and_data\bsif_code\',num2str(num),'.mat');
    load(file);
    m = size(BinTemp,1);
    % Load the Hash function
    %%file = strcat('D:\bsif_code_and_data\hashfunction\fn',num2str(num),'.mat');
    file = strcat('D:\bsif_code_and_data\hashfunction\fn',num2str(1),'.mat');
    load(file);
    
    % Computing the Hash codes
    fprintf('Building Hash Code of Subject: %d',num);
    for k = 1:m          
        
        % Breaking the IrisCode into blocks
        code = BinTemp(k,:);
        mat = vec2mat(code,blocksize);
        matarr = ones(1,n_block);
        cellblock = mat2cell(mat,matarr);
        
        % Pre-declare the arrays
        temp = [];
        hash = [];
        blocknum = [];

        % Generate the Hash value for each block
        for i = 1:L         
            for j = 1:n_block   
                block = cellblock{j,1};
                temp(i,j) = bi2de(block(hashseq(i,:)),'left-msb');
                hash(i,j) = mod(temp(i,j),T1);                 % Modulo thresholding
                blocknum(i,j) = j;                       % For Key based indexing in Map data structure
            end
            
            % Creating a Map (Hash Table) for all the hashes of each block
            M{i} = containers.Map(blocknum(i,:),hash(i,:));
        end
        
        file_name = strcat('D:\bsif_code_and_data\lsccode\',num2str(num),'-',num2str(k),'.mat');
        save(file_name,'M');
   
    end
    fclose('all');
    disp('...done...');    
    
end
    
clear;
clc;

end
