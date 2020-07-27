function create_hist()

filter_filename=['D:/bsif_code_and_data/texturefilters/ICAtextureFilters_7x7_8bit'];
load(filter_filename, 'ICAtextureFilters');
row=576;  col=768;

for num = 1:9
	BinTemp = ones(13, 256);
    for k=1:13
        file_name = strcat('D:\bsif_code_and_data\test2\m-00',num2str(num),'-',num2str(k),'.raw');
        fin=fopen(file_name,'r');
		I=fread(fin,row*col,'uint8=>uint8'); 
		Z=reshape(I,col,row);
		img=Z';
		
		bsifhist=bsif(img,ICAtextureFilters,'nh');
		BinTemp(k,:) = bsifhist;
	end
	filename = strcat('D:\bsif_code_and_data\hiscode\',num2str(num),'.mat');
	save(filename,'BinTemp');
end
for num = 10:30
	BinTemp = ones(13, 256);
    for k=1:13
        file_name = strcat('D:\bsif_code_and_data\persons\m-0',num2str(num),'-',num2str(k),'.raw');
        
		fin=fopen(file_name,'r');
		I=fread(fin,row*col,'uint8=>uint8'); 
		Z=reshape(I,col,row);
		img=Z';
		bsifhist=bsif(img,ICAtextureFilters,'nh');
		BinTemp(k,:) = bsifhist;
	end
	filename = strcat('D:\bsif_code_and_data\hiscode\',num2str(num),'.mat');
	save(filename,'BinTemp');
end



		
