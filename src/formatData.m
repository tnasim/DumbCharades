
global dataBaseDir;
dataBaseDir = ['../CSE572_A2_data','/DM27'];
%chdir(dataBaseDir);
dirListing = dir(dataBaseDir);

for i = 1:length(dirListing)
    tempFilename = erase(dirListing(i).name,'.csv');
    if ~contains(tempFilename,'.','IgnoreCase',true)
        len = length(tempFilename);
        actionName = tempFilename(1:len - 8);
        timeStamp = tempFilename(len - 8 + 1:len);
        %disp(timeStamp);
        %disp(actionName);
        tempData = readData('DM27',actionName,timeStamp);
        writeData(actionName,tempData);
        
    end
end

disp('Done');

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION: WRITE DATA
%%%%%%%%%%%%%%%%%%%%%%%%%%%
function a = writeData(actionName,tempData)
global dataBaseDir;
data = {};
fileName = [actionName,'.csv'];
if exist(fileName, 'file') ~= 2
    [fileID,message] = fopen( [dataBaseDir,'/',fileName], 'a' );
    if fileID == -1
        error('''%s'' read Error: %s', fileName, message);
    end
    [x,y] = size(tempData);
    for i = 1:(x-4) % ignore the last 4 rows containing sensor data for Myo_Pose_left,Myo_Pose_Right,Kinect_pose_left,Kinect_pose_right
        fprintf(fileID,"%s,",tempData{i,:});
        fprintf(fileID, '\n');
    end
    fclose(fileID);
    return;
end
[fileID,message] = fopen( [dataBaseDir,'/',fileName], 'rt' );
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
    fprintf(fileID,"%s,",data{i,:});
    fprintf(fileID, '\n');
end
fclose(fileID);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION: READ DATA
%%%%%%%%%%%%%%%%%%%%%%%%%%%
function a = readData(dirName,actionName,timeStamp)
global dataBaseDir;
fileName = [actionName,timeStamp,'.csv'];
[fileID,message] = fopen( [dataBaseDir,'/',fileName], 'rt' );
if fileID == -1
    error('''%s'' read Error: %s', fileName, message);
end

attributeheaders = regexp(fgetl(fileID), ',', 'split');
nAttributes = numel(attributeheaders);

data = {};
data(:,1) = repmat({actionName},[nAttributes,1]);
data(:,2) = attributeheaders';
i = 3;

tempLine = fgetl(fileID);
while tempLine ~= -1
    dataTempLine = regexp(tempLine, ',', 'split');
    data(:,i) = dataTempLine(1:nAttributes)';
    i = i+1;
    tempLine = fgetl(fileID);
    
end
fclose(fileID);
a = data;
end