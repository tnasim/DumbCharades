classdef A3
    
    
    properties (Constant)
        gestList = ["about", "and", "can", "cop", "deaf", "decide", "father", "find", "go out", "hearing"];
    end
    
    methods (Static)
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Get labeled feature matrix for a particular gesture.
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function [train, test] = getClassData(gesture, trainPercent)
            M = []
            switch gesture
                case 'about'
                    M = PCA.getFeatureMatrix_ABOUT(gesture);
                    
                    g = A3.gestList(A3.gestList~='about');
                    glen = length(g);
                    P = [];
                    for i = 1:glen
                        gest = A3.gestList(i);
                        if(gest ~= gesture)
                            P = [P; PCA.getFeatureMatrix_ABOUT(gest)];
                        end
                    end
                case 'and'
                    M = PCA.getFeatureMatrix_ABOUT(gesture);
                    
                    g = A3.gestList(A3.gestList~='about');
                    glen = length(g);
                    P = [];
                    for i = 1:glen
                        gest = A3.gestList(i);
                        if(gest ~= gesture)
                            P = [P; PCA.getFeatureMatrix_ABOUT(gest)];
                        end
                    end
                otherwise
                    disp('wrong gesture name.');
                    
            end
            [r, ~] = size(M);
            M = [M repmat(1,r,1)];
            % divide into training and test data for current gesture
            [M_train, M_test] = A3.divideDataRowWise(M, trainPercent);
            
            [r, ~] = size(P);
            P = [P repmat(0,r,1)];
            % divide into training and test data for rest of the gestures.
            [P_train, P_test] = A3.divideDataRowWise(P, trainPercent);
            
            % Prepare the final training and test matrices.
            train = [M_train; P_train];
            test = [M_test; P_test];
        end
        
        function [P1, P2] = divideDataRowWise(M, percent)
            [totalRows, ~] = size(M);
            numP1 = round(totalRows * percent / 100);
            numP2 = totalRows - numP1;
            
            P1 = M(1:numP1, :);
            P2 = M(1:numP2, :);
        end
        
    end
    
    
end