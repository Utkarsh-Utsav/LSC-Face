%% This programme creates hashes, compares and generates scores for the Stolen_Token scenario
clc;
clear;

%% Global Parameters
global n_sub n_bits n_block L K T datab method;
n_sub = 134; % Number of subjects in the database
n_bits = 442368; % Number of bits in the original IrisCode
n_block = 6; % Number of Blocks in each IrisCode
 L = 150; % Number of Hash functions/Hash Tables
K = 30; % Size of each Hash function
T = 0.50; % Threshold(security) parameter 
datab = 'FVC2004-DB3'; % The Iris database used
method = 'ZT';     % The feature extractor used

T1 = floor(T*(2^K)); 
blocksize = n_bits/n_block; % Size of each block

%% Switch case for operation
fprintf('1 For PART A: Local Hash Generation\n');
fprintf('2 For PART B: LSC Feature Creation\n');
fprintf('3 For PART C: Stolen-Token Matching\n');
sw = input('Enter a number: ');

switch sw

    case 1

    %% Part A: Generate a single permutation token for all the users
    
    fprintf('------------LOCAL HASH GENERATION------------\n');

    % Delete previous files (if any)
    myFolder = strcat('D:\bsif_code_and_data\hashfunction');
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

    % Generate the permutation token
    for k = 1:L
        hashseq(k,:) = randi([1 blocksize],1,K);     
    end
    file_name = strcat('D:\bsif_code_and_data\hashfunction\fn',num2str(1),'-',num2str(1),'.mat');
    save(file_name,'hashseq');
    fprintf('Token created...\n');    
    
    
    case 2
    %% Part B: Create the LSC features for each finger-code by utlizing the different permutation tokens generated in Part A

    fprintf('------------LSC Feature Generation------------\n');
    
    % Delete previous files (if any)
    myFolder = strcat('D:\bsif_code_and_data\lsccode');
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

    % Create the LSC features
    for num = 1:n_sub
        clearvars -except num n_sub n_bits n_block blocksize L K T T1 datab method
    
        % Load the fingerprint code
        file = strcat('D:\bsif_code_and_data\bsif_code\',num2str(num),'.mat');
        load(file);
        m = size(BinTemp,1);
    
        % Load the Hash token
        file = strcat('D:\bsif_code_and_data\hashfunction\fn',num2str(1),'-',num2str(1),'.mat');
        load(file);
        
        % Computing the Hash codes
        fprintf('Building Hash Code of Subject: %d',num);
        for k = 1:m          
        
            % Breaking the fingerprint code into blocks
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
        disp('...done...');    
    end
    
    
    case 3
    %% Part C: Comparison in the Stolen-Token scenario
    
    fprintf('------------STOLEN-TOKEN SCENARIO------------\n');
    
    % Genuine Comparison
    clc;
    clearvars -except n_sub n_block L K T genscore datab method
    count = 1;
    
    fprintf('-------GENUINE COMPARISON-------\n');
    
    for num = 1:n_sub
        
        fprintf('Subject: %d \n',num);
    
        % Estimating the number of samples for every subject
        file = strcat('D:\bsif_code_and_data\bsif_code\',num2str(num),'.mat');
        load(file);
        m = size(BinTemp,1);
        
        for i = 1:m-1
            % Load the LSC features
            filenamea = strcat('D:\bsif_code_and_data\lsccode\',num2str(num),'-',num2str(i));
            hash_a = load(filenamea);        % Hash codes of the 1st sample
    
            for j = i+1:m
                filenameb = strcat('D:\bsif_code_and_data\lsccode\',num2str(num),'-',num2str(j));
                hash_b = load(filenameb);    % Hash codes of the 2nd sample
                for k = 1:n_block
                    for l = 1:L
                        set_a(l) = hash_a.M{l}(k);
                        set_b(l) = hash_b.M{l}(k);
                    end
                    jac(k) = setdiff(set_a,set_b); 
                end
                genscore(count) = mean(jac);    
                fprintf('Genuine Score between %d - %d and %d - %d is: %d \n',num,i,num,j,genscore(count));  
                count = count+1;
            end
        end
        fprintf('....done....\n');    
    end
    gen_filename = strcat('D:\bsif_code_and_data\Stolen Token\gscore_',num2str(L),'-',num2str(K),'-',num2str(T),'.mat');
    save(gen_filename,'genscore');
    fprintf('\nMean Genuine Score is: %d\n',mean(genscore));
    
    
    %% Impostor Comparison
    clearvars -except n_sub n_block L K T genscore datab method
    count = 1;

    fprintf('-------IMPOSTOR COMPARISON-------\n');

    for num = 1:n_sub-1
        fprintf('Subject: %d \n',num);
        filenamea = strcat('D:\bsif_code_and_data\lsccode\',num2str(num),'-',num2str(1));
        hash_a = load(filenamea);        % Hash codes of the 1st sample
            
        for i = num+1:n_sub
                           
            % Estimate number of intra-class samples
            file = strcat('D:\bsif_code_and_data\bsif_code\',num2str(num),'.mat');
            load(file);
            m = size(BinTemp,1);
  
            filenameb = strcat('D:\bsif_code_and_data\lsccode\',num2str(i),'-',num2str(2));
            hash_b = load(filenameb);    % Hash codes of the 2nd sample
            for k = 1:n_block
                for l = 1:L
                    set_a(l) = hash_a.M{l}(k);
                    set_b(l) = hash_b.M{l}(k);
                end
                jac(k) = setdiff(set_a,set_b); 
            end
            impscore(count) = mean(jac); 
            fprintf('Impostor Score between %d - %d and %d - %d is: %d \n',num,1,i,2,impscore(count));  
            count = count+1;
        end
        fprintf('....done....\n');
    end
    imp_filename = strcat('D:\bsif_code_and_data\Stolen Token\iscore_',num2str(L),'-',num2str(K),'-',num2str(T),'.mat');
    save(imp_filename,'impscore');
    fprintf('\nMean Impostor Score is: %d\n',mean(impscore));
    
    
    case 4
      
    fprintf('Wrong Choice !!\n');
    
end
        
    
  