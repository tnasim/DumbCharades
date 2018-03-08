%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SAMPLE CODE TO READ PARAMETER AND MAPPING FILES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% listParam = FileUtil.getListOfParameters();
% listActionIDMappings = FileUtil.readActionIDMappings();
% listActionIDDataMappings = FileUtil.readActionIDDataMappings();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SAMPLE CODE TO READ SENSOR DATA FILES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% sensorDataMatrix = FileUtil.readSensorData('ALX');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SAMPLE CODE TO PLOT DATA FOR A PARTICULAR SENSOR
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
totalNumberOfGestures = 10;

% Change sensor name below to get result for that sensor:
sensorDataMatrix = FileUtil.readSensorData('ALX');

[numOfParams, ~] = size(listParam);
[sensX,sensY] = size(sensorDataMatrix);
[totalDataMappings, ~] = size(listActionIDDataMappings);

% sumMatrix(i) will contain columnwise sum of all 20 or 21 rows for ith gesture
%  e.g. sumMatrix(1) will contain sum of sensor data for ABOUT
sumMatrix = zeros(totalNumberOfGestures, sensY);

% avgMatrix(i) will contain columnwise average for ith gesture
avgMatrix = zeros(totalNumberOfGestures, sensY);

currentGestureId = 1;
gestureActionCount = zeros(1, totalNumberOfGestures);

for i = 1:totalDataMappings
    idCell = listActionIDDataMappings(i); % this will give value in a cell format; e.g. {'1'}
    gestureID = str2num(idCell{1}); % get the numeric value from the cell
    gestureActionCount(gestureID) = gestureActionCount(gestureID) + 1;
    sumMatrix(gestureID, :) = sumMatrix(gestureID, :) + sensorDataMatrix(i, :);
end

for i = 1:totalNumberOfGestures
    avgMatrix(i, :) = sumMatrix(i, :) / gestureActionCount(i);
end

%disp(avgMatrix);
multiPlot(avgMatrix);
