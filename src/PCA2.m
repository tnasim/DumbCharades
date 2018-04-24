classdef PCA2
    
    
    properties (Constant)
        dataBaseDir = '../Data';
        IntermediateDataDir = [PCA2.dataBaseDir,'/','PCATask2'];
    end
    
    
    methods (Static)
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Returns a matrix for a single gesture and a single sensor (for all participants)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function M = readOneSensorData(gesture, sensor)
            k=1;
            MaxCol = 55;
            l = uint32(sensor);
            dirListing = dir(PCA2.IntermediateDataDir);
            %disp(gesture);
            for i = 3:length(dirListing)
                tempFoldername = dirListing(i).name;
                %disp(tempFoldername);
                if ~contains(tempFoldername,'.','IgnoreCase',true)
                    %{
                    if(strcmp( gesture, 'go out') )
                        % TODO --- regex for 'go out'
                        
                        fileName = [PCA2.IntermediateDataDir,'/',tempFoldername,'/','go*','.csv'];
                        %disp(fileName);
                    else
                    %}
                        fileName = [PCA2.IntermediateDataDir,'/',tempFoldername,'/',gesture,'.csv'];
                        if ischar(fileName)==0
                            fileName = strjoin(fileName, '');
                        end
                    %end
                    
                    if exist(fileName, 'file') == 2
                        temp = csvread(fileName,0, 0);
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
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Returns a matrix for a single gesture and a single sensor (for a single participants)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function M = readOneSensorDataForOneUser(gesture, sensor, user)
            k=1;
            MaxCol = 55;
            l = uint32(sensor);
            
            if user < 10
                tempFoldername = strcat('DM0', num2str(user));
            else
                tempFoldername = strcat('DM', num2str(user));
            end
            disp(tempFoldername);
            if ~contains(tempFoldername,'.','IgnoreCase',true)
                fileName = [PCA2.IntermediateDataDir,'/',tempFoldername,'/',gesture,'.csv'];
                if ischar(fileName)==0
                    fileName = strjoin(fileName, '');
                end

                if exist(fileName, 'file') == 2
                    temp = csvread(fileName,0, 0);
                    [x,z] = size(temp);
                    %disp([x, z]);

                    %if( z <= MaxCol)
                        %disp(tempFoldername);
                        for n = l:67:x
                            t = [temp(n,:), zeros(1, MaxCol-z )];
                            y(k,:) = t;
                            k = k + 1;
                        end
                    %end
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
                    FM = PCA2.getDWT(M);
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
        function FEATURE_MAT = getFeatureMatrix_ABOUT(gest, user)
            %gest = 'about';
            
            M = PCA2.readOneSensorDataForOneUser(gest, Sensor.OPR, user);

            OPR_MAD = PCA2.getFeatureMatrix(M,'MAD');
            OPR_RMS = PCA2.getFeatureMatrix(M,'RMS');

            M = PCA2.readOneSensorDataForOneUser(gest, Sensor.EMG0R, user);
            EMG0R_MAD = PCA2.getFeatureMatrix(M,'MAD');

            % Concat all the feature columns to get
            %  the whole feature matrix
            FEATURE_MAT = [OPR_MAD, OPR_RMS, EMG0R_MAD];
        end
        
        % Creating Feature Matrix for FATHER.
        function FEATURE_MAT = getFeatureMatrix_FATHER(gest, user)
            %gest = 'father';
            
            M1 = PCA2.readOneSensorDataForOneUser(gest, Sensor.ARY, user);

            F1 = PCA2.getFeatureMatrix(M1,'DWT');
            
            M2 = PCA2.readOneSensorDataForOneUser(gest, Sensor.OPR, user);
            F2 = PCA2.getFeatureMatrix(M2,'RMS');

            M3 = PCA2.readOneSensorDataForOneUser(gest, Sensor.EMG0R, user);
            F3 = PCA2.getFeatureMatrix(M3,'MAD');

            % Concat all the feature columns to get
            %  the whole feature matrix
            FEATURE_MAT = [F1, F2, F3];
        end
        
        % Creating Feature Matrix for AND.
        function FEATURE_MAT = getFeatureMatrix_AND(gest, user)
            %gest = 'and';
            
            M = PCA2.readOneSensorDataForOneUser(gest, Sensor.ARX, user);

            F_1 = PCA2.getFeatureMatrix(M,'VAR');
            
            M = PCA2.readOneSensorDataForOneUser(gest, Sensor.ARY, user);

            F_2 = PCA2.getFeatureMatrix(M,'VAR');
            
            M = PCA2.readOneSensorDataForOneUser(gest, Sensor.EMG0R, user);

            F_3 = PCA2.getFeatureMatrix(M,'MAD');
            
            M = PCA2.readOneSensorDataForOneUser(gest, Sensor.EMG2R, user);

            F_4 = PCA2.getFeatureMatrix(M,'MAD');
            
            FEATURE_MAT = [F_1, F_2, F_3, F_4];
        end
        
        
        % Creating Feature Matrix for CAN.
        function FEATURE_MAT = getFeatureMatrix_CAN(gest, user)
            %gest = 'can';
            
            % TODO -- xcorr
            
            M = PCA2.readOneSensorDataForOneUser(gest, Sensor.EMG0R, user);

            F_1 = PCA2.getFeatureMatrix(M,'VAR');
            
            M = PCA2.readOneSensorDataForOneUser(gest, Sensor.EMG0L, user);

            F_2 = PCA2.getFeatureMatrix(M,'VAR');
            
            M = PCA2.readOneSensorDataForOneUser(gest, Sensor.ALY, user);

            F_3 = PCA2.getFeatureMatrix(M,'MAD');
            
            M = PCA2.readOneSensorDataForOneUser(gest, Sensor.ARY, user);

            F_4 = PCA2.getFeatureMatrix(M,'MAD');
            
            FEATURE_MAT = [F_1, F_2, F_3, F_4];
        end
        
        % Creating Feature Matrix for FIND.
        function FEATURE_MAT = getFeatureMatrix_FIND(gest, user)
            %gest = 'find';
            
            M = PCA2.readOneSensorDataForOneUser(gest, Sensor.GRY, user);

            F_1 = PCA2.getFeatureMatrix(M,'FFT');
            
            M = PCA2.readOneSensorDataForOneUser(gest, Sensor.ARX, user);

            F_2 = PCA2.getFeatureMatrix(M,'VAR');
            
            M = PCA2.readOneSensorDataForOneUser(gest, Sensor.EMG0R, user);

            F_3 = PCA2.getFeatureMatrix(M,'MAD');
            
            M = PCA2.readOneSensorDataForOneUser(gest, Sensor.EMG2R, user);

            F_4 = PCA2.getFeatureMatrix(M,'MAD');
            
            FEATURE_MAT = [F_1, F_2, F_3, F_4];
        end
        
        % Creating Feature Matrix for COP.
        function FEATURE_MAT = getFeatureMatrix_COP(gest, user)
            %gest = 'cop';
            
            M = PCA2.readOneSensorDataForOneUser(gest, Sensor.ARZ, user);

            F_1 = PCA2.getFeatureMatrix(M,'STD');
            
            M = PCA2.readOneSensorDataForOneUser(gest, Sensor.ORR, user);

            F_2 = PCA2.getFeatureMatrix(M,'VAR');
            
            M = PCA2.readOneSensorDataForOneUser(gest, Sensor.OPR, user);

            F_3 = PCA2.getFeatureMatrix(M,'MAD');
            
            FEATURE_MAT = [F_1, F_2, F_3];
        end
        
        % Creating Feature Matrix for DEAF.
        function FEATURE_MAT = getFeatureMatrix_DEAF(gest, user)
            %gest = 'deaf';
            
            % TODO -- xcorr
            
            M = PCA2.readOneSensorDataForOneUser(gest, Sensor.ARX, user);

            F_1 = PCA2.getFeatureMatrix(M,'MAD');
            
            M = PCA2.readOneSensorDataForOneUser(gest, Sensor.EMG0L, user);

            F_2 = PCA2.getFeatureMatrix(M,'VAR');
            
            M = PCA2.readOneSensorDataForOneUser(gest, Sensor.GRX, user);

            F_3 = PCA2.getFeatureMatrix(M,'MAD');
            
            M = PCA2.readOneSensorDataForOneUser(gest, Sensor.ORR, user);

            F_4 = PCA2.getFeatureMatrix(M,'MAD');
            
            FEATURE_MAT = [F_1, F_2, F_3, F_4];
        end
        
        % Creating Feature Matrix for DECIDE.
        function FEATURE_MAT = getFeatureMatrix_DECIDE(gest, user)
            %gest = 'decide';
            
            M = PCA2.readOneSensorDataForOneUser(gest, Sensor.ALY, user);

            F_1 = PCA2.getFeatureMatrix(M,'VAR');
            
            M = PCA2.readOneSensorDataForOneUser(gest, Sensor.ARY, user);

            F_2 = PCA2.getFeatureMatrix(M,'VAR');
            
            M = PCA2.readOneSensorDataForOneUser(gest, Sensor.EMG3L, user);

            F_3 = PCA2.getFeatureMatrix(M,'MAD');
            
            M = PCA2.readOneSensorDataForOneUser(gest, Sensor.ORR, user);

            F_4 = PCA2.getFeatureMatrix(M,'MAD');
            
            FEATURE_MAT = [F_1, F_2, F_3, F_4];
        end
        
        
        % Creating Feature Matrix for GO OUT.
        function FEATURE_MAT = getFeatureMatrix_GO_OUT(gest, user)
            %gest = 'go out';
            
            M = PCA2.readOneSensorDataForOneUser(gest, Sensor.EMG0R, user);

            F_1 = PCA2.getFeatureMatrix(M,'RMS');
            
            M = PCA2.readOneSensorDataForOneUser(gest, Sensor.ARY, user);

            F_2 = PCA2.getFeatureMatrix(M,'VAR');
            
            M = PCA2.readOneSensorDataForOneUser(gest, Sensor.GRX, user);

            F_3 = PCA2.getFeatureMatrix(M,'MAD');
            
            M = PCA2.readOneSensorDataForOneUser(gest, Sensor.ORR, user);

            F_4 = PCA2.getFeatureMatrix(M,'MAD');
            
            FEATURE_MAT = [F_1, F_2, F_3, F_4];
        end
        
        % Creating Feature Matrix for HEARING.
        function FEATURE_MAT = getFeatureMatrix_HEARING(gest, user)
            %gest = 'hearing';
            
            M = PCA2.readOneSensorDataForOneUser(gest, Sensor.OPR, user);

            F_1 = PCA2.getFeatureMatrix(M,'VAR');
            
            M = PCA2.readOneSensorDataForOneUser(gest, Sensor.ARZ, user);

            F_2 = PCA2.getFeatureMatrix(M,'RMS');
            
            M = PCA2.readOneSensorDataForOneUser(gest, Sensor.ARY, user);

            F_3 = PCA2.getFeatureMatrix(M,'RMS');
            
            M = PCA2.readOneSensorDataForOneUser(gest, Sensor.ARX, user);

            F_4 = PCA2.getFeatureMatrix(M,'MAD');
            
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