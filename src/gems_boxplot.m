function gems_boxplot(frame_path, out_dir, plot_anova)
% Perfroms an evaluation with a boxplot as suggested in the GEMS2011.
% The boxplot represents distribution of similarity scores among the
% different types of semantic relations. The function also generates the
% second boxplot, which represents distribution of similarity scores among
% two types of relations: random and not random (all meaningful types).
%
% frame_path       A cell array of paths to a .mat file with FRAME (dataframe [target relatum type similarity])
% out_dir          Output directory

types = {'hyper','coord','attri','mero','event','random'};
types_bin = {'relation','random'};

% Calculate scores
[zscores, foo1, zscores_bin, scores_bin] = calc_scores(frame_path, types);
name = get_frame_name(frame_path);

% Boxplot -- all relation types
h = figure('Visible','off');
boxplot(zscores,'labels',types);
xlabel('Type of semantic relation');
ylabel('Similarity score between target concept and its 1NN (z-score)');
title(name);
saveas(gcf, strcat(out_dir, 'boxplot-', name, '.fig'), 'fig');
saveas(gcf, strcat(out_dir, 'boxplot-', name, '.png'), 'png');
close(gcf); 

% Boxplot -- binary relations
h = figure('Visible','off');
figure('Visible','off');
boxplot(scores_bin,'labels',types_bin);
xlabel('Type of semantic relation');
ylabel('Similarity score target concept and its 1NN (z-score)');
title(name);
saveas(gcf, strcat(out_dir, 'boxplot-bin-', name, '.fig'), 'fig');
saveas(gcf, strcat(out_dir, 'boxplot-bin-', name, '.png'), 'png');
close(gcf);
    
% Statistical difference
if(plot_anova)
    [p,table,stats] = anova1(zscores,types,'off');    
    figure('Visible','off');
    [c,m,h,gnames] = multcompare(stats,'alpha',0.01);
    saveas(gcf, strcat(out_dir, 'multcompare-', name, '.fig'), 'fig');
    saveas(gcf, strcat(out_dir, 'multcompare-', name, '.png'), 'png');
    close(gcf);
end

end

function [zscores, scores, zscores_bin, scores_bin] = calc_scores(framepath, types)
% Calculates scores and z-scores required for the evaluation
% Returns a matrix [N X 6] where N is number of target concepts. For each
% target a 6-dimensional vector is returned, containing scores for a
% corresponging type of relations.
%
% framepath       Path to a .mat or .csv file with BLESS frame [target relatum type similarity]
% types           A vector with types of relations

% Load the frame from the file
f = load_bless_frame(framepath); 

% Load frame
FRAME_B = sortrows(f,[1 3 -4]);

% Get the list of targets
targets = unique(FRAME_B(:,1));

% Initialization
results = zeros(length(FRAME_B),1);
scores = zeros(length(targets), length(types));
previous = '';

% Calculate the scores (1-NN per relation type)
for i=1:length(FRAME_B)
    current = strcat(FRAME_B(i,1),FRAME_B(i,3));
    if(~strcmp(current,previous))
        results(i) = 1;
        j = strcmp(types,FRAME_B(i,3));
        t = strcmp(targets,FRAME_B(i,1));
        scores(t,j) = cell2mat(FRAME_B(i,4));
    end

    previous = current;
end

% Modify scores: shift on k
%for i =1:length(types)
%    onenn_index = find(strcmp(TOTAL_B(:,3),types(i)) & (results == 1));
%    scores(:,i) = cell2mat(TOTAL_B(onenn_index + k, 4));
%end

% Calculate z-scores: s = (s-mean)/std.
scores_mean = repmat(mean(scores,2), 1, length(types));
scores_std = repmat(std(scores,0,2), 1, length(types));
zscores = (scores - scores_mean) ./ scores_std;

% Calculate binary scores and z-scores (random / not random)
scores_bin = [max(scores(:,1:5),[],2) scores(:,6)];
scores_bin_mean = repmat(mean(scores_bin,2), 1, 2);
scores_bin_std = repmat(std(scores_bin,0,2), 1, 2);
zscores_bin = (scores_bin - scores_bin_mean) ./ scores_bin_std;

end
