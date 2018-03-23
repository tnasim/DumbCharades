global dataBaseDir;
global IntermediateDataDir;
dataBaseDir = '../Data';
IntermediateDataDir = [dataBaseDir,'/','IntermediateDataFiles'];
addpath('./util/');

%{
actionName = 'find';
sensorName = Sensor.GRZ;
y = getX(actionName,sensorName);
plot_all(y,actionName,'GRZ','Time t ( unit = 4 ms)','amplitude');

figure;
Z=fft(y,[],2);
plot(0:1:44,Z);
title('Find - FFT on GRZ');
xlabel('Frequency')
ylabel('|P(f)|');

figure;
%EMGR = horzcat(getX(actionName,Sensor.EMG0R),getX(actionName,Sensor.EMG1R),getX(actionName,Sensor.EMG2R),getX(actionName,Sensor.EMG3R),getX(actionName,Sensor.EMG4R),getX(actionName,Sensor.EMG5R),getX(actionName,Sensor.EMG6R),getX(actionName,Sensor.EMG7R));
%plot(EMGR);

for i=1:10
    
end
EMGR = getX(actionName,Sensor.EMG0R);

figure;
a=fft(EMGR(2,:),[],2);
plot(0:1:44,a);
%}


%{
COP
actionName = 'COP';
sensorName = Sensor.ARZ;
y = getX(actionName,sensorName);
plot_all(y,actionName,'ARZ','Time t ( unit = 4 ms)','amplitude');


figure;
y = std(y,0,2);
figure;
histogram(y);
title('COP - ARZ - STD');
xlabel('Feature Vale')
ylabel('Frequency');
%}

%{
actionName = 'DEAF';
sensorName = Sensor.ARX;
y = getX(actionName,sensorName);
plot_all(y,actionName,'ARX','Time t ( unit = 4 ms)','amplitude');



y = mad(y,0,2);
figure;
histogram(y);
title('DEAF - ARX - MAD');
xlabel('Feature Vale')
ylabel('Frequency');
%}

%{
actionName = 'father';
sensorName = Sensor.ALX;
y = getX(actionName,sensorName);
plot_all(y,actionName,'ALX','Time t ( unit = 4 ms)','amplitude');


sensorName = Sensor.ALY;
y = getX(actionName,sensorName);
plot_all(y,actionName,'ALY','Time t ( unit = 4 ms)','amplitude');

sensorName = Sensor.ALZ;
y = getX(actionName,sensorName);
plot_all(y,actionName,'ALZ','Time t ( unit = 4 ms)','amplitude');


actionName = 'can';
sensorName = Sensor.ARX;
y = getX(actionName,sensorName);
plot_all(y,actionName,'ARX','Time t ( unit = 4 ms)','amplitude');
figure;
[cA,cH,cV,cD] = dwt2(y,'haar')
plot(cA);
xlabel('Approximation coefficient')
ylabel('Amplitude');


y = std(y,0,2);
figure;
histogram(y)
xlabel('Feature Vale')
ylabel('Frequency');

sensorName = Sensor.ARY;
y = getX(actionName,sensorName);
plot_all(y,actionName,'ARY','Time t ( unit = 4 ms)','amplitude');
figure;
[cA,cH,cV,cD] = dwt2(y,'haar')
plot(cA);
xlabel('Approximation coefficient')
ylabel('Amplitude');


sensorName = Sensor.ARZ;
y = getX(actionName,sensorName);
plot_all(y,actionName,'ARZ','Time t ( unit = 4 ms)','amplitude');
figure;
[cA,cH,cV,cD] = dwt2(y,'haar')
plot(cA);
xlabel('Approximation coefficient')
ylabel('Amplitude');
%}
%{
sensorName = Sensor.GRX;
y = getX(actionName,sensorName);
plot_all(y,actionName,'GRX','Time t ( unit = 4 ms)','amplitude');


sensorName = Sensor.GRY;
y = getX(actionName,sensorName);
plot_all(y,actionName,'GRY','Time t ( unit = 4 ms)','amplitude');

sensorName = Sensor.GRZ;
y = getX(actionName,sensorName);
plot_all(y,actionName,'GRZ','Time t ( unit = 4 ms)','amplitude');

figure;
Z=fft(y,[],2);
plot(0:1:44,Z);


sensorName = Sensor.ORR;
y = getX(actionName,sensorName);
plot_all(y,actionName,'ORR','Time t ( unit = 4 ms)','amplitude');

sensorName = Sensor.OPR;
y = getX(actionName,sensorName);
plot_all(y,actionName,'OPR','Time t ( unit = 4 ms)','amplitude');

sensorName = Sensor.OYR;
y = getX(actionName,sensorName);
plot_all(y,actionName,'OYR','Time t ( unit = 4 ms)','amplitude');


sensorName = Sensor.EMG0R;
y = getX(actionName,sensorName);
plot_all(y,actionName,'EMG0R','Time t ( unit = 4 ms)','amplitude');

figure;
Z=fft(y,[],2);
plot(0:1:44,Z);

sensorName = Sensor.EMG1R;
y = getX(actionName,sensorName);
plot_all(y,actionName,'EMG1R','Time t ( unit = 4 ms)','amplitude');

figure;
Z=fft(y,[],2);
plot(0:1:44,Z);

sensorName = Sensor.EMG2R;
y = getX(actionName,sensorName);
plot_all(y,actionName,'EMG2R','Time t ( unit = 4 ms)','amplitude');

figure;
Z=fft(y,[],2);
plot(0:1:44,Z);

%x = std(y,0,2);
%figure
%plot(x,'-o');

%}

%{
actionName = 'can';
sensorName = Sensor.ARY;
yR = getX(actionName,sensorName);
plot_all(yR,actionName,'ARY','Time t ( unit = 4 ms)','amplitude');


sensorName = Sensor.ALY;
yL = getX(actionName,sensorName);
plot_all(yL,actionName,'ALY','Time t ( unit = 4 ms)','amplitude');

for i = 1:10
   [r(i,:),lag(i,:)] = xcorr(yR(i,:),yL(i,:));

end

figure;
for i = 1:10
    plot(lag(i,:)/15,r(i,:));
    hold on;
end
xlabel('Lag');
title('Action - CAN - Cross CoRelation between ALY and ARY');    
hold off;






EMGR = horzcat(getX(actionName,Sensor.EMG0R),getX(actionName,Sensor.EMG1R),getX(actionName,Sensor.EMG2R),getX(actionName,Sensor.EMG3R),getX(actionName,Sensor.EMG4R),getX(actionName,Sensor.EMG5R),getX(actionName,Sensor.EMG6R),getX(actionName,Sensor.EMG7R));
EMGL = horzcat(getX(actionName,Sensor.EMG0L),getX(actionName,Sensor.EMG1L),getX(actionName,Sensor.EMG2L),getX(actionName,Sensor.EMG3L),getX(actionName,Sensor.EMG4L),getX(actionName,Sensor.EMG5L),getX(actionName,Sensor.EMG6L),getX(actionName,Sensor.EMG7L));

for i = 1:10
    
   [w(i,:),lag1(i,:)] = xcorr(EMGR(i,:),EMGL(i,:));

end
figure;
for i = 1:10
    plot(lag1(i,:)/15,w(i,:));
    hold on;
end
xlabel('Lag');
title('Action - CAN - Cross CoRelation between EMG-R and EMG-L');    
hold off;


%}

%{
actionName = 'DECIDE';
sensorName = Sensor.ARY;
yR = getX(actionName,sensorName);
plot_all(yR,actionName,'ARY','Time t ( unit = 4 ms)','amplitude');

actionName = 'DECIDE';
sensorName = Sensor.ALY;
yL = getX(actionName,sensorName);
plot_all(yR,actionName,'ALY','Time t ( unit = 4 ms)','amplitude');

for i = 1:10
    
   [w(i,:),lag1(i,:)] = xcorr(yR(i,:),yL(i,:));

end

figure;
for i = 1:10
    plot(lag1(i,:)/15,w(i,:));
    hold on;
end
xlabel('Lag');
title('Action - DECIDE - Cross CoRelation between ARY and ALY');    
hold off;
%}

%GO_OUT
%{
actionName = 'GO_OUT';
X0R = getX(actionName,Sensor.EMG0R);
X1R = getX(actionName,Sensor.EMG1R);
X2R = getX(actionName,Sensor.EMG2R);
X3R = getX(actionName,Sensor.EMG3R);
X4R = getX(actionName,Sensor.EMG4R);
X5R = getX(actionName,Sensor.EMG5R);
X6R = getX(actionName,Sensor.EMG6R);
X7R = getX(actionName,Sensor.EMG7R);
for j = 1:14
    
    
   s = vertcat(X0R(j,:),X1R(j,:),X2R(j,:),X3R(j,:),X4R(j,:),X5R(j,:),X6R(j,:),X7R(j,:));
    Y(j,:) = mean(s,1);
   
    
end
plot_all(Y,'GO OUT','EMG','Time t ( unit = 4 ms)','amplitude');




Z = rms(Y,2);
figure;
histogram(Z);
title('GO OUT - EMG - RMS');
xlabel('Feature Value')
ylabel('Frequency');
%}

%HEARING
%ABOUT - change action name to extract feature for ABOUT and HEARING
%{
actionName = 'ABOUT';
%{
sensorName = Sensor.ARZ;
y = getX(actionName,sensorName);
plot_all(y,actionName,'ARZ','Time t ( unit = 4 ms)','amplitude');


Z = mad(y,0,2);
figure;
histogram(Z);
title('GO OUT - ARZ - MAD');
xlabel('Feature Value')
ylabel('Frequency');
%}

X0R = getX(actionName,Sensor.EMG0R);
X1R = getX(actionName,Sensor.EMG1R);
X2R = getX(actionName,Sensor.EMG2R);
X3R = getX(actionName,Sensor.EMG3R);
X4R = getX(actionName,Sensor.EMG4R);
X5R = getX(actionName,Sensor.EMG5R);
X6R = getX(actionName,Sensor.EMG6R);
X7R = getX(actionName,Sensor.EMG7R);
for j = 1:13
    
    
   s = vertcat(X0R(j,:),X1R(j,:),X2R(j,:),X3R(j,:),X4R(j,:),X5R(j,:),X6R(j,:),X7R(j,:));
    Y(j,:) = mean(s,1);
   
    
end
plot_all(Y,'ABOUT','EMG','Time t ( unit = 4 ms)','amplitude');




Z = mad(Y,1,2);
figure;
histogram(Z);
title('ABOUT - EMG - MAD');
xlabel('Feature Value')
ylabel('Frequency');
%}

%{
%GO_OUT
actionName = 'GO_OUT';
sensorName = Sensor.EMG3R;
yR = getX(actionName,sensorName);
plot_all(yR,actionName,'ARY','Time t ( unit = 4 ms)','amplitude');

actionName = 'GO_OUT';
sensorName = Sensor.EMG0R;
yL = getX(actionName,sensorName);
plot_all(yL,actionName,'ALY','Time t ( unit = 4 ms)','amplitude');
%}

%ABPUT-OPR
%{
actionName = 'ABOUT';
sensorName = Sensor.OPR;
y = getX(actionName,sensorName);
plot_all(y,actionName,'OPR','Time t ( unit = 4 ms)','amplitude');

Z = mad(y,1,2);
figure;
histogram(Z);
title('ABOUT - OPR - MAD');
xlabel('Feature Value')
ylabel('Frequency');
%}

function a = getX(gesture,sensorName)
    global IntermediateDataDir;
    dirListing = dir(IntermediateDataDir);
    k=1;
    for i = 3:16
        tempFoldername = dirListing(i).name;
        if ~contains(tempFoldername,'.','IgnoreCase',true)
            fileName = [IntermediateDataDir,'/',tempFoldername,'/',gesture,'.csv'];
            if exist(fileName, 'file') == 2
                temp = csvread([IntermediateDataDir,'/',tempFoldername,'/',gesture,'.csv'],0,3);
                y(k,:) = temp(sensorName,:);
                k = k + 1;
            end
            
        end
    end
    a = y;
end
