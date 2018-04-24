classdef A4
    
    
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
        function [train, test] = getClassData(gesture, user, trainPercent)
            M = []
            disp(user);
            switch gesture
                case 'about'
                    M = PCA2.getFeatureMatrix_ABOUT(gesture, user);
                    
                    disp(['Reading data for ', gesture]);
                    g = A4.gestList(A4.gestList~='about');
                    glen = length(g);
                    P = [];
                    for i = 1:(glen+1)
                        gest = A4.gestList(i);
                        if(gest ~= gesture)
                            disp(['Reading data for ', gest]);
                            X = PCA2.getFeatureMatrix_ABOUT(gest, user);
                            P = [P; A4.getFilteredNegativeClasses(X)];
                        end
                    end
                case 'and'
                    M = PCA2.getFeatureMatrix_AND(gesture, user);
                    
                    disp(['Reading data for ', gesture]);
                    g = A4.gestList(A4.gestList~='and');
                    glen = length(g);
                    P = [];
                    for i = 1:(glen+1)
                        gest = A4.gestList(i);
                        if(gest ~= gesture)
                            disp(['Reading data for ', gest]);
                            X = PCA2.getFeatureMatrix_AND(gest, user);
                            P = [P; A4.getFilteredNegativeClasses(X)];
                        end
                    end
                case 'can'
                    M = PCA2.getFeatureMatrix_CAN(gesture, user);
                    
                    disp(['Reading data for ', gesture]);
                    g = A4.gestList(A4.gestList~='can');
                    glen = length(g);
                    P = [];
                    for i = 1:(glen+1)
                        gest = A4.gestList(i);
                        if(gest ~= gesture)
                            disp(['Reading data for ', gest]);
                            X = PCA2.getFeatureMatrix_CAN(gest, user);
                            P = [P; A4.getFilteredNegativeClasses(X)];
                        end
                    end
                case 'cop'
                    M = PCA2.getFeatureMatrix_COP(gesture, user);
                    
                    disp(['Reading data for ', gesture]);
                    g = A4.gestList(A4.gestList~='cop');
                    glen = length(g);
                    P = [];
                    for i = 1:(glen+1)
                        gest = A4.gestList(i);
                        if(gest ~= gesture)
                            disp(['Reading data for ', gest]);
                            X = PCA2.getFeatureMatrix_COP(gest, user);
                            P = [P; A4.getFilteredNegativeClasses(X)];
                        end
                    end
                    
                case 'deaf'
                    M = PCA2.getFeatureMatrix_DEAF(gesture, user);
                    
                    disp(['Reading data for ', gesture]);
                    g = A4.gestList(A4.gestList~='deaf');
                    glen = length(g);
                    P = [];
                    for i = 1:(glen+1)
                        gest = A4.gestList(i);
                        if(gest ~= gesture)
                            disp(['Reading data for ', gest]);
                            X = PCA2.getFeatureMatrix_DEAF(gest, user);
                            P = [P; A4.getFilteredNegativeClasses(X)];
                        end
                    end
                case 'decide'
                    M = PCA2.getFeatureMatrix_DECIDE(gesture, user);
                    
                    disp(['Reading data for ', gesture]);
                    g = A4.gestList(A4.gestList~='decide');
                    glen = length(g);
                    P = [];
                    for i = 1:(glen+1)
                        gest = A4.gestList(i);
                        if(gest ~= gesture)
                            disp(['Reading data for ', gest]);
                            X = PCA2.getFeatureMatrix_DECIDE(gest, user);
                            P = [P; A4.getFilteredNegativeClasses(X)];
                        end
                    end
                case 'father'
                    M = PCA2.getFeatureMatrix_FATHER(gesture, user);
                    
                    disp(['Reading data for ', gesture]);
                    g = A4.gestList(A4.gestList~='father');
                    glen = length(g);
                    P = [];
                    for i = 1:(glen+1)
                        gest = A4.gestList(i);
                        if(gest ~= gesture)
                            disp(['Reading data for ', gest]);
                            X = PCA2.getFeatureMatrix_FATHER(gest, user);
                            P = [P; A4.getFilteredNegativeClasses(X)];
                        end
                    end
                case 'find'
                    M = PCA2.getFeatureMatrix_AND(gesture, user);
                    
                    disp(['Reading data for ', gesture]);
                    g = A4.gestList(A4.gestList~='find');
                    glen = length(g);
                    P = [];
                    for i = 1:(glen+1)
                        gest = A4.gestList(i);
                        if(gest ~= gesture)
                            disp(['Reading data for ', gest]);
                            X = PCA2.getFeatureMatrix_AND(gest, user);
                            P = [P; A4.getFilteredNegativeClasses(X)];
                        end
                    end
                case 'go out'
                    M = PCA2.getFeatureMatrix_GO_OUT(gesture, user);
                    
                    disp(['Reading data for ', gesture]);
                    g = A4.gestList(A4.gestList~='go out');
                    glen = length(g);
                    P = [];
                    for i = 1:(glen+1)
                        gest = A4.gestList(i);
                        if(gest ~= gesture)
                            disp(['Reading data for ', gest]);
                            X = PCA2.getFeatureMatrix_GO_OUT(gest, user);
                            P = [P; A4.getFilteredNegativeClasses(X)];
                        end
                    end
                case 'hearing'
                    M = PCA2.getFeatureMatrix_HEARING(gesture, user);
                    
                    disp(['Reading data for ', gesture]);
                    g = A4.gestList(A4.gestList~='hearing');
                    glen = length(g);
                    P = [];
                    for i = 1:(glen+1)
                        gest = A4.gestList(i);
                        if(gest ~= gesture)
                            disp(['Reading data for ', gest]);
                            X = PCA2.getFeatureMatrix_HEARING(gest, user);
                            P = [P; A4.getFilteredNegativeClasses(X)];
                        end
                    end
                otherwise
                    disp('wrong gesture name.');
                    
            end
            [r, ~] = size(M);
            M = [M repmat(1,r,1)];
            % divide into training and test data for current gesture
            [M_train, M_test] = A4.divideDataRowWise(M, trainPercent);
            
            [r, ~] = size(P);
            P = [P repmat(0,r,1)];
            % divide into training and test data for rest of the gestures.
            [P_train, P_test] = A4.divideDataRowWise(P, trainPercent);
            
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