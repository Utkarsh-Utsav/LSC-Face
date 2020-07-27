function compare_GENUINE(n_sub,n_bits,n_block,L,K,T,datab,method)

%% This programme compares two LSC features generated from binarized fingerprints (FVC Protocol)
clc;

% Switch case for ease of operation
fprintf(' For GENUINE COMPARISON\n');


%% Genuine Comparison
fprintf('-------GENUINE COMPARISON-------\n');
for num = 1:n_sub
    fprintf('Subject: %d \n',num);

    % Estimating the number of samples for every subject
    %file = strcat('D:\bsif_code_and_data\lsccode\',num2str(num),'.mat');
    m = 4;
    count =  1;
    filenamea = strcat('D:\bsif_code_and_data\lsccode\',num2str(num),'-',num2str(1),'.mat');
    hash_a = load(filenamea);        % Hash codes of the 1st sample
    for j = 2:m
        filenameb = strcat('D:\bsif_code_and_data\lsccode\',num2str(num),'-',num2str(j),'.mat');
        hash_b = load(filenameb);    % Hash codes of the 2nd sample

        for k = 1:n_block
            for l = 1:L
                set_a(l) = hash_a.M{l}(k);
                set_b(l) = hash_b.M{l}(k);
            end
            if size(setdiff(set_a,set_b),2) == L
                jac(k) = 1;
            else
                jac(k) = 0;
            end
        end
        genscore(count) = mean(jac);    
        fprintf('Score between %d - %d and %d - %d is %d \n',num,1,num,j,genscore(count));  
        count = count+1;
    end
    fprintf('\nMean Genuine Score for %d is: %d\n',num,mean(genscore));
end
gen_filename = strcat( 'D:\bsif_code_and_data\result','\gscore_',num2str(L),'-',num2str(K),'-',num2str(T),'.mat');
save(gen_filename,'genscore');
fprintf('\nMean Genuine Score is: %d\n',mean(genscore));


