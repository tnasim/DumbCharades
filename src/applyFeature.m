
% Total rows in the file
global TOTAL_ROWS;
TOTAL_ROWS = 1340;

% Number of rows per action of same gesture
global TOTAL_SENSORS;
TOTAL_SENSORS = 67;

global TOTAL_COLUMNS;
TOTAL_COLUMNS = 46;

baseDir = '../output/task1/';
dirList = dir(strcat(baseDir, '*.csv'));
num_of_gestures = length(dirList);
data = zeros(num_of_gestures, 90);

% ---------------------------------------------------------
% Change Sensor here to view output on different sensors.
% ---------------------------------------------------------
sens1 = uint32(Sensor.GLX);
% ---------------------------------------------------------

for i = 1:num_of_gestures
    fileName = dirList(i).name;
    if(startsWith(fileName, '.'))
        continue
    end
   
    filePath = strcat(baseDir, fileName);
    mat = csvread(filePath,0,2);

    graphOpt = ["g-", "b-", "k-", "c-", "r-", "g--", "b--", "k--", "c--", "r--", "g-^", "b-^", "k-^", "c-^", "r-^", "g:*", "b:*", "k:*", "c:*", "r:*"];

    %performDWT(standardized_M, sens1, graphOpt);

    avg = calculateAverage(mat, sens1);
    %res = calcDWT(avg);
    %res = zscore(avg, 0, 2);
    res = normr(avg);
    [dimX, dimY] = size(res);
    data(i, 1:dimY) = res;
end

multiPlot(data);

% dim = size(TASK1_M);
% sum_mat = sum(TASK1_M,2);
% min_mat = min(TASK1_M,[], 2);
% avg = mean(TASK1_M, 2);
% root_min_square = rms(TASK1_M, 2);

%normalized_m = normr(mat);
%standardized_M = zscore(mat, 0, 2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate DWT for a single row
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function CA = calcDWT(Row)
    [CA,CH,CV,CD] = dwt2(Row,'db1');
    return;
end
%disp(avg(1, 1:end));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Discrete Wavelet Transform on the matrix M
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function a = performDWT(M, sensorRow, plotType)
    global TOTAL_ROWS;
    global TOTAL_SENSORS;
    figure;
    k = 1;
    for i = sensorRow:TOTAL_SENSORS:TOTAL_ROWS
        Row = M(i, 3:end-1);
        complexPlot(Row, sensorRow, i);
        k = k+1;
        if k>20
            k = 1;
        end
    end
    title(['Sensor ', int2str(sensorRow), ' data']);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Complex plot for each row on the same figure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function a = complexPlot(Row,initialVal,currentVal)
        if currentVal>initialVal
            hold on;
        end
        plot(calcDWT(Row));
        if currentVal>initialVal
            hold off;
        end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Return row containing the average of the matrix M
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function avg = calculateAverage(M, sensorNumber)
    global TOTAL_ROWS;
    global TOTAL_SENSORS;
    global TOTAL_COLUMNS;
    
    k = 0;
    [r, c] = size(M);
    avg = zeros(c-3);
    for i = sensorNumber:TOTAL_SENSORS:TOTAL_ROWS
        Row = M(i, 3:end-1);
        avg = avg + Row;
        k = k + 1;
    end
    avg = avg(1, 1:end);
    avg = avg/k;
    return
end