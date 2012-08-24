function pr_graph(frame_paths, out_dir, eval_it,  min_score, id)
% Generates a recall-precision graph for a given data.
%
% frame_paths       A cell array containing paths to .mat or .csv containing the BLESS frames
% out_dir           Directory where the plot will be saved
% eval_it           Number of measurements (the more, the more precise plot will be generated)
% min_score         Minimum value of score (gamma)
% id                Additional file identifier

% Set the default values
if (nargin < 5)
    id = '';
end

%fprintf('Drawing a PR-graph...\n');
ALL_ROW = 6;

% Get precision-recall scores
parfor i=1:length(frame_paths)    
    f = load_bless_frame(frame_paths{i}); 
    name = get_frame_name(frame_paths{i});
    R{i} = calc_evaluation_scores(f, name, eval_it, min_score);
end

% Plot the graph   
h = figure('Visible','off');
hold all;
grid on;
for i=1:length(R)
    h = plot(R{i}.recall(ALL_ROW,:), R{i}.precision(ALL_ROW,:), get_line_style(i), 'DisplayName', R{i}.name, 'LineWidth',1.5);    
end
hold off;

xlabel('Recall');
ylabel('Precision');

legend();

% Save the graph
%first_name = get_frame_name(frame_paths{1});
saveas(h, strcat(out_dir, 'pr-graph', id, '.fig'), 'fig');
saveas(h, strcat(out_dir, 'pr-graph', id, '.png'), 'png');
close(gcf);

end

function s = get_line_style(i)
% Returns an unique style of a line. Provides 21 unique line styles.
%
% i     Number of the line

    colors = 'yrgbcmk';
    if(i <= length(colors))
        line ='-';
    elseif(i > length(colors) && i <= 2*length(colors))
        line ='--';
    elseif(i > 2*length(colors))
        line ='-.';
    end
    s = strcat(colors(mod(i, length(colors))+ 1), line);
end
