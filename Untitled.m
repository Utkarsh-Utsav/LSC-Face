clc;
clearvars ;
count = 1;
n_sub = 9; % Number of subjects in the database
n_bits = 576*768; % Number of bits in the original IrisCode
n_block =12 ; % Number of Blocks in each IrisCode
L = 100; % Number of Hash functions/Hash Tables
K = 10; % Size of each Hash function
T = 0.15; % Threshold(security) parameter 
sw =2;
count = 1;
for num = 1:n_sub-1
    filenamea = strcat('F:\bsif_code_and_data\lsccode\',num2str(1),'-',num2str(1));
    hash_a = load(filenamea); 
    for i = num+1:n_sub
        if (i ~= num)
            filenameb = strcat('F:\bsif_code_and_data\lsccode\',num2str(2),'-',num2str(1));
            hash_b = load(filenameb);    % Hash codes of the 2nd sample
            for k = 1:n_block
               for l = 1:L
                   set_a(l) = hash_a.M{l}(k);
                   set_b(l) = hash_b.M{l}(k);
               end
               jac(k) = size(setdiff(set_a,set_b),2);
            end;
            impscore(count) = mean(jac); 
           fprintf('Score between %d - %d and %d - %d is %d \n',num,1,i,1,impscore(count));  
           count = count+1;
        end
    end
    fprintf('....done....\n');
end
       
    

for k = 1:n_block
   for l = 1:L
         set_a(l) = hash_a.M{l}(k);
         set_b(l) = hash_b.M{l}(k);
   end
   jac(k) = size(setdiff(set_a,set_b),2 );
end
impscore(count) = mean(jac); 
fprintf('%d',impscore(count));