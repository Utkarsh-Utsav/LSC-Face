%clc;
%clear;

%load('D:\bsif_code_and_data\Mated Non Mated\mscore_150-30-0.5.mat')
%load('D:\bsif_code_and_data\Mated Non Mated\nmscore_150-30-0.5.mat'')


s = 1;
omega = 1;
temp = 1;
scale = 4;

tbl_mated = tabulate(round(mated,scale));
tbl_nonmated = tabulate(round(nonmated,scale));
mated_score = tbl_mated(:,1)';
mated_prob = tbl_mated(:,3)/100';
nonmated_score = tbl_nonmated(:,1)';
nonmated_prob = tbl_nonmated(:,3)/100';


limit_min = min(min(mated_score),min(nonmated_score));
limit_max = max(max(mated_score),max(nonmated_score));

arr = round(linspace(limit_min,limit_max,53),3);
mated_interpol = interp1(mated_score,mated_prob,arr);
nonmated_interpol = interp1(nonmated_score,nonmated_prob,arr);
mated_interpol(isnan(mated_interpol))=0;
nonmated_interpol(isnan(nonmated_interpol))=0;

% Calculate Local Score
for i = 1:size(arr,2)
        LR(s) = mated_interpol(i)/nonmated_interpol(i);
        if ((LR(s)*omega) <= 1)
            D_local(s) = 0;
        else
           D_local(s) = (2*(LR(s)*omega)/(1+LR(s)*omega)) - 1;
        end
        s = s + 1;
end
D_local(isnan(D_local))=0;


% Calculate Global Score
for i = 1:size(arr,2)
    temp(i) = mated_interpol(i)*D_local(i);
end

tbl = tabulate(temp);
xcor = tbl(:,1)';
ycor = tbl(:,3)'/100;
D_global = trapz(xcor,ycor);
file_name = strcat('D:\bsif_code_and_data\Mated Non Mated\d_local','.mat');
save(file_name,'D_local');


