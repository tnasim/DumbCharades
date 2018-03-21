global dataBaseDir;
global IntermediateDataDir;
dataBaseDir = '../Data';
IntermediateDataDir = [dataBaseDir,'/','IntermediateDataFiles'];
addpath('./util/');
dirListing = dir([dataBaseDir,'/','Original']);

for i = 1:length(dirListing)
    tempFilename = erase(dirListing(i).name,'.csv');
    if ~contains(tempFilename,'.','IgnoreCase',true)
        len = length(tempFilename);
        actionName = tempFilename(1:len - 8);
        timeStamp = tempFilename(len - 8 + 1:len);
        tempData = readData(actionName,timeStamp);
        writeData(actionName,tempData);
        
    end
end

disp('Done');

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION: WRITE DATA
%%%%%%%%%%%%%%%%%%%%%%%%%%%
function a = writeData(actionName,tempData)
global dataBaseDir;
global IntermediateDataDir;
data = {};

fileName = [actionName,'.csv'];
if exist(fileName, 'file') ~= 2
    [fileID,message] = fopen( [IntermediateDataDir,'/',fileName], 'a' );
    if fileID == -1
        error('''%s'' read Error: %s', fileName, message);
    end
    [x,y] = size(tempData);
    for i = 1:x
        fprintf(fileID,"%s,",tempData{i,:});
        fprintf(fileID, '\n');
    end
    fclose(fileID);
    return;
end
[fileID,message] = fopen( [dataBaseDir,'/','IntermediateDataFiles','/',fileName], 'rt' );
tempLine = fgetl(fileID);
i=1;
while tempLine ~= -1
    dataTempLine = regexp(tempLine, ',', 'split');
    tempElementsNo = numel(dataTempLine) - 1;
    data(i,:) = dataTempLine(1:tempElementsNo);
    i = i+1;
    tempLine = fgetl(fileID);
end
fclose(fileID);

[x,y] = size(tempData);
[m,n] = size(data);
for i = 1:x
   data(i,n+1:n+y-2) = tempData(i,3:y);
end

[fileID,message] = fopen( [dataBaseDir,'/',fileName], 'a' );
if fileID == -1
    error('''%s'' read Error: %s', fileName, message);
end
[x,y] = size(data);
for i = 1:x
    fprintf(fileID,"%s",data{i,:});
    fprintf(fileID, '\n');
end
fclose(fileID);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION: READ DATA
%%%%%%%%%%%%%%%%%%%%%%%%%%%
function a = readData(actionName,timeStamp)
    global dataBaseDir;
    fileName = [actionName,timeStamp,'.csv'];
    temp = ActionIDFrequencyMapping();
    freq = temp(:,3);
    freq = cellfun(@str2double,freq);
    M = max(freq);
    Action = string(temp(:,1));
    l = find(all(ismember(Action,actionName),2));
    [fileID,message] = fopen( [dataBaseDir,'/','Original','/',fileName], 'rt' );
    if fileID == -1
        error('''%s'' read Error: %s', fileName, message);
    end

    attributeheaders = regexp(fgetl(fileID), ',', 'split');
    % ignore the last 4 rows containing sensor data for Myo_Pose_left,Myo_Pose_Right,Kinect_pose_left,Kinect_pose_right
    nAttributes = numel(attributeheaders)-4;
    attributeheaders = attributeheaders(1,1:nAttributes);
    data = {};
    %First Column ActionName
    data(:,1) = repmat({actionName},[nAttributes,1]);
    %Second Column Attribute Names
    data(:,2) = attributeheaders';
    i = 3;
    data = horzcat(data, repmat({'0'},[nAttributes,M]));
    tempLine = fgetl(fileID);
    while tempLine ~= -1
        dataTempLine = regexp(tempLine, ',', 'split');
        data(:,i) = dataTempLine(1:nAttributes)';
        i = i+1;
        tempLine = fgetl(fileID);
    end
    readingCount = string(i-3);
    x = repmat({readingCount},[nAttributes,1]);
    data = horzcat(data, repmat({readingCount},[nAttributes,1]));
    fclose(fileID);
    a = data;
end