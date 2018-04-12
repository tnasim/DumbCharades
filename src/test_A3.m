% Make sure you have put the PCATask2 folder (with data) in the 'Data'
% folder.
acc = [];
gest = A3.gestList(1);
[train, test] = A3.getClassData(gest(1), 60);
[~,m] = size(train);
train_data = train(:,1:(m-1));
tran_label = train(:,m);
test_data = test(:,1:(m-1));
test_label= test(:,m);

for i = 1:10
    gest = A3.gestList(1);
    [train, test] = A3.getClassData(gest(i), 60);
    [~,m] = size(train);
    rowT = calcTreeMod(train(:,1:(m-1)),train(:,m), test(:,1:(m-1)), test(:,m));
    rowS = calcSVMMod(train(:,1:(m-1)),train(:,m), test(:,1:(m-1)), test(:,m));
    acc = [acc;[gest(i), rowT, rowS]];
end
disp(acc);

function A = calcTreeMod(trainData, trainClass, testData, testClass)
    Model = fitctree(trainData,trainClass);
    %view(Model);
    %view(Model,'Mode','graph');
    [label,score,node,cnum] = predict(Model,testData);
    
    disp(size(label));
    [c,cm,ind,per] = confusion(testClass',label');
    disp(cm);
    %Z = eq(testClass,label);
    %A = (sum(Z)/numel(Z))*100;
    %A = getValue(cm,'acc')*100;
    
end

function A = calcSVMMod(trainData, trainClass, testData, testClass)
    Model = fitcsvm(trainData,trainClass);
    classOrder = Model.ClassNames
    [label,score] = predict(Model,testData);
    
    %{
    sv = Model.SupportVectors;
    figure
    gscatter(trainData(:,2),trainData(:,3),trainClass)
    hold on
    plot(sv(:,1),sv(:,2),'ko','MarkerSize',10)
    legend('0','1','Support Vector')
    hold off
    %}
    [c,cm,ind,per] = confusion(testClass',label');
    %Z = eq(testClass,label);
    %A = (sum(Z)/numel(Z))*100;
    %A = getValue(cm,'rec')*100;
end

function value = getValue(M, parameter)
            switch parameter
                case 'acc'
                    value = (M(1,1)+M(2,2))/(M(1,1)+M(1,2)+M(2,1)+M(2,2));
                case 'pre'
                    value = M(1,1)/(M(1,1)+M(2,2));
                case 'rec'
                    value = M(1,1)/(M(1,1)+M(1,2));
                case 'F1'
                    value = (2*M(1,1))/((2*M(1,1))+M(2,1)+M(1,2));
                otherwise
                    disp('wrong parameter');
            end
        end





%[train, test] = A3.getClassData('and', 80);
%[train, test] = A3.getClassData('can', 80);
%[train, test] = A3.getClassData('cop', 80);
%[train, test] = A3.getClassData('deaf', 80);
%[train, test] = A3.getClassData('decide', 80);
%[train, test] = A3.getClassData('father', 80);
%[train, test] = A3.getClassData('find', 80);
%[train, test] = A3.getClassData('go out', 80);
%[train, test] = A3.getClassData('hearing', 80);