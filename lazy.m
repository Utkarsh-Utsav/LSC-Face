%% Lazy

N = 12;

hash_length = [5,10,15];
security = [0.15,0.25,0.5,0.75];
hash_num = [100,200];
path = strcat(pwd,'\Results\FVC2002-DB3\ZT\N= ',num2str(N),'\');



for i = 1:size(hash_num,2)
   for ii = 1:size(hash_length,2)
       for iii = 1:size(security,2)
           load(strcat(path,'gscore_',num2str(hash_num(i)),'-',num2str(hash_length(ii)),'-',num2str(security(iii)),'.mat'));
           load(strcat(path,'iscore_',num2str(hash_num(i)),'-',num2str(hash_length(ii)),'-',num2str(security(iii)),'.mat'));
           [eer, eerc, op, opc, di, xaxis, yaxis] = EER_DET(genscore,impscore,0.001,10000);
           geer((i-1)*3+ii,iii) = eer;
           gop((i-1)*3+ii,iii) = op;
           gdi((i-1)*3+ii,iii) = di;
       end
   end
end