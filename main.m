for num = 1:9
    for j=1:9
        file_name = strcat('D:\bsif_code_and_data\persons\m-00',num2str(num),'-',num2str(j),'.raw');
        bsifdemo_using_prelearnt_filters(file_name, num,j);
    end
end
for num = 1:9
    for j=10:13
        file_name = strcat('D:\bsif_code_and_data\persons\m-00',num2str(num),'-',num2str(j),'.raw');
        bsifdemo_using_prelearnt_filters(file_name, num,j);
    end
end
for num = 10:75
    for j=1:9
        file_name = strcat('D:\bsif_code_and_data\persons\m-00',num2str(num),'-',num2str(j),'.raw');
        bsifdemo_using_prelearnt_filters(file_name, num,j);
    end
end
for num = 10:75
    for j=9:13
        file_name = strcat('D:\bsif_code_and_data\persons\m-00',num2str(num),'-',num2str(j),'.raw');
        bsifdemo_using_prelearnt_filters(file_name, num,j);
    end
end
    