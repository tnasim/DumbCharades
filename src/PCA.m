classdef PCA
    
    
    properties (Constant)
        dataBaseDir = '../Data';
        IntermediateDataDir = [PCA.dataBaseDir,'/','PCATask2'];
    end
    
    
    methods (Static)
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Returns a matrix for a single gesture and a single sensor (for all participants)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function M = readOneSensorData(gesture, sensor)
            k=1;
            MaxCol = 55;
            l = uint32(sensor);
            dirListing = dir(PCA.IntermediateDataDir);
            
            for i = 3:length(dirListing)
                tempFoldername = dirListing(i).name;
                %disp(tempFoldername);
                if ~contains(tempFoldername,'.','IgnoreCase',true)
                    %{
                    if(strcmp( gesture, 'go out') )
                        % TODO --- regex for 'go out'
                        
                        fileName = [PCA.IntermediateDataDir,'/',tempFoldername,'/','go*','.csv'];
                        %disp(fileName);
                    else
                    %}
                        fileName = [PCA.IntermediateDataDir,'/',tempFoldername,'/',gesture,'.csv'];
                    %end
                    if exist(fileName, 'file') == 2
                        temp = csvread([PCA.IntermediateDataDir,'/',tempFoldername,'/',gesture,'.csv'],0, 0);
                        [x,z] = size(temp);
                        %disp([x, z]);
                        
                        if( z <= MaxCol)
                            %disp(tempFoldername);
                            for n = l:67:x
                                t = [temp(n,:), zeros(1, MaxCol-z )];
                                y(k,:) = t;
                                k = k + 1;
                            end
                        end
                    end

                end
            end
            M = y;
        end
        
        % MAD
        % RMS
        % STD
        % FFT
        % DWT
        % MAD2
        
        function FM = getFeatureMatrix(M, feature)
            switch feature
                case 'MAD'
                    FM = mad(M,1,2);    % MEDIAN
                case 'RMS'
                    FM = rms(M, 2);
                case 'STD'
                    FM = std(M, 0, 2);
                case 'FFT'
                    FM = fft(M, [], 2);
                case 'DWT2'
                    [FM, ~, ~, ~] = dwt2(M, 'db1');
                case 'DWT'
                    FM = PCA.getDWT(M);
                case 'MAD2'
                    FM = mad(M,0,2); % MEAN
                case 'VAR'
                    FM = var(M,0,2); % Variance
                otherwise
                    disp('wrong feautre extraction method');
            end
        end
        
        function A = getDWT(M)
            [x, y] = size(M);
            A = zeros(x, ceil(y/2));
            for i = 1:x
                [A(i, :),~] = dwt(M(i,:), 'haar');
            end
        end
        
        % Creating Feature Matrix for ABOUT.
        % appending the features MAD(OPR), RMS(OPR) and MAD(EMG0R)
        function FEATURE_MAT = getFeatureMatrix_ABOUT()
            gest = 'about';
            
            M = PCA.readOneSensorData(gest, Sensor.OPR);

            OPR_MAD = PCA.getFeatureMatrix(M,'MAD');
            OPR_RMS = PCA.getFeatureMatrix(M,'RMS');

            M = PCA.readOneSensorData(gest, Sensor.EMG0R);
            EMG0R_MAD = PCA.getFeatureMatrix(M,'MAD');

            % Concat all the feature columns to get
            %  the whole feature matrix
            FEATURE_MAT = [OPR_MAD, OPR_RMS, EMG0R_MAD];
        end
        
        % Creating Feature Matrix for FATHER.
        function FEATURE_MAT = getFeatureMatrix_FATHER()
            gest = 'father';
            
            M1 = PCA.readOneSensorData(gest, Sensor.ARY);

            F1 = PCA.getFeatureMatrix(M1,'DWT');
            
            M2 = PCA.readOneSensorData(gest, Sensor.OPR);
            F2 = PCA.getFeatureMatrix(M2,'RMS');

            M3 = PCA.readOneSensorData(gest, Sensor.EMG0R);
            F3 = PCA.getFeatureMatrix(M3,'MAD');

            % Concat all the feature columns to get
            %  the whole feature matrix
            FEATURE_MAT = [F1, F2, F3];
        end
        
        % Creating Feature Matrix for AND.
        function FEATURE_MAT = getFeatureMatrix_AND()
            gest = 'and';
            
            M = PCA.readOneSensorData(gest, Sensor.ARX);

            F_1 = PCA.getFeatureMatrix(M,'VAR');
            
            M = PCA.readOneSensorData(gest, Sensor.ARY);

            F_2 = PCA.getFeatureMatrix(M,'VAR');
            
            M = PCA.readOneSensorData(gest, Sensor.EMG0R);

            F_3 = PCA.getFeatureMatrix(M,'MAD');
            
            M = PCA.readOneSensorData(gest, Sensor.EMG2R);

            F_4 = PCA.getFeatureMatrix(M,'MAD');
            
            FEATURE_MAT = [F_1, F_2, F_3, F_4];
        end
        
        
        % Creating Feature Matrix for CAN.
        function FEATURE_MAT = getFeatureMatrix_CAN()
            gest = 'can';
            
            % TODO -- xcorr
            
            M = PCA.readOneSensorData(gest, Sensor.EMG0R);

            F_1 = PCA.getFeatureMatrix(M,'VAR');
            
            M = PCA.readOneSensorData(gest, Sensor.EMG0L);

            F_2 = PCA.getFeatureMatrix(M,'VAR');
            
            M = PCA.readOneSensorData(gest, Sensor.ALY);

            F_3 = PCA.getFeatureMatrix(M,'MAD');
            
            M = PCA.readOneSensorData(gest, Sensor.ARY);

            F_4 = PCA.getFeatureMatrix(M,'MAD');
            
            FEATURE_MAT = [F_1, F_2, F_3, F_4];
        end
        
        % Creating Feature Matrix for FIND.
        function FEATURE_MAT = getFeatureMatrix_FIND()
            gest = 'find';
            
            M = PCA.readOneSensorData(gest, Sensor.GRY);

            F_1 = PCA.getFeatureMatrix(M,'FFT');
            
            M = PCA.readOneSensorData(gest, Sensor.ARX);

            F_2 = PCA.getFeatureMatrix(M,'VAR');
            
            M = PCA.readOneSensorData(gest, Sensor.EMG0R);

            F_3 = PCA.getFeatureMatrix(M,'MAD');
            
            M = PCA.readOneSensorData(gest, Sensor.EMG2R);

            F_4 = PCA.getFeatureMatrix(M,'MAD');
            
            FEATURE_MAT = [F_1, F_2, F_3, F_4];
        end
        
        % Creating Feature Matrix for COP.
        function FEATURE_MAT = getFeatureMatrix_COP()
            gest = 'cop';
            
            M = PCA.readOneSensorData(gest, Sensor.ARZ);

            F_1 = PCA.getFeatureMatrix(M,'STD');
            
            M = PCA.readOneSensorData(gest, Sensor.ORR);

            F_2 = PCA.getFeatureMatrix(M,'VAR');
            
            M = PCA.readOneSensorData(gest, Sensor.OPR);

            F_3 = PCA.getFeatureMatrix(M,'MAD');
            
            FEATURE_MAT = [F_1, F_2, F_3];
        end
        
        % Creating Feature Matrix for DEAF.
        function FEATURE_MAT = getFeatureMatrix_DEAF()
            gest = 'deaf';
            
            % TODO -- xcorr
            
            M = PCA.readOneSensorData(gest, Sensor.ARX);

            F_1 = PCA.getFeatureMatrix(M,'MAD');
            
            M = PCA.readOneSensorData(gest, Sensor.EMG0L);

            F_2 = PCA.getFeatureMatrix(M,'VAR');
            
            M = PCA.readOneSensorData(gest, Sensor.GRX);

            F_3 = PCA.getFeatureMatrix(M,'MAD');
            
            M = PCA.readOneSensorData(gest, Sensor.ORR);

            F_4 = PCA.getFeatureMatrix(M,'MAD');
            
            FEATURE_MAT = [F_1, F_2, F_3, F_4];
        end
        
        % Creating Feature Matrix for DECIDE.
        function FEATURE_MAT = getFeatureMatrix_DECIDE()
            gest = 'decide';
            
            M = PCA.readOneSensorData(gest, Sensor.ALY);

            F_1 = PCA.getFeatureMatrix(M,'VAR');
            
            M = PCA.readOneSensorData(gest, Sensor.ARY);

            F_2 = PCA.getFeatureMatrix(M,'VAR');
            
            M = PCA.readOneSensorData(gest, Sensor.EMG3L);

            F_3 = PCA.getFeatureMatrix(M,'MAD');
            
            M = PCA.readOneSensorData(gest, Sensor.ORR);

            F_4 = PCA.getFeatureMatrix(M,'MAD');
            
            FEATURE_MAT = [F_1, F_2, F_3, F_4];
        end
        
        
        % Creating Feature Matrix for GO OUT.
        function FEATURE_MAT = getFeatureMatrix_GO_OUT()
            gest = 'go out';
            
            M = PCA.readOneSensorData(gest, Sensor.EMG0R);

            F_1 = PCA.getFeatureMatrix(M,'RMS');
            
            M = PCA.readOneSensorData(gest, Sensor.ARY);

            F_2 = PCA.getFeatureMatrix(M,'VAR');
            
            M = PCA.readOneSensorData(gest, Sensor.GRX);

            F_3 = PCA.getFeatureMatrix(M,'MAD');
            
            M = PCA.readOneSensorData(gest, Sensor.ORR);

            F_4 = PCA.getFeatureMatrix(M,'MAD');
            
            FEATURE_MAT = [F_1, F_2, F_3, F_4];
        end
        
        % Creating Feature Matrix for HEARING.
        function FEATURE_MAT = getFeatureMatrix_HEARING()
            gest = 'hearing';
            
            M = PCA.readOneSensorData(gest, Sensor.OPR);

            F_1 = PCA.getFeatureMatrix(M,'VAR');
            
            M = PCA.readOneSensorData(gest, Sensor.ARZ);

            F_2 = PCA.getFeatureMatrix(M,'RMS');
            
            M = PCA.readOneSensorData(gest, Sensor.ARY);

            F_3 = PCA.getFeatureMatrix(M,'RMS');
            
            M = PCA.readOneSensorData(gest, Sensor.ARX);

            F_4 = PCA.getFeatureMatrix(M,'MAD');
            
            FEATURE_MAT = [F_1, F_2, F_3, F_4];
        end
        
        
        % Get the row-wise Cross-correlation of two matrices
        %{
        function xcor = getCrossCorrelation(M1, M2)
            [r1, c1] = size(M1);
            [r2, c2] = size(M2);
            minr = min(r1, r2)
            
            % assuming c1 == c2 (column numbers are same for the two matrices)
            M = zeros(minr, c1);
            for i = 1:minr
                M(i, :) = xcorr( M1(i, :), M2(i, :));
            end
            
            xcor = M;
            
        end
        %}
        
        %{
        function [e] = plotev(coeffM)
           %  [e] = plotev(n)
           %
           %  This function creates a random matrix of square
           %  dimension (n).  It computes the eigenvalues (e) of 
           %  the matrix and plots them in the complex plane.
           %
           
           e = eig(coeffM);    % Get the eigenvalues of A

           close all    % Closes all currently open figures.
           figure(1)
             plot(real(e),imag(e),'r*') %   Plot real and imaginary parts
             xlabel('Real')
             ylabel('Imaginary')
             t1 = ['Eigenvalues of a random matrix of dimension ' num2str(n)];
             title(t1)
        end
        %}
        
    end
end