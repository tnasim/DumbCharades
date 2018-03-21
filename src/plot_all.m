%% Each row of matrix 'data' will be plotted
%%  on different graph in the same figure
function a = plot_all(data, gesture,sensorName)
    [X, Y] = size(data);
    figure
    
    for i = 1:X
        %disp(strcat('plotting row', num2str(i)) );
        %disp(data(i, :));
        plot(data(i, :));
        hold on;
    end
    hold off;
    title(['plot ',gesture, '-', sensorName]);
end