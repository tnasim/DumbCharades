%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST CODE FOR PCA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ABOUT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ABT_FEATURE_MAT = PCA.getFeatureMatrix_ABOUT();
[coeff,score,latent] = pca(ABT_FEATURE_MAT);
biplot(coeff(:,1:2),'scores',score(:,1:2),'varlabels',{'v_1','v_2','v_3'});


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FATHER
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M = PCA.readOneSensorData('father', Sensor.ARY);
FATHER_ARY = PCA.getFeatureMatrix(M,'DWT');

[coeff,score,latent] = pca(FATHER_ARY);
% Multiply 1st row of the feature matrix using the first eigenvactor on the left.
% mat = coeff(:, 1) * FATHER_ARY(1, :);

% Make a biplot of the first 4 components
%biplot(coeff(1:3,1:3),'scores',score(1:3,1:3),'varlabels',{'v_1','v_2','v_3'});

