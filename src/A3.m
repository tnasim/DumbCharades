classdef A3
    
    
    properties (Constant)
        gestList = ["about", "and", "can", "cop", "deaf", "decide", "father", "find", "go out", "hearing"];
    end
    
    methods (Static)
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Get negative classes. pick only half of the total P values
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function a = getFilteredNegativeClasses(P)
            result = []
            [n,~] = size(P)
            for i = 1:2:n
                result = [result;P(i,:)];
            end
            a = result;
        end
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Get labeled feature matrix for a particular gesture.
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function [train, test] = getClassData(gesture, trainPercent)
            M = []
            switch gesture
                case 'about'
                    M = PCA.getFeatureMatrix_ABOUT(gesture);
                    
                    disp(['Reading data for ', gesture]);
                    g = A3.gestList(A3.gestList~='about');
                    glen = length(g);
                    P = [];
                    for i = 1:(glen+1)
                        gest = A3.gestList(i);
                        if(gest ~= gesture)
                            disp(['Reading data for ', gest]);
                            X = PCA.getFeatureMatrix_ABOUT(gest);
                            P = [P; A3.getFilteredNegativeClasses(X)];
                        end
                    end
                case 'and'
                    M = PCA.getFeatureMatrix_AND(gesture);
                    
                    disp(['Reading data for ', gesture]);
                    g = A3.gestList(A3.gestList~='and');
                    glen = length(g);
                    P = [];
                    for i = 1:(glen+1)
                        gest = A3.gestList(i);
                        if(gest ~= gesture)
                            disp(['Reading data for ', gest]);
                            X = PCA.getFeatureMatrix_AND(gest);
                            P = [P; A3.getFilteredNegativeClasses(X)];
                        end
                    end
                case 'can'
                    M = PCA.getFeatureMatrix_CAN(gesture);
                    
                    disp(['Reading data for ', gesture]);
                    g = A3.gestList(A3.gestList~='can');
                    glen = length(g);
                    P = [];
                    for i = 1:(glen+1)
                        gest = A3.gestList(i);
                        if(gest ~= gesture)
                            disp(['Reading data for ', gest]);
                            X = PCA.getFeatureMatrix_CAN(gest);
                            P = [P; A3.getFilteredNegativeClasses(X)];
                        end
                    end
                case 'cop'
                    M = PCA.getFeatureMatrix_COP(gesture);
                    
                    disp(['Reading data for ', gesture]);
                    g = A3.gestList(A3.gestList~='cop');
                    glen = length(g);
                    P = [];
                    for i = 1:(glen+1)
                        gest = A3.gestList(i);
                        if(gest ~= gesture)
                            disp(['Reading data for ', gest]);
                            X = PCA.getFeatureMatrix_COP(gest);
                            P = [P; A3.getFilteredNegativeClasses(X)];
                        end
                    end
                    
                case 'deaf'
                    M = PCA.getFeatureMatrix_DEAF(gesture);
                    
                    disp(['Reading data for ', gesture]);
                    g = A3.gestList(A3.gestList~='deaf');
                    glen = length(g);
                    P = [];
                    for i = 1:(glen+1)
                        gest = A3.gestList(i);
                        if(gest ~= gesture)
                            disp(['Reading data for ', gest]);
                            X = PCA.getFeatureMatrix_DEAF(gest);
                            P = [P; A3.getFilteredNegativeClasses(X)];
                        end
                    end
                case 'decide'
                    M = PCA.getFeatureMatrix_DECIDE(gesture);
                    
                    disp(['Reading data for ', gesture]);
                    g = A3.gestList(A3.gestList~='decide');
                    glen = length(g);
                    P = [];
                    for i = 1:(glen+1)
                        gest = A3.gestList(i);
                        if(gest ~= gesture)
                            disp(['Reading data for ', gest]);
                            X = PCA.getFeatureMatrix_DECIDE(gest);
                            P = [P; A3.getFilteredNegativeClasses(X)];
                        end
                    end
                case 'father'
                    M = PCA.getFeatureMatrix_FATHER(gesture);
                    
                    disp(['Reading data for ', gesture]);
                    g = A3.gestList(A3.gestList~='father');
                    glen = length(g);
                    P = [];
                    for i = 1:(glen+1)
                        gest = A3.gestList(i);
                        if(gest ~= gesture)
                            disp(['Reading data for ', gest]);
                            X = PCA.getFeatureMatrix_FATHER(gest);
                            P = [P; A3.getFilteredNegativeClasses(X)];
                        end
                    end
                case 'find'
                    M = PCA.getFeatureMatrix_AND(gesture);
                    
                    disp(['Reading data for ', gesture]);
                    g = A3.gestList(A3.gestList~='find');
                    glen = length(g);
                    P = [];
                    for i = 1:(glen+1)
                        gest = A3.gestList(i);
                        if(gest ~= gesture)
                            disp(['Reading data for ', gest]);
                            X = PCA.getFeatureMatrix_AND(gest);
                            P = [P; A3.getFilteredNegativeClasses(X)];
                        end
                    end
                case 'go out'
                    M = PCA.getFeatureMatrix_GO_OUT(gesture);
                    
                    disp(['Reading data for ', gesture]);
                    g = A3.gestList(A3.gestList~='go out');
                    glen = length(g);
                    P = [];
                    for i = 1:(glen+1)
                        gest = A3.gestList(i);
                        if(gest ~= gesture)
                            disp(['Reading data for ', gest]);
                            X = PCA.getFeatureMatrix_GO_OUT(gest);
                            P = [P; A3.getFilteredNegativeClasses(X)];
                        end
                    end
                case 'hearing'
                    M = PCA.getFeatureMatrix_HEARING(gesture);
                    
                    disp(['Reading data for ', gesture]);
                    g = A3.gestList(A3.gestList~='hearing');
                    glen = length(g);
                    P = [];
                    for i = 1:(glen+1)
                        gest = A3.gestList(i);
                        if(gest ~= gesture)
                            disp(['Reading data for ', gest]);
                            X = PCA.getFeatureMatrix_HEARING(gest);
                            P = [P; A3.getFilteredNegativeClasses(X)];
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
            disp('Done');
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