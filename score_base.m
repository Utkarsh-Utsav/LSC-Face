function score_base()
n_sub = 30;
clearvars -except num n_sub n_rel n_bits n_block blocksize 
count = 1;
 for num = 1:n_sub  
    file = strcat('D:\bsif_code_and_data\hiscode\',num2str(num),'.mat');
    load(file);
    m = 9;
    for i = 1:m-1
        code1 = BinTemp(i,:);
         for j = i+1:m
             code2 = BinTemp(j,:);
             genscore(count) = sum(((code1-code2).^2)/(code1+code2))/2;
             count = count+1;  
         end
    end
 end
imp_filename = strcat('D:\bsif_code_and_data\result\base_genuine1','.mat');
save(imp_filename,'genscore');

clearvars -except num n_sub n_rel n_bits n_block blocksize 
count = 1;
for m = 1:9
    for num = 1:n_sub-1
        file = strcat('D:\bsif_code_and_data\hiscode\',num2str(num),'.mat');
        load(file);
        code1 = BinTemp(m,:);
        for i = num+1:n_sub
            file = strcat('D:\bsif_code_and_data\hiscode\',num2str(i),'.mat');
            load(file);
            code2 = BinTemp(m,:);
            impscore(count) =  sum(((code1-code2).^2)/(code1+code2))/2;
             count = count+1;
        end
    end
end
imp_filename = strcat('D:\bsif_code_and_data\result\base_imposter1','.mat');
save(imp_filename,'impscore');
