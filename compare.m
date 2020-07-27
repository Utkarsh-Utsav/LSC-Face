function compare(n_sub,n_bits,n_block,L,K,T,sw)

%% This programme compares two LSC features generated from binarized fingerprints (FVC Protocol)
count = 1;

% Switch case for ease of operation
fprintf('1 For GENUINE COMPARISON\n');
fprintf('2 For IMPOSTOR COMPARISON\n');
%sw = input('Enter a number: ');

switch sw
    case 1
        %% Genuine Comparison
        fprintf('-------GENUINE COMPARISON-------\n');
        for num = 1:n_sub
            fprintf('Subject: %d \n',num);
    
            % Estimating the number of samples for every subject
            file = strcat('D:\bsif_code_and_data\bsif_code\',num2str(num),'.mat');
            load(file);
            %m = size(BinTemp,1);
            m = 10;

            for i = 1:m-1
                filenamea = strcat('D:\bsif_code_and_data\lsccode\',num2str(num),'-',num2str(i),'.mat');
                hash_a = load(filenamea);        % Hash codes of the 1st sample
                for j = i+1:m
                    filenameb = strcat('D:\bsif_code_and_data\lsccode\',num2str(num),'-',num2str(j),'.mat');
                    hash_b = load(filenameb);    % Hash codes of the 2nd sample

                    for k = 1:n_block
                        for l = 1:L
                            set_a(l) = hash_a.M{l}(k);
                            set_b(l) = hash_b.M{l}(k);
                        end
                        jac(k) = setdiff(set_a,set_b); 
                    end
                    genscore(count) = mean(jac);    
                    fprintf('Score between %d - %d and %d - %d is %d \n',num,i,num,j,genscore(count));  
                    count = count+1;
                end
            end
            fprintf('....done....\n');
            fclose('all');
        end
        gen_filename = strcat('D:\bsif_code_and_data\result\genscore-',num2str(L),'-',num2str(K),'-',num2str(T),'.mat');
        save(gen_filename,'genscore');
        fprintf('\nMean Genuine Score is: %d\n',mean(genscore));

    case 2
    
        %% Impostor Comparison
        clc;
        clearvars -except n_sub n_block L K T genscore datab method
        count = 1;

        fprintf('-------IMPOSTOR COMPARISON-------\n');
        %for np = 1:13
        for np = 1:1
	        for num = 1:n_sub-1
	            fprintf('Subject: %d \n',num);
	            filenamea = strcat('D:\bsif_code_and_data\lsccode\',num2str(num),'-',num2str(np),'.mat');
	            hash_a = load(filenamea);        % Hash codes of the 1st sample
	            
	            for i = num+1:n_sub
	                if (i ~= num)
	                    
	                   % Estimate number of intra-class samples
	                   file = strcat('D:\bsif_code_and_data\bsif_code\',num2str(num),'.mat');
	                   load(file);
	                   %m = size(BinTemp,1);
                       m = 10;
	  
	                   %%filenameb = strcat('D:\bsif_code_and_data\lsccode\',num2str(i),'-',num2str(np),'.mat');
                       filenameb = strcat('D:\bsif_code_and_data\lsccode\',num2str(i),'-',num2str(2),'.mat');
	                   hash_b = load(filenameb);    % Hash codes of the 2nd sample
	                   for k = 1:n_block
	                       for l = 1:L
	                             set_a(l) = hash_a.M{l}(k);
	                             set_b(l) = hash_b.M{l}(k);
	                       end
	                       jac(k) = setdiff(set_a,set_b); 
	                   end
	                   impscore(count) = mean(jac); 
	                   fprintf('Score between %d - %d and %d - %d is %d \n',num,np,i,2,impscore(count));  
	                   count = count+1;
	                   
	                end
	            end
	            fprintf('....done....\n');
            end
        end
        imp_filename = strcat('D:\bsif_code_and_data\result\iscore_',num2str(L),'-',num2str(K),'-',num2str(T),'.mat');
        save(imp_filename,'impscore');
        fprintf('\nMean Impostor Score is: %d\n',mean(impscore));
        fclose('all');
    case 3
        
        fprintf('Wrong Choice !!\n');
end

end













