%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST CODE FOR PCA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ABOUT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M = PCA.readOneSensorData('about', Sensor.OPR);

ABOUT_MAD = PCA.getFeatureMatrix(M,'MAD');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FATHER
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M = PCA.readOneSensorData('father', Sensor.ARY);
FATHER_ARY = PCA.getFeatureMatrix(M,'DWT');

coeff = pca(FATHER_ARY);
mat = coeff(:, 1) * FATHER_ARY(1, :)

