function R = pr_eval(FRAME, wdir, eval_it, name, min_score)
% Generates a plot consisting of four subplots: precision-gamma, recall-gamma, 
% fmeasure-gamma, relationsnum-gamma. The results are calculated with the
% TOPP thresholding. Here gamma is the TOPP threshold.
%
% FRAME             Data frame
% name              Name of the semantic measure contained in the FRAME
% wdir              Directory where the plot will be saved
% eval_it           Number of measurements (the more, the more precise plot will be generated)
% min_score         Minimum value of score (gamma)

%fprintf('Evaluating results...\n');
R = calc_evaluation_scores(FRAME, name, eval_it, min_score);
plot_pr1(R, 'p%, percent of nearest neighborgs', strcat('topp-', name), wdir);
%fprintf('Evaluation was done.\n');

end

function plot_pr1(R, par_name, par_sname, output_dir)
% Plots a graph containing precision, recall, fmeasure, and number of
% relations plots.
% R             Structure with fields precision, recall, fmeasure, number,
% and t. The first three are matrices
% [(attri|coord|event|hyper|mero|all)*number of measurements]. 
% The two last are vectors of of lenghe = number of measurements. 
% par_sname     Short name of the parameter.
% par_name      Name of the parameter.
% output_dir    Directory to save the parameters.

types = {'attri';'coord';'event';'hyper';'mero';'all'};

h = figure('Visible','off');

%Plot precision
subplot(2,2,1);
h = plot_graph(R.precision, R.t, types, par_name, 'Precision');

% Plot number of relations
subplot(2,2,2);
%hold all
R.number(6,:) = sum(R.number);
plot_graph(R.number, R.t, types, par_name, 'Number of relations');
%plot_number(R.t, R.number, '-', par_name);

%Plot recall
subplot(2,2,3);
plot_graph(R.recall, R.t, types, par_name, 'Recall');

% Plot Fmeasure
subplot(2,2,4);
plot_graph(R.fmeasure, R.t, types, par_name, 'F-Measure');

% Save the plots
saveas(h, strcat(output_dir,par_sname,'.fig'), 'fig');
saveas(h, strcat(output_dir,par_sname,'.png'), 'png');
close(gcf);
%hold off;

end

