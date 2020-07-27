function bsifdemo_using_prelearnt_filters()

filename=['F:/bsif_code_and_data/texturefilters/ICAtextureFilters_11x11_8bit'];
load(filename, 'ICAtextureFilters');


row=576;  col=768;
fin=fopen('F:\AR\dbf1.tar\dbf1\m-001-4.raw','r');
I=fread(fin,row*col,'uint8=>uint8'); 
Z=reshape(I,col,row);
img=Z';

%img=double(rgb2gray(imread('C:/Users/bioshock/Downloads/utkarsh.jpg')));

% Three ways of using bsif.m :

% the image with grayvalues replaced by the BSIF bitstrings
bsifcodeim= bsif(img,ICAtextureFilters,'im');

% unnormalized BSIF code word histogram
bsifhist=bsif(img,ICAtextureFilters,'h');

% normalized BSIF code word histogram
bsifhistnorm=bsif(img, ICAtextureFilters,'nh');



% visualization
% figure;
% subplot(1,2,1); imagesc(img);colormap('gray');axis image;colorbar
% subplot(1,2,2); imagesc(bsifcodeim); axis image;colorbar
% 
% figure;
% subplot(1,2,1); bar(bsifhist);
% subplot(1,2,2); bar(bsifhistnorm);

%size(bsifcodeim)
%d = de2bi(bsifcodeim);
%size(d)
b = reshape(cellstr(dec2bin(bsifcodeim)), size(bsifcodeim));
size(b);
% S=size(b,1)*size(b,2);
%  V = reshape(b,1,S);
%  size(V);
 figure;
 subplot(1,1,1); imagesc(bsifcodeim); axis image;colorbar;
 
 
 
        


