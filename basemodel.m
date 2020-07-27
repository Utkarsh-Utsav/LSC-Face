function basemodel ()

%% This is the main function which generates the LSC features for fingerprints
n_sub = 134; % Number of subjects in the database
n_bits = 442368; % Number of bits in the original IrisCode
n_block = 6;
%% Pre-computations
blocksize = n_bits/n_block; % Size of each block
clearvars -except num n_sub n_rel n_bits n_block blocksize 
count = 1
% for num = 1:n_sub  
%     file = strcat('D:\bsif_code_and_data\bsif_code\',num2str(num),'.mat');
%     load(file);
%     m = size(BinTemp,1);
%     for i = 1:m-1
%         code = BinTemp(i,:);
%         mat = vec2mat(code,blocksize);
%         matarr = ones(1,n_block);
%         cellblock1 = mat2cell(mat,matarr);
%         for j = i+1:m
%             code = BinTemp(j,:);
%             mat = vec2mat(code,blocksize);
%             matarr = ones(1,n_block);
%             cellblock2 = mat2cell(mat,matarr);
%             for k = 1:n_block
%                 block1 = cellblock1{k,1};
%                  block2 = cellblock2{k,1};
%                 D(k) = pdist2(block1,block2,'hamming');    
%             end
%             genscore(count) = mean(D);
%             fprintf('Score between %d - %d and %d - %d is %d \n',num,i,num,j,genscore(count));  
%             count = count+1;                            
%         end
%     end
% end
% imp_filename = strcat('D:\bsif_code_and_data\result\base_genuine','.mat');
% save(imp_filename,'genscore');
% fprintf('\nMean Genuine Score is: %d\n',mean(genscore));

clearvars -except num n_sub n_rel n_bits n_block blocksize 
count = 1
for m = 1:13
    for num = 1:n_sub-1
        file = strcat('D:\bsif_code_and_data\bsif_code\',num2str(num),'.mat');
        load(file);
        code = BinTemp(m,:);
        mat = vec2mat(code,blocksize);
        matarr = ones(1,n_block);
        cellblock1 = mat2cell(mat,matarr);
        for i = num+1:n_sub
            file = strcat('D:\bsif_code_and_data\bsif_code\',num2str(i),'.mat');
            load(file);
            code = BinTemp(m,:);
            mat = vec2mat(code,blocksize);
            matarr = ones(1,n_block);
            cellblock2 = mat2cell(mat,matarr);
            for k = 1:n_block
                block1 = cellblock1{k,1};
                block2 = cellblock2{k,1};
                D(k) = pdist2(block1,block2,'hamming');    
            end
            impscore(count) = mean(D);
            fprintf('Score between %d - %d and %d - %d is %d \n',num,m,i,m,impscore(count));  
            count = count+1;
        end
    end
end
imp_filename = strcat('D:\bsif_code_and_data\result\base_imposter','.mat');
save(imp_filename,'impscore');
fprintf('\nMean Impostor Score is: %d\n',mean(impscore));
fclose('all');


