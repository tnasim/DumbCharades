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
                    if(strcmp( gesture, 'go out') )
                        % TODO --- regex for 'go out'
                        fileName = [PCA.IntermediateDataDir,'/',tempFoldername,'/','go*','.csv'];
                        %disp(fileName);
                    else
                        fileName = [PCA.IntermediateDataDir,'/',tempFoldername,'/',gesture,'.csv'];
                    end
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
                case 'DWT'
                    [FM, ~, ~, ~] = dwt2(M, 'haar');
                case 'MAD2'
                    FM = mad(M,0,2); % MEAN
                otherwise
                    disp('wrong feautre extraction method');
            end
        end
        
    end
end