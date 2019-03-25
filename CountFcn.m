function [Y1, sum] = CountFcn()
Y1 = [];
sum = 0;
for i = 1:200
    Y1 = [Y1 i];
    sum = sum +i;
end
Y1
sum