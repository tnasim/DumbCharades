global dataBaseDir;
global outputDir;
global parameterCount;
global IntermediateDataDir;
addpath('./util/');
parameterCount = 67;
dataBaseDir = '../Data';
IntermediateDataDir = [dataBaseDir,'/','IntermediateDataFiles'];
outputDir = [dataBaseDir,'/','ParameterWiseData'];

createFiles();
%fillParemeterFiles();


function a = getListOfParameters()
    global dataBaseDir;
    fileName = 'Parameters.csv';
    Parameters = {};
    [fileID,message] = fopen( [dataBaseDir,'/',fileName], 'rt' );
    if fileID == -1
        [ID,message] = fopen( [dataBaseDir,'/',fileName], 'w' );
        fclose(ID);
        error('''%s'' read Error: %s', fileName, message);
    end
    i=1;
    tempParameter = fgetl(fileID);
    while tempParameter ~= -1
        Parameters = [Parameters;tempParameter];
        tempParameter = fgetl(fileID);
    end
    fclose(fileID);
    a = Parameters;
end
function a = createFilesForEachParameter()
global outputDir;
 parameterList = getListOfParameters();
    for i = 1:length(parameterList)
     tempParameterFileName = [parameterList{i},'.csv'];
     if exist(tempParameterFileName, 'file') ~= 2
            [tempfileID,message] = fopen( [outputDir, '/',tempParameterFileName], 'a' );
            if tempfileID == -1
                error('''%s'' read Error: %s', tempParameterFileName, message);
            end
            fclose(tempfileID);
     end
    a = true;
    end
end

function a = createFiles()
    global dataBaseDir;
    ActionIDDataMapping = 'ActionIDDataMapping.csv';
    Frequency = 'Frequency.csv';
    featureVector = 'FeatureVector.csv';
    tempParameterFileName = [dataBaseDir, '/',ActionIDDataMapping];
    tempFrequencyFileName = [dataBaseDir, '/',Frequency];
    tempFeatureVectorFileName = [dataBaseDir, '/',featureVector];
    if exist(tempParameterFileName, 'file') ~= 2
        [tempfileID,message] = fopen( tempParameterFileName, 'a' );
        if tempfileID == -1
            error('''%s'' read Error: %s', tempParameterFileName, message);
        end
        fclose(tempfileID);
    end
    
    if exist(tempFrequencyFileName, 'file') ~= 2
        [tempfileID,message] = fopen( tempFrequencyFileName, 'a' );
        if tempfileID == -1
            error('''%s'' read Error: %s', tempFrequencyFileName, message);
        end
        fclose(tempfileID);
    end
    
    if exist(tempFeatureVectorFileName, 'file') ~= 2
        [tempfileID,message] = fopen( tempFeatureVectorFileName, 'a' );
        if tempfileID == -1
            error('''%s'' read Error: %s', tempFeatureVectorFileName, message);
        end
        fclose(tempfileID);
    end
    
    a = true;
end

function a = readInterDataFile(filePath)
    [fileID,message] = fopen( filePath, 'rt' );
    if fileID == -1
        error('''%s'' read Error: %s', fileName, message);
    end
    i=1;
    dataTempLine = fgetl(fileID);
    data = {};
    while dataTempLine ~= -1
       dataTempLine = regexp(dataTempLine, ',', 'split');
       tempElementsNo = numel(dataTempLine) - 1;
       data(i,:) = dataTempLine(1:tempElementsNo);
       i = i+1;
       dataTempLine = fgetl(fileID);
    end
    fclose(fileID);
    a = data;
end
function a = getActionIDMapping()
    global dataBaseDir;
    fileName = 'ActionIDMapping.csv';
    ActionIDMapping = {};
    [fileID,message] = fopen( [dataBaseDir,'\\',fileName], 'rt' );
    if fileID == -1
        [ID,message] = fopen( [dataBaseDir,'\\',fileName], 'w' );
        fclose(ID);
        error('''%s'' read Error: %s', fileName, message);
    end
    i=1;
    tempLine = fgetl(fileID);
    while tempLine ~= -1
        ActionIDMapping(i,:) = regexp(tempLine, ',', 'split');
        tempLine = fgetl(fileID);
        i = i + 1;
    end
    fclose(fileID);
    a = ActionIDMapping;
end

function a = fillParemeterFiles()
    global dataBaseDir;
    global outputDir;
    global parameterCount;
    global IntermediateDataDir;
    intDir = 'IntermediateDataFiles';
    ActionIDDataMapping = 'ActionIDDataMapping.csv';
    Frequency = 'Frequency.csv';
    actionIDMapping = getActionIDMapping();
    parameterList = getListOfParameters();
    [a b] = size(actionIDMapping);
    
    for m = 1:a
        fileName = [actionIDMapping{m,1},'.csv'];
        tempIntData = readInterDataFile([IntermediateDataDir,'/',fileName]);
        tempIntData(:,1:2) = [];
        [x y] = size(tempIntData);
        iterationCount = tempIntData(:,y);
        tempIntData(:,y) = [];
        y = y - 1;
        if rem(x,parameterCount) ~= 0
            error('not all paramters recorded');
        end
        
        for i =1:x/parameterCount
            for j = 1:parameterCount
                dlmwrite([outputDir, '\\',parameterList{j},'.csv'],cellfun(@str2double,tempIntData((i-1)*parameterCount + j,:)),'delimiter',',','-append');
            end
            dlmwrite([dataBaseDir, '\\',Frequency],cellfun(@str2double,iterationCount(j,1)),'delimiter',',','-append'); 
            dlmwrite([dataBaseDir, '\\',ActionIDDataMapping],cellfun(@str2double,actionIDMapping(m,2)),'delimiter',',','-append'); 
        end
    end
    
    a = true;
end