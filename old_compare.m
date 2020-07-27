function compare(n_sub,n_bits,n_block,L,K,T,sw)
%% This programme compares two LSC features generated from binarized fingerprints (FVC Protocol)
clc;
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
            %file = strcat('D:\bsif_code_and_data\lsccode\',num2str(num),'.mat');
            m = 14;

            for i = 1:m-1
                filenamea = strcat('D:\bsif_code_and_data\lsccode\',num2str(num),'-',num2str(i),'.mat');
                hash_a = load(filenamea);        % Hash codes of the 1st sample
                for j = i+1:m
                    filenameb = strcat('D:\bsif_code_and_data\lsccode\',num2str(num),'-',num2str(i),'.mat');
                    hash_b = load(filenameb);    % Hash codes of the 2nd sample

                    for k = 1:n_block
                        for l = 1:L
                            set_a(l) = hash_a.M{l}(k);
                            set_b(l) = hash_b.M{l}(k);
                        end
                        jac(k) = size(setdiff(set_a,set_b),2);
                    end
                    genscore(count) = mean(jac);    
                    fprintf('Score between %d - %d and %d - %d is %d \n',num,i,num,j,genscore(count));  
                    count = count+1;
                end
            end
            fprintf('....done....\n');
        end
        gen_filename = strcat( 'D:\bsif_code_and_data\result','\gscore_',num2str(L),'-',num2str(K),'-',num2str(T),'.mat');
        save(gen_filename,'genscore');
        fprintf('\nMean Genuine Score is: %d\n',mean(genscore));

    case 2
    
        %% Impostor Comparison
        clc;
        clearvars -except n_sub n_block L K T genscore datab method
        count = 1;

        fprintf('-------IMPOSTOR COMPARISON-------\n');

        for num = 1:n_sub-1
            fprintf('Subject: %d \n',num);
            filenamea = strcat('D:\bsif_code_and_data\lsccode\',num2str(num));
            hash_a = load(filenamea);        % Hash codes of the 1st sample
            
            for i = num+1:n_sub
                if (i ~= num)
                    
                   % Estimate number of intra-class samples
%                    file = strcat('F:\bsif_code_and_data\bsif_code\',num2str(num),'.mat');
%                    BinTemp = load(file);
%                    m = size(BinTemp,1);
  
                   filenameb = strcat('D:\bsif_code_and_data\lsccode\',num2str(i));
                   hash_b = load(filenameb);    % Hash codes of the 2nd sample
                   for k = 1:n_block
                       for l = 1:L
                             set_a(l) = hash_a.M{l}(k);
                             set_b(l) = hash_b.M{l}(k);
                       end
                       if size(setdiff(set_a,set_b),2) == L
                            jac(k) = 1; 
                       else
                           jac(k)= 0;
                       end
                   end
                   impscore(count) = mean(jac); 
                   fprintf('Score between %d - %d and %d - %d is %d \n',num,1,i,1,impscore(count));  
                   count = count+1;
                   
                end
            end
            fprintf('....done....\n');
        end
        imp_filename = strcat( 'D:\bsif_code_and_data\result','\iscore_',num2str(L),'-',num2str(K),'-',num2str(T),'.mat');
        save(imp_filename,'impscore');
        fprintf('\nMean Impostor Score is: %d\n',mean(impscore));
        
    case 3
        
        fprintf('Wrong Choice !!\n');
end

end













