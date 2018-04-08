% Make sure you have put the PCATask2 folder (with data) in the 'Data'
% folder.
acc = [];
for i = 1:10
    gest = A3.gestList(1);
    [train, test] = A3.getClassData(gest(i), 80);
    rowT = calcTreeMod(train(:,1:3),train(:,4), test(:,1:3), test(:,4));
    rowS = calcSVMMod(train(:,1:3),train(:,4), test(:,1:3), test(:,4));
    acc = [acc;[gest(i), rowT, rowS]];
end
disp(acc);

function A = calcTreeMod(trainData, trainClass, testData, testClass)
    Model = fitctree(trainData,trainClass);
    [label,score,node,cnum] = predict(Model,testData);
    Z = eq(testClass,label);
    A = (sum(Z)/numel(Z))*100;
end

function A = calcSVMMod(trainData, trainClass, testData, testClass)
    Model = fitcsvm(trainData,trainClass);
    [label,score] = predict(Model,testData);
    Z = eq(testClass,label);
    A = (sum(Z)/numel(Z))*100;
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