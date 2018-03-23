%% Each row of matrix 'data' will be plotted
%%  on different graph in the same figure
function a = plot_all(data, gesture,sensorName,xLabel,yLabel)
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
    xlabel(xLabel);
    ylabel(yLabel);
	%legend('1','7','9','13')
    %legend('16','19','20','22');
    %legend('23','26','27');
    %legend('28','31','32','34','36');

end