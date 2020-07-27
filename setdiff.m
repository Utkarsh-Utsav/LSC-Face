function [score] = setdiff(set_a,set_b)
%% This function computes the elementwise difference between two sets and generates a score

s = size(set_a,2);
clearvars temp

for i = 1:s
   temp(i) = double(set_a(i)) - double(set_b(i));
end

out = sum(temp(:)==0);
score = out/numel(set_a);

end

