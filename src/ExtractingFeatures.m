global dataBaseDir;
global ParameterWiseDataDir;
global parameterCount;
global IntermediateDataDir;
addpath('./util/');
parameterCount = 67;
dataBaseDir = '../Data';
IntermediateDataDir = [dataBaseDir,'/','IntermediateDataFiles'];
ParameterWiseDataDir = [dataBaseDir,'/','ParameterWiseData'];

featureVectors = {};
totalReadings = csvread( [dataBaseDir,'/','ActionIDDataMapping.csv']);
noOfReadings = numel(totalReadings);

extractFeatures();

function a = LoadAllParameters()
    global ParameterWiseDataDir;
    parameterList = ParameterList();
    for i = 1:size(parameterList)
        filePath = [ParameterWiseDataDir,'/',parameterList{i,1},'.csv'];
        parameterData{i} = csvread(filePath);
    end
    a = parameterData;
end

function a = loadFrequencyForParameters()
    global dataBaseDir;
    filename = 'Frequency.csv';
    a = csvread([dataBaseDir,'/',filename]);
end
function a = extractFeatures()
    parameterData = LoadAllParameters();
    frequency = loadFrequencyForParameters();
    sizeofData = numel(frequency);
    featureVector = {};
    for i = 1:sizeofData
        f = frequency(i,1);
        eachRowOfAllParameters = {};
        for j = 1:length(parameterData)
           eachRowOfAllParameters= [eachRowOfAllParameters,parameterData{1,j}(i,1:f)'];
        end
        eachRowOfAllParameters = cell2mat(eachRowOfAllParameters);
        mean = findMean(eachRowOfAllParameters,f);
        std = findStandardDeviation(eachRowOfAllParameters,f);
        rms = findRMS(eachRowOfAllParameters,f);
        mav0 = findMeanAbsoluteDeviation(eachRowOfAllParameters,f);
        mav1 = findMedianAbsoluteDeviation(eachRowOfAllParameters,f);
        featureVector = horzcat(mean,std,rms,mav0,mav1);
        writeFeatureVector(featureVector);
    end
    
    
end

function a = writeFeatureVector(featureVector)
    global dataBaseDir;
    featureVectorFile = 'FeatureVector.csv';
    dlmwrite([dataBaseDir, '\\',featureVectorFile],featureVector(1,:),'delimiter',',','-append'); 
    a = true;
end

function a = findMean(parameters,frequency)
    a = mean(parameters,1);
end

function a = findStandardDeviation(parameters,frequency)
    a = std(parameters,0,1);
end

function a = findRMS(parameters,frequency)
    a = rms(parameters,1);
end

function a = findMeanAbsoluteDeviation(parameters,frequency)
    a = mad(parameters,0);
end

function a = findMedianAbsoluteDeviation(parameters,frequency)
    a = mad(parameters,1);
end
