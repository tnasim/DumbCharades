%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SAMPLE CODE TO READ PARAMETER AND MAPPING FILES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

listParam = FileUtil.getListOfParameters();
listActionIDMappings = FileUtil.readActionIDMappings();
listActionIDDataMappings = FileUtil.readActionIDDataMappings();

totalNumberOfGestures = 10;

% Change sensor name below to get result for that sensor:
% OPL <--> ORL

M1 = FileUtil.readSensorData('OPL');
disp(listActionIDDataMappings);
A = M1(1, :)'

%R = pcov(A, B)


%disp(avgMatrix);
%multiPlot(avgMatrix);

% correlation
output = [];
k = 1;
X = [];
for i = 1:length(listActionIDDataMappings)
    if str2num(listActionIDDataMappings{i})~=k
        k = k+1;
        avg = mean(X);
        output = [output;avg];
        X = [M1(i,:)];
    else 
        X = [X;M1(i,:)];
    end    
end
avg = mean(X);
output = [output;avg];
fs = 42;
minprom = 0.0005;
mindist_xunits = 0.3;
minpkdist = floor(mindist_xunits/(1/fs));

% Separate peak analysis for 3 different channels
for k = 1:length(output(:,1))
    [c, lags] = xcorr(output(:,k));

    [pks,locs] = findpeaks(c,...
        'minpeakprominence',minprom,...
        'minpeakdistance',minpkdist);

    tc = (1/fs)*lags;
    tcl = tc(locs);

    % Feature 1 - peak height at 0
    if(~isempty(tcl))   % else f1 already 0
        feats(3*(k-1)+1) = pks((end+1)/2);
    end
    % Features 2 and 3 - position and height of first peak 
    if(length(tcl) >= 3)   % else f2,f3 already 0
        feats(3*(k-1)+2) = tcl((end+1)/2+1);
        feats(3*(k-1)+3) = pks((end+1)/2+1);
    end
end

norm = normr(output);
disp(norm);
disp(feats);