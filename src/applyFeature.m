
% Total rows in the file
global TOTAL_ROWS;
TOTAL_ROWS = 1407;

% Number of rows per action of same gesture
global TOTAL_SENSORS;
TOTAL_SENSORS = 67;

global TOTAL_COLUMNS;
TOTAL_COLUMNS = 46;

TASK1_M = csvread('../output/task1/ABOUT.csv',0,2);

dim = size(TASK1_M);
sum_mat = sum(TASK1_M,2);
min_mat = min(TASK1_M,[], 2);
avg = mean(TASK1_M, 2);
root_min_square = rms(TASK1_M, 2);

normalized_m = normr(TASK1_M);
standardized_M = zscore(TASK1_M, 0, 2);

graphOpt = ["g-", "b-", "k-", "c-", "r-", "g--", "b--", "k--", "c--", "r--", "g-^", "b-^", "k-^", "c-^", "r-^", "g:*", "b:*", "k:*", "c:*", "r:*"];

sens1 = uint32(Sensor.ALX);
performDWT(standardized_M, sens1, graphOpt);
%avg = calculateAverage(TASK1_M, sens1);
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
        disp(i);
        if i>sensorRow
            hold on;
        end
        [CA,CH,CV,CD] = dwt2(Row,'db1');
        disp(plotType(k));
        plot(CA, plotType(k));
        k = k+1;
        if k>20
            k = 1;
        end
        if i>sensorRow
            hold off;
        end
    end
    title(['Sensor ', int2str(sensorRow), ' data']);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Return row containing the average of the matrix M
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function avg = calculateAverage(M, sensorNumber)
    global TOTAL_ROWS;
    global TOTAL_SENSORS;
    global TOTAL_COLUMNS;
    
    figure;
    k = 0;
    avg = zeros(TOTAL_COLUMNS-2);
    for i = sensorNumber:TOTAL_SENSORS:TOTAL_ROWS
        Row = M(i, 3:end-1);
        avg = avg + Row;
        k = k + 1;
    end
    avg = avg(1, 1:end);
    avg = avg/k;
    return
end