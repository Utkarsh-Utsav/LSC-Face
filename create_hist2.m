function create_hist2()

filter_filename=['D:/bsif_code_and_data/texturefilters/ICAtextureFilters_7x7_8bit'];
load(filter_filename, 'ICAtextureFilters');
for num = 1:9
	BinTemp = ones(9, 256);
    for k=1:9
        file_name = strcat('D:\bsif_code_and_data\test2\M-00',num2str(num),'-0',num2str(k),'.bmp');
        img = imread(file_name);
        img = rgb2gray(img);
        bsifhist=bsif(img,ICAtextureFilters,'nh');
		BinTemp(k,:) = bsifhist;
    end
    filename = strcat('D:\bsif_code_and_data\hiscode\',num2str(num),'.mat');
	save(filename,'BinTemp');
end

for num = 10:30
	BinTemp = ones(9, 256);
    for k=1:9
        file_name = strcat('D:\bsif_code_and_data\test2\M-0',num2str(num),'-0',num2str(k),'.bmp');
        img = imread(file_name);
        img = rgb2gray(img);
        bsifhist=bsif(img,ICAtextureFilters,'nh');
		BinTemp(k,:) = bsifhist;
    end
    filename = strcat('D:\bsif_code_and_data\hiscode\',num2str(num),'.mat');
	save(filename,'BinTemp');
end

