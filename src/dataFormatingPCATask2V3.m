global dataBaseDir;
global IntermediateDataDir;
global pcaTask2;

dataBaseDir = '../Data';
IntermediateDataDir = [dataBaseDir,'/','IntermediateDataFiles'];
pcaTask2 = [dataBaseDir ,'/', 'PCATask2'];
addpath('./util/');

folderName = {'DM01','DM07','DM09','DM13','DM16','DM19','DM20','DM22','DM23','DM26','DM27','DM31','DM32','DM34'};
words = {'about','and','can','cop','deaf','decide','father','find','go out', 'goout','go_out','hearing'};
for j = 11:14
    x = [dataBaseDir,'\\Original\\',folderName{j}];
    dirListing = dir(x);
    for i = 1:length(dirListing)
        tempFilename = erase(dirListing(i).name,'.csv');
        if ~contains(tempFilename,'.','IgnoreCase',true)
            len = length(tempFilename);
            actionName = tempFilename(1:len - 8);
            timeStamp = tempFilename(len - 8 + 1:len);
            tempactionName = lower(actionName);
            if any(contains(tempactionName,words))
                folderToRead = [dataBaseDir,'/','Original','/',folderName{j}];
                tempData = readData(actionName,timeStamp,folderToRead);
                folderToWrite = [pcaTask2,'\\',folderName{j}];
                writeData(actionName,tempData,folderToWrite);
            end
        end
        
    end
    
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION: WRITE DATA
%%%%%%%%%%%%%%%%%%%%%%%%%%%
function a = writeData(actionName,tempData,folderToWrite)
    data = {};
    if exist([folderToWrite],'dir') ~=7
        [status, msg, msgID] = mkdir(folderToWrite);
    end
    
    fileName = [folderToWrite,'/',actionName,'.csv'];
    if exist(fileName, 'file') ~= 2
        [fileID,message] = fopen( fileName, 'a' );
        if fileID == -1
            error('''%s'' read Error: %s', fileName, message);
        end
        fclose(fileID);
    end;
    [x,y] = size(tempData);
    for i = 1:x
       dlmwrite(fileName,cellfun(@str2double,tempData(i,:)),'delimiter',',','-append');
    end
  end




%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION: READ DATA
%%%%%%%%%%%%%%%%%%%%%%%%%%%
function a = readData(actionName,timeStamp,folderToRead)
    global dataBaseDir;
    fileName = [actionName,timeStamp,'.csv'];
    temp = ActionIDFrequencyMapping();
    freq = temp(:,3);
    freq = cellfun(@str2double,freq);
    %M = max(freq);
    M = 50;
    Action = string(temp(:,1));
    l = find(all(ismember(Action,actionName),2));
    [fileID,message] = fopen( [folderToRead,'/',fileName], 'rt' );
    if fileID == -1
        error('''%s'' read Error: %s', fileName, message);
    end

    attributeheaders = regexp(fgetl(fileID), ',', 'split');
    % ignore the last 4 rows containing sensor data for Myo_Pose_left,Myo_Pose_Right,Kinect_pose_left,Kinect_pose_right
    nAttributes = numel(attributeheaders)-4;
    data = {};
    i = 1;
    data = {};
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