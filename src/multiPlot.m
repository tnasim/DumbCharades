%% Each row of matrix 'data' will be plotted
%%  on different graph in the same figure
function a = multiPlot(data)
    [X, Y] = size(data);
    R = floor(sqrt(X));
    C = ceil(X/R);
    figure
    for i = 1:X
        %disp(strcat('plotting row', num2str(i)) );
        %disp(data(i, :));
        axis([-5 95 -1.2 1.2])
        subplot(R, C, i)
        plot(data(i, :))
        title( strcat( 'Subplot_', num2str(i) ) )
    end
    
end