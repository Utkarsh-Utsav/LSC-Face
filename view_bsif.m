clc
clear
row=576;  col=768;
BinTemp=load('D:\bsif_code_and_data\bsif_code\2-5.mat');
code = BinTemp(1,:);
code = struct2array(code);
Z=reshape(code,row,col);
figure;
subplot(1,1,1); imagesc(Z); axis image;colorbar