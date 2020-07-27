function mated_non_mated (n_sub,n_bits,n_block,L,K,T,datab,method,n_tokens,sw)

%% This function creates hashes, compares and generates scores for the mated/non-mated distribution 
clc;
blocksize = n_bits/n_block;
T1 = floor(T*(2^K)); 

%% Switch case for operation
 fprintf('----------------WELCOME TO MATED/NON-MATED SCORE GENERATION PROCESS----------------\n');
% fprintf('1 For ----------------------PART A: Local Hash Generation---------------------\n');
% fprintf('2 For ----------------------PART B: LSC Feature Creation----------------------\n');
% fprintf('3 For ----------------------PART C: Mated Score Generation----------------------\n');
% fprintf('4 For ----------------------PART D: Non-Mated Score Generation----------------------\n');
% sw = input('Enter a number: ');

switch sw

    case 1
    %% Part A: Generate six different permutation tokens for each fingerprint class
    fprintf('----------------------PART A: Hash Generation----------------------\n');
    
    % Delete previous files (if any)
    myFolder = strcat('D:\bsif_code_and_data\HashFunctionMN');
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
    
    % Create the 'n_tokens' random permutation tokens (hash functions)
    for num = 1:n_sub         
        clearvars -except num n_sub n_bits n_block blocksize L K T T1 datab method n_tokens
        fprintf('Creation of Hash Sequence of user %d',num);
        for i = 1:n_tokens 
            for k = 1:L
                hashseq(k,:) = randi([1 blocksize],1,K);     
            end
            file_name = strcat('D:\bsif_code_and_data\HashFunctionMN\fn',num2str(num),'-',num2str(i),'.mat');
            save(file_name,'hashseq');
        end
        fprintf('...done...\n');    
    end
    
    
    case 2
    %% Part B: Create 'n_tokens' LSC features for each IrisCode (using 1st sample)
    fprintf('----------------------PART B: LSC Feature Creation----------------------\n');

    % Delete previous files (if any)
    myFolder = strcat('D:\bsif_code_and_data\HashCodeMN');
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
        clearvars -except num n_sub n_bits n_block blocksize L K T T1 datab method n_tokens
    
        % Load the fingerprint-code
        file = strcat('D:\bsif_code_and_data\bsif_code\',num2str(num),'.mat');
        load(file);
        
        % Breaking the fingerprint code into blocks
        code = BinTemp(1,:);
        mat = vec2mat(code,blocksize);
        matarr = ones(1,n_block);
        cellblock = mat2cell(mat,matarr);
           
        for k = 1:n_tokens
            
            % Load the hash sequence
            load(strcat('D:\bsif_code_and_data\HashFunctionMN\fn',num2str(num),'-',num2str(k)));
            fprintf('Building LSC Feature No. %d of Subject %d',k,num);
            
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
            disp('...done...');
            file_name = strcat('D:\bsif_code_and_data\HashCodeMN\',num2str(num),'-',num2str(k),'.mat');
            save(file_name,'M');
        end
    end
    
    
    
    case 3
    %% Part C: Mated instance comparison and score generation
    fprintf('----------------------PART C: Mated Score Generation----------------------\n');
    
    count = 1;
    for num = 1:n_sub-1
        
        fprintf('Subject: %d \n',num);
        clearvars -except num n_sub n_rel n_bits n_block blocksize L K T T1 datab method count mated n_tokens
        
        for i = 1:n_tokens-1
            filenamea = strcat('D:\bsif_code_and_data\HashCodeMN\',num2str(num),'-',num2str(i));
            hash_a = load(filenamea);        % Hash codes of the 1st sample
            
            for j = i+1:n_tokens
                filenameb = strcat('D:\bsif_code_and_data\HashCodeMN\',num2str(num),'-',num2str(j));
                hash_b = load(filenameb);    % Hash codes of the 2nd sample
                for k = 1:n_block
                    for l = 1:L
                        set_a(l) = hash_a.M{l}(k);
                        set_b(l) = hash_b.M{l}(k);
                    end
                    jac(k) = setdiff(set_a,set_b); 
                end
                mated(count) = mean(jac);    
                fprintf('Mated Score between %d - %d and %d - %d is: %d \n',num,i,num,j,mated(count));  
                count = count+1;
            end
        end
       fprintf('....done....\n');
    end
    
    pi_filename = strcat('D:\bsif_code_and_data\Mated Non Mated','\mscore_',num2str(L),'-',num2str(K),'-',num2str(T),'.mat');
    save(pi_filename,'mated');
    fprintf('\nMean Mated Score is: %d\n',mean(mated));
    fprintf('\nStandard Deviation of Mated Score is: %d\n',std(mated));
    
    
    
    case 4
    %% Part D: Non-Mated instance comparison and score generation
    fprintf('----------------------PART D: Non-Mated Score Generation----------------------\n');
    
    count = 1;
    for num = 1:n_sub-1
        fprintf('Subject: %d \n',num);
        clearvars -except num n_sub n_rel n_bits n_block blocksize L K T T1 datab method count nonmated n_tokens
        
        for i = 1:n_tokens-1
            filenamea = strcat('D:\bsif_code_and_data\HashCodeMN\',num2str(num),'-',num2str(i));
            hash_a = load(filenamea);        % Hash codes of the 1st sample
            
            for j = i+1:n_tokens
                filenameb = strcat('D:\bsif_code_and_data\HashCodeMN\',num2str(num+1),'-',num2str(j));
                hash_b = load(filenameb);    % Hash codes of the 2nd sample
                for k = 1:n_block
                    for l = 1:L
                        set_a(l) = hash_a.M{l}(k);
                        set_b(l) = hash_b.M{l}(k);
                    end
                    jac(k) = setdiff(set_a,set_b); 
                end
                nonmated(count) = mean(jac);    
                fprintf('Non-Mated Score between %d - %d and %d - %d is: %d \n',num,i,num+1,j,nonmated(count));  
                count = count+1;
            end
        end
       fprintf('....done....\n');
    end
    pi_filename = strcat('D:\bsif_code_and_data\Mated Non Mated','\nmscore_',num2str(L),'-',num2str(K),'-',num2str(T),'.mat');
    save(pi_filename,'nonmated');
    fprintf('\nMean Non-Mated Score is: %d\n',mean(nonmated));
    fprintf('\nStandard Deviation of Non-Mated Score is: %d\n',std(nonmated));
    
end

end