function h = plot_graph(P, t, row_labels, x_label, y_label)
% Plots several lines from the matrix of observations P. One observation is
% one row of the matrix -- P(i,:). t is a vector of the same size as P(i,:)
%
% P                 Matrix each row corresponds to one experiment 
% t                 Tabulation for the x axis
% row_labels        Name of the parameter (x axis label)
% x_label           Label of the x axis (parameters)
% y_label           Label of the y axis (value)
% line              Type of line

hold all;
grid on;
colors = 'yrgbcmk';
h = 0;
for i = 1:size(P,1)
    % Choise line style
    c = colors(mod(i, length(colors))+ 1);
    if(i <= length(colors))
        line ='-';
    elseif(i > length(colors) && i <= 2*length(colors))
        line ='--';
    elseif(i > 2*length(colors))
        line ='-.';
    end
    
    % Plot the line
    p = P(i,:);
    h = plot(t, p, strcat(c,line),'DisplayName', row_labels(i), 'YDataSource', 'p');
    set(h,'LineWidth',1.5);
end

legend('toggle');
xlabel(x_label);
ylabel(y_label);

end