function tkpca_zt(n_sub,datab,method)
%% Generate the binary features (TKPCA-ZT)

for num = 1:n_sub
    fprintf('Building Binary Fingerprint Code of Subject: %d',num);
    for ii = 4:8
        file = strcat(pwd,'\Data\realdata\', num2str(num), '_', num2str(ii),'.mat');
        load(file);
        clearvars temp
        for iii = 1:size(Ftemplate,2)
            if(Ftemplate(iii)>= 0)
                temp(iii) = 1;
            else
                temp(iii) = 0;
            end
        end
        BinTemp(ii-3,:) = temp;
    end
    file = strcat(pwd,'\Data\bincode\',datab,'\',method,'\','code',num2str(num),'.mat');
    save(file,'BinTemp');
    disp('...done...');
end

end

