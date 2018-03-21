function a = ParameterList()
    dataBaseDir = '../Data';
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