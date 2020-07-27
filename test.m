if true
   row=576;  col=768;
fin=fopen('F:\AR\dbf6.tar\dbf6\dbfaces6\w-040-13.raw','r');
I=fread(fin,row*col,'uint8=>uint8'); 
Z=reshape(I,col,row);
Z=Z';
k=imshow(Z)
end