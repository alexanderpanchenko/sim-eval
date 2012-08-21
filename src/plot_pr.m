function plot_pr(precision, precision2, recall, recall2, fmeasure, fmeasure2, number,number2, par, par_name, par_sname, output_dir)
% Plots a graph containing precision, recall, fmeasure, and number of
% relations plots.
% precision, precision2,...,fmeasure2       Matrices where every column is
% a vector (attri,coord,event,hyper,mero,all)' for parameter value. 
% par           Parameter tabulation.
% par_name      Name of the parameter.
% output_dir    Directory to save the parameters.

types = {'attri';'coord';'event';'hyper';'mero';'all'};

%Plot precision
subplot(2,2,1);
plot_graph(precision, par, types, par_name, 'Precision','-');
plot_graph(precision2, par, types, par_name, 'Precision','--');

% Plot number of relations
subplot(2,2,2);
hold all
plot_number(par,number,'-',par_name);
plot_number(par,number2,'--',par_name);

%Plot recall
subplot(2,2,3);
plot_graph(recall, par, types, par_name, 'Recall', '-');
plot_graph(recall2, par, types, par_name, 'Recall', '--');

% Plot Fmeasure
subplot(2,2,4);
plot_graph(fmeasure, par, types, par_name, 'F-Measure', '-');
plot_graph(fmeasure2, par, types, par_name, 'F-Measure', '--');

% Save the plots
saveas(gcf, strcat(output_dir,par_sname,'.fig'), 'fig');
saveas(gcf, strcat(output_dir,par_sname,'.png'), 'png');

end

function plot_graph(P, t, row_labels, x_label, y_label, line)
% Plots a precision, recall, or fmeasure graph plots
% P                 Matrix each row corresponds to one experiment 
% t                 Tabulation for the x axis
% row_labels        Name of the parameter (x axis label)
% x_label           Label of the x axis (parameters)
% y_label           Label of the y axis (value)
% line              Type of line
hold all;
grid on;
colors = 'krgbcm';
for i = 1:size(P,1)
    p = P(i,:);
    c = colors(mod(i, length(colors))+ 1);
    h = plot(t, p, strcat(c,line) ,'DisplayName', row_labels(i), 'YDataSource', 'p');
    set(h,'LineWidth',1.5);
end

legend('toggle');
xlabel(x_label);
ylabel(y_label);

end

function plot_number(t,number,line,plabel)
% Plots number of constructed relations
%   t           Values of a thresholding parameter
%   number      Number of relations
%   line        Type of line e.g. '-' for solid '--' for dashed
%   plabel      X label (varying parameter)

grid on;
h = plot(t,number,line );
set(h,'LineWidth',1.5);
ylabel('Number of relations'); 
xlabel(plabel);

end



