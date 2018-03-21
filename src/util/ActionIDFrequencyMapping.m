function a = ActionIDFrequencyMapping()
    dataBaseDir = '../Data';
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