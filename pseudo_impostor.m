%% This programme creates hashes, compares and generates scores for the Pseudo-Impostor distribution
clc;
clear;

%% Global Parameters
global n_sub n_bits n_block n_pi L K T datab method;
n_pi = 50; % Number of permutation tokens generated for each class in the pseudo-impostor scenario
n_sub = 134; % Number of subjects in the database
n_bits = 442368; % Number of bits in the original IrisCode
n_block = 6; % Number of Blocks in each IrisCode
 L = 150; % Number of Hash functions/Hash Tables
K = 30; % Size of each Hash function
T = 0.50; % Threshold(security) parameter 
datab = 'FVC2002-DB1'; % The Iris database used
method = 'ZT';     % The feature extractor used

T1 = floor(T*(2^K)); 
blocksize = n_bits/n_block; % Size of each block

%% Switch case for operation
fprintf('1 For PART A: Local Hash Generation\n');
fprintf('2 For PART B: LSC Feature Creation\n');
fprintf('3 For PART C: Pseudo-Impostor Matching\n');
sw = input('Enter a number: ');

switch sw

    case 1

    %% Part A: Generate 'n_pi' different permutation tokens for the first sample of each fingerprint 
    
    fprintf('------------LOCAL HASH GENERATION------------\n');

    % Delete previous files (if any)
    myFolder = strcat('D:\bsif_code_and_data\hashfunctionpi');
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

    % Create the random permutation tokens (hash functions)
    for num = 1:n_sub         
        
        clearvars -except num n_sub n_bits n_block n_pi blocksize L K T T1 datab method
        fprintf('Creation of Hash Sequence of user %d',num);
        
        for j = 1:n_pi 
            for k = 1:L
                hashseq(k,:) = randi([1 blocksize],1,K);     
            end
            hashseqcell{j} = hashseq(:,:);
        end
        
        file_name = strcat('D:\bsif_code_and_data\hashfunctionpi\fn',num2str(num),'.mat');
        save(file_name,'hashseqcell');
        fprintf('...done...\n');    
    end


    case 2
    %% Part B: Create 'n_pi' LSC features for the first sample in the database 
    
    fprintf('------------LSC Feature Generation------------\n');

    % Delete previous files (if any)
    myFolder = strcat('D:\bsif_code_and_data\lsccodepi');
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
        clearvars -except num n_sub n_rel n_bits n_block n_pi blocksize L K T T1 datab method
        fprintf('Subject No.: %d\n',num);
            
        % Load the fingerprint code
        file = strcat('D:\bsif_code_and_data\bsif_code\',num2str(num),'.mat');
        load(file);
        m = size(BinTemp,1);
        
        % Breaking the fingerprint code into blocks
        code = BinTemp(1,:);
        mat = vec2mat(code,blocksize);
        matarr = ones(1,n_block);
        cellblock = mat2cell(mat,matarr);
        
        % Load the local hash function cell
        file = strcat('D:\bsif_code_and_data\hashfunctionpi\fn',num2str(num),'.mat');
        load(file);
        
        % Computing the LSC codes
       
        for x = 1:n_pi % For 'n_pi' hashes for the same subject
                
            fprintf('Building LSC Code No.: %d - %d',num,x);
            
            % Load the particular hash sequence
            hashseq = hashseqcell{x};
                
            % Pre-declare the arrays
            temp = [];
            hash = [];
            blocknum = [];
            clearvars M
            
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
            MM{x} = M;
            disp('...done...');
            
        end
        file_name = strcat('D:\bsif_code_and_data\lsccodepi\',num2str(num),'.mat');
        save(file_name,'MM');
        
    end

    
    
    case 3
    %% Part C: Pseudo-Impostor comparison
    
    fprintf('------------PSEUDO-IMPOSTOR COMPARISON------------\n');
    count = 1;
    
    for num = 1:n_sub
        
        fprintf('--------- Subject: %d ---------\n',num);
        clearvars -except num n_sub n_block n_pi blocksize L K T T1 datab method count piscore
        % Load the hashcode
        load(strcat('D:\bsif_code_and_data\lsccodepi\',num2str(num)));
        hash_a = MM{1};        % Hash codes of the 1st sample
        
        for j = 2:n_pi
            hash_b = MM{j};    % Hash codes of the 2nd sample
            
            for k = 1:n_block
                for l = 1:L
                    set_a(l) = hash_a{l}(k);
                    set_b(l) = hash_b{l}(k);
                end
            jac(k) = setdiff(set_a,set_b); 
            end
            
            piscore(count) = mean(jac);    
            fprintf('Pseudo Impostor Score between (%d - %d , %d - %d): %d \n',num,1,num,j,piscore(count));  
            count = count+1;
        end
        fprintf('....done....\n');
    end
    pi_filename = strcat('D:\bsif_code_and_data\Pseudo Impostor\piscore_','num2str(L)','-',num2str(K),'-',num2str(T),'.mat');
    save(pi_filename,'piscore');
    fprintf('\nMean Pseudo Impostor Score is: %d\n',mean(piscore));
    fprintf('\nStandard Deviation of  Pseudo Impostor Score is: %d\n',std(piscore));
end




