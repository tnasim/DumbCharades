TASK1_M = csvread('../output/task1/ALX.csv',0,2);

dim = size(TASK1_M);

X=[];
j=0;
for i = 1:21:dim(1,1)
    j=j+1;
    Y= mean(TASK1_M(i:(j*21),:),1);
    X=[X; Y];
    
end

% figure;
% for i = 1:j
%     if i>1
%         hold on;
%     end
%     k = X(i, 1:dim(1,2))
%     Z=fft(k);
%     plot(0:1:42, Z);
%     if i>1
%         hold off;
%     end
% end
  

figure
    Z=fft(X,[],2);
    plot(0:1:42,Z);
    title('Complete FFT')




