classdef FileUtil
    
    properties (Constant)
        dataBaseDirectory = '../Data';
        
        PARAMETERS_FILE_NAME = 'Parameters.csv';
        ACTION_ID_MAPPING_FILE_NAME = 'ActionIDMapping.csv';
        ACTION_ID_DATA_MAPPING_FILE_NAME = 'ActionIDDataMapping.csv';
        SENSOR_DATA_DIRECTORY_NAME = 'ParameterWiseData';
    end
    
    methods (Static)
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Read the parameters (name of sensors) from file
        % returns a cell array containing the sensor names
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function a = getListOfParameters()
            fileName = FileUtil.PARAMETERS_FILE_NAME;
            Parameters = {};
            [fileID,message] = fopen( [FileUtil.dataBaseDirectory,'/',fileName], 'rt' );
            if fileID == -1
                [ID,message] = fopen( [FileUtil.dataBaseDirectory,'/',fileName], 'w' );
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
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Read the Action ID Mapping from file
        %   Each line contains:
        %   ACTION_NAME,ACTION_ID,NUM_OF_COLUMNS
        % returns a cell array containing these values
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function a = readActionIDMappings()
            fileName = FileUtil.ACTION_ID_MAPPING_FILE_NAME;
            
            [fileID,message] = fopen( [FileUtil.dataBaseDirectory,'/',fileName], 'rt' );
            if fileID == -1
                [ID,message] = fopen( [FileUtil.dataBaseDirectory,'/',fileName], 'w' );
                fclose(ID);
                error('''%s'' read Error: %s', fileName, message);
            end
            
            i=1;
            tempLine = fgetl(fileID);
            Parameters = {};
            while tempLine ~= -1
                dataTempLine = regexp(tempLine, ',', 'split');
                tempElementsNo = numel(dataTempLine);
                Parameters(i,:) = dataTempLine(1:tempElementsNo);
                tempLine = fgetl(fileID);
                i = i + 1;
            end
            fclose(fileID);
            a = Parameters;
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Read the Action ID Data Mapping from file
        %   Each line contains: ACTION_ID for corresponding row
        % returns a cell array containing the action IDs
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function a = readActionIDDataMappings()
            fileName = FileUtil.ACTION_ID_DATA_MAPPING_FILE_NAME;
            Parameters = {};
            [fileID,message] = fopen( [FileUtil.dataBaseDirectory,'/',fileName], 'rt' );
            if fileID == -1
                [ID,message] = fopen( [FileUtil.dataBaseDirectory,'/',fileName], 'w' );
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
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Read the Sensor Data from file
        %   Each line contains the sensor data for the given sensor.
        % returns rows of sensor data
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function a = readSensorData(sensorName)
            fileName = strcat(sensorName, '.csv');
            filePath = strcat(FileUtil.dataBaseDirectory,'/', FileUtil.SENSOR_DATA_DIRECTORY_NAME, '/', fileName);
            a = csvread(filePath);
            return
            [fileID,message] = fopen( [FileUtil.dataBaseDirectory,'/', FileUtil.SENSOR_DATA_DIRECTORY_NAME, '/', fileName], 'rt' );
            if fileID == -1
                error('''%s'' read Error: %s', fileName, message);
            end
            
            i=1;
            tempLine = fgetl(fileID);
            Parameters = {};
            while tempLine ~= -1
                dataTempLine = regexp(tempLine, ',', 'split');
                tempElementsNo = numel(dataTempLine);
                Parameters(i,:) = dataTempLine(1:tempElementsNo);
                tempLine = fgetl(fileID);
                i = i + 1;
            end
            fclose(fileID);
            a = Parameters;
        end
        
    end
end