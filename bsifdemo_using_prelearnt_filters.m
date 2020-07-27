function bsifdemo_using_prelearnt_filters()

filter_filename=['D:/bsif_code_and_data/texturefilters/ICAtextureFilters_11x11_8bit'];
load(filter_filename, 'ICAtextureFilters');
row=576;  col=768;
for num = 1:9
	BinTemp = ones(13, 442368);
    for k=1:13
        file_name = strcat('D:\bsif_code_and_data\persons\m-00',num2str(num),'-',num2str(k),'.raw');
        
		fin=fopen(file_name,'r');
		I=fread(fin,row*col,'uint8=>uint8'); 
		Z=reshape(I,col,row);
		img=Z';
		bsifcodeim= bsif(img,ICAtextureFilters,'im');
		% unnormalized BSIF code word histogram
		bsifhist=bsif(img,ICAtextureFilters,'h');
		% normalized BSIF code word histogram
		bsifhistnorm=bsif(img, ICAtextureFilters,'nh');
		b = reshape(cellstr(dec2bin(bsifcodeim)), size(bsifcodeim));
		% S=size(b,1)*size(b,2);
		% V = reshape(b,1,S);
		% for i = 1:size(V,2)
		%     temp = char(V(i));
		%     for j = 2:9
		%         a((i-1)*8 + (j-1))=temp(j);
		%     end
		% end
		% size(a)
		for i= 1:576
		    for j=1:768
		        temp = char(b(i,j));
		        if temp(2) == '1'
		            a(i,j) = 1;
		        else
		            a(i,j) = 0;
		        end   
		    end
		end
		S=size(a,1)*size(a,2);
		V = reshape(a,1,S);
		BinTemp(k,:) = V;
	end
	filename = strcat('D:\bsif_code_and_data\bsif_code\',num2str(num),'.mat');
	save(filename,'BinTemp');
end
for num = 75:75
	BinTemp = ones(13, 576*768);
    for k=1:13
        file_name = strcat('D:\bsif_code_and_data\persons\m-0',num2str(num),'-',num2str(k),'.raw');
        
		fin=fopen(file_name,'r');
		I=fread(fin,row*col,'uint8=>uint8'); 
		Z=reshape(I,col,row);
		img=Z';
		bsifcodeim= bsif(img,ICAtextureFilters,'im');
		% unnormalized BSIF code word histogram
		bsifhist=bsif(img,ICAtextureFilters,'h');
		% normalized BSIF code word histogram
		bsifhistnorm=bsif(img, ICAtextureFilters,'nh');
		b = reshape(cellstr(dec2bin(bsifcodeim)), size(bsifcodeim));
		for i= 1:576
		    for j=1:768
		        temp = char(b(i,j));
		        if temp(2) == '1'
		            a(i,j) = 1;
		        else
		            a(i,j) = 0;
		        end   
		    end
		end
		S=size(a,1)*size(a,2);
		V = reshape(a,1,S);
		BinTemp(k,:) = V;
	end
	filename = strcat('D:\bsif_code_and_data\bsif_code\',num2str(num),'.mat');
	save(filename,'BinTemp');
end
for num = 5:5
	BinTemp = ones(13, 576*768);
    for k=1:13
        file_name = strcat('D:\bsif_code_and_data\persons\w-00',num2str(num),'-',num2str(k),'.raw');
        
		fin=fopen(file_name,'r');
		I=fread(fin,row*col,'uint8=>uint8'); 
		Z=reshape(I,col,row);
		img=Z';
		bsifcodeim= bsif(img,ICAtextureFilters,'im');
		% unnormalized BSIF code word histogram
		bsifhist=bsif(img,ICAtextureFilters,'h');
		% normalized BSIF code word histogram
		bsifhistnorm=bsif(img, ICAtextureFilters,'nh');
		b = reshape(cellstr(dec2bin(bsifcodeim)), size(bsifcodeim));
		for i= 1:576
		    for j=1:768
		        temp = char(b(i,j));
		        if temp(2) == '1'
		            a(i,j) = 1;
		        else
		            a(i,j) = 0;
		        end   
		    end
		end
		S=size(a,1)*size(a,2);
		V = reshape(a,1,S);
		BinTemp(k,:) = V;
	end
	filename = strcat('D:\bsif_code_and_data\bsif_code\',num2str(num+75),'.mat');
	save(filename,'BinTemp');
    fclose('all');
end
for num = 7:9
	BinTemp = ones(13, 576*768);
    for k=1:13
        file_name = strcat('D:\bsif_code_and_data\persons\w-00',num2str(num),'-',num2str(k),'.raw');
        
		fin=fopen(file_name,'r');
		I=fread(fin,row*col,'uint8=>uint8'); 
		Z=reshape(I,col,row);
		img=Z';
		bsifcodeim= bsif(img,ICAtextureFilters,'im');
		% unnormalized BSIF code word histogram
		bsifhist=bsif(img,ICAtextureFilters,'h');
		% normalized BSIF code word histogram
		bsifhistnorm=bsif(img, ICAtextureFilters,'nh');
		b = reshape(cellstr(dec2bin(bsifcodeim)), size(bsifcodeim));
		for i= 1:576
		    for j=1:768
		        temp = char(b(i,j));
		        if temp(2) == '1'
		            a(i,j) = 1;
		        else
		            a(i,j) = 0;
		        end   
		    end
		end
		S=size(a,1)*size(a,2);
		V = reshape(a,1,S);
		BinTemp(k,:) = V;
	end
	filename = strcat('D:\bsif_code_and_data\bsif_code\',num2str(num+74),'.mat');
	save(filename,'BinTemp');
    fclose('all');
end
for num = 10:60
	BinTemp = ones(13, 576*768);
    for k=1:13
        file_name = strcat('D:\bsif_code_and_data\persons\w-0',num2str(num),'-',num2str(k),'.raw');
        
		fin=fopen(file_name,'r');
		I=fread(fin,row*col,'uint8=>uint8'); 
		Z=reshape(I,col,row);
		img=Z';
		bsifcodeim= bsif(img,ICAtextureFilters,'im');
		% unnormalized BSIF code word histogram
		bsifhist=bsif(img,ICAtextureFilters,'h');
		% normalized BSIF code word histogram
		bsifhistnorm=bsif(img, ICAtextureFilters,'nh');
		b = reshape(cellstr(dec2bin(bsifcodeim)), size(bsifcodeim));
		for i= 1:576
		    for j=1:768
		        temp = char(b(i,j));
		        if temp(2) == '1'
		            a(i,j) = 1;
		        else
		            a(i,j) = 0;
		        end   
		    end
		end
		S=size(a,1)*size(a,2);
		V = reshape(a,1,S);
		BinTemp(k,:) = V;
	end
	filename = strcat('D:\bsif_code_and_data\bsif_code\',num2str(num+74),'.mat');
	save(filename,'BinTemp');
    fclose('all');
end


