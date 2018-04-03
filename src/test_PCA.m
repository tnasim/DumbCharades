%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST CODE FOR PCA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ABOUT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%{
ABT_FEATURE_MAT = PCA.getFeatureMatrix_ABOUT('about');
[coeff,score,latent,tsquared,explained] = pca(ABT_FEATURE_MAT);
biplot(coeff(:,1:2),'scores',score(:,1:2),'varlabels',{'v_1','v_2','v_3'});
title('PCA plot for ABOUT');
% legend('v1-MAD(OPR)','v2-RMS(OPR)','v3-MAD(EMG0R)');

figure();
pareto(explained);
xlabel('Principal Component');
ylabel('Variance Explained (%)');
title('SCREE plot for ABOUT');
%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DEAF
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%{
FEATURE_MAT = PCA.getFeatureMatrix_DEAF('deaf');
[coeff1,score,latent,tsquared,explained] = pca(FEATURE_MAT);
biplot(coeff1(:,1:2),'scores',score(:,1:2),'varlabels',{'v_1','v_2','v_3', 'v_4'});
%PCA.plotev(coeff1);
title('PCA plot for DEAF');
% legend('v1-MAD(ARX)','v2-VAR(EMG0L)','v3-MAD(GRX)','v4-MAD(ORR)');

figure();
pareto(explained);
xlabel('Principal Component');
ylabel('Variance Explained (%)');
title('SCREE plot for DEAF');
%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AND
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
FEATURE_MAT = PCA.getFeatureMatrix_AND('and');
[coeff1,score,latent,tsquared,explained] = pca(FEATURE_MAT);
biplot(coeff1(:,1:2),'scores',score(:,1:2),'varlabels',{'v_1','v_2','v_3', 'v_4'});
title('PCA plot for AND');
% legend('v1-VAR(ARX)','v2-VAR(ARY)','v3-MAD(EMG0R)','v4-MAD(EMG2R)');

figure();
pareto(explained);
xlabel('Principal Component');
ylabel('Variance Explained (%)');
title('Scree plot  for AND');
%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HEARING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%{
FEATURE_MAT = PCA.getFeatureMatrix_HEARING('hearing');
[coeff1,score,latent,tsquared,explained] = pca(FEATURE_MAT);
biplot(coeff1(:,1:2),'scores',score(:,1:2),'varlabels',{'v_1','v_2','v_3', 'v_4'});
title('PCA plot for HEARING');
% legend('v1-VAR(OPR)','v2-RMS(ARZ)','v3-STD(GRX)','v4-MAD(ORR)');

figure();
pareto(explained);
xlabel('Principal Component');
ylabel('Variance Explained (%)');
title('Scree plot  for HEARING');
%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CAN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
FEATURE_MAT = PCA.getFeatureMatrix_CAN('can');
[coeff1,score,latent,tsquared,explained] = pca(FEATURE_MAT);
biplot(coeff1(:,1:2),'scores',score(:,1:2),'varlabels',{'v_1','v_2','v_3', 'v_4'});
title('PCA plot for CAN');
% legend('v1-VAR(EMG0R)','v2-VAR(EMG0L)','v3-MAD(ALY)','v4-MAD(ARY)');

figure();
pareto(explained);
xlabel('Principal Component');
ylabel('Variance Explained (%)');
title('Scree plot  for CAN');
%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COP
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
FEATURE_MAT = PCA.getFeatureMatrix_COP('cop');
[coeff1,score,latent,tsquared,explained] = pca(FEATURE_MAT);
biplot(coeff1(:,1:2),'scores',score(:,1:2),'varlabels',{'v_1','v_2','v_3'});
title('PCA plot for COP');
% legend('v1-STD(ARZ)','v2-VAR(OPR)','v3-MAD(OPR)');

figure();
pareto(explained);
xlabel('Principal Component');
ylabel('Variance Explained (%)');
title('Scree plot  for COP');
%}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DECIDE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
FEATURE_MAT = PCA.getFeatureMatrix_DECIDE('decide');
[coeff1,score,latent,tsquared,explained] = pca(FEATURE_MAT);
biplot(coeff1(:,1:2),'scores',score(:,1:2),'varlabels',{'v_1','v_2','v_3', 'v_4'});
title('PCA plot for DECIDE');
% legend('v1-VAR(ALY)','v2-VAR(ARY)','v3-MAD(EMG3L)','v4-MAD(ORR)');

figure();
pareto(explained);
xlabel('Principal Component');
ylabel('Variance Explained (%)');
title('Scree plot  for DECIDE');
%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GO_OUT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
FEATURE_MAT = PCA.getFeatureMatrix_GO_OUT('go out');
[coeff1,score,latent,tsquared,explained] = pca(FEATURE_MAT);
biplot(coeff1(:,1:2),'scores',score(:,1:2),'varlabels',{'v_1','v_2','v_3', 'v_4'});
title('PCA plot for GO OUT');
% legend('v1-RMS(EMG0R)','v2-VAR(ARY)','v3-MAD(GRX)','v4-MAD(ORR)');

figure();
pareto(explained);
xlabel('Principal Component');
ylabel('Variance Explained (%)');
title('Scree plot  for GO OUT');

%}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIND
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%{
FEATURE_MAT = PCA.getFeatureMatrix_FIND('find');
[coeff1,score,latent,tsquared,explained] = pca(FEATURE_MAT);
biplot(coeff1(1:4,1:2),'scores',score(1:4,1:2),'varlabels',{'v_1','v_2','v_3', 'v_4'});
title('PCA plot for FIND');
% legend('v1-FFT(GRY)','v2-VAR(ARX)','v3-MAD(EMG0R)','v4-MAD(EMG2R)');
figure();
pareto(explained);
xlabel('Principal Component');
ylabel('Variance Explained (%)');
title('Scree plot  for FIND');
%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FATHER
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%{
FEATURE_MAT = PCA.getFeatureMatrix_FATHER('father');
[coeff1,score,latent,tsquared,explained] = pca(FEATURE_MAT);
biplot(coeff1(1:3,1:2),'scores',score(1:3,1:2),'varlabels',{'v_1','v_2','v_3'});
%biplot(coeff1(28:30,1:2),'scores',score(28:30,1:2),'varlabels',{'v_1','v_2','v_3'});
title('PCA plot for FATHER');
% legend('v1-DWT(ARY)','v2-RMS(OPR)','v3-MAD(EMG0R)');

figure();
pareto(explained);
xlabel('Principal Component');
ylabel('Variance Explained (%)');
title('Scree plot  for FATHER');

%}
