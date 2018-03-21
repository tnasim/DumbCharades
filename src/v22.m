global dataBaseDir;
global IntermediateDataDir;
dataBaseDir = '../Data';
IntermediateDataDir = [dataBaseDir,'/','IntermediateDataFiles'];
addpath('./util/');




actionName = 'And';
sensorName = Sensor.ALX;
y = getX(actionName,sensorName);
plot_all(y,actionName,'ALX');

sensorName = Sensor.ALY;
y = getX(actionName,sensorName);
plot_all(y,actionName,'ALY');

sensorName = Sensor.ALZ;
y = getX(actionName,sensorName);
plot_all(y,actionName,'ALZ');


sensorName = Sensor.ARX;
y = getX(actionName,sensorName);
plot_all(y,actionName,'ARX');

sensorName = Sensor.ARY;
y = getX(actionName,sensorName);
plot_all(y,actionName,'ARY');

sensorName = Sensor.ARZ;
y = getX(actionName,sensorName);
plot_all(y,actionName,'ARZ');


sensorName = Sensor.GRX;
y = getX(actionName,sensorName);
plot_all(y,actionName,'GRX');


sensorName = Sensor.GRY;
y = getX(actionName,sensorName);
plot_all(y,actionName,'GRY');

sensorName = Sensor.GRZ;
y = getX(actionName,sensorName);
plot_all(y,actionName,'GRZ');

%x = std(y,0,2);
%figure
%plot(x,'-o');


%figure;
%Z=fft(y,[],2);
%plot(0:1:44,Z);

function a = getX(gesture,sensorName)
    global IntermediateDataDir;
    dirListing = dir(IntermediateDataDir);
    k=1;
    for i = 3:25
        tempFoldername = dirListing(i).name;
        if ~contains(tempFoldername,'.','IgnoreCase',true)
            temp = csvread([IntermediateDataDir,'/',tempFoldername,'/',gesture,'.csv'],0,3);
            y(k,:) = temp(sensorName,:);
            k = k + 1;
        end
    end
    a = y;
end
