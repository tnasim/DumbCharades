%M = csvread("task1output/ABOUT.csv",0,2,[0 2 10 10])
%M = csvread("task1output/ABOUT.csv",0,2,[0 0 67 45])
M = csvread("task1output/ABOUT.csv",0,2);
M = M(2:end, 3:end-1);
%disp(M)
dim = size(M);
sum_mat = sum(M,2);
min_mat = min(M,[], 2);
avg = mean(M, 2);
root_mean_square = rms(M, 2);
s = size(M)
%plot(avg
%A = [1.7 1.2 1.5; 1.3 1.6 1.99]
%min_matA = min(A,[], 2)