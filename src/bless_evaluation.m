function bless_evaluation(frames, output_dir, it_num, gamma)
% Performs evaluation of a set of frames in the BLESS format "word1;word2;type;score"
% The  results of the evaluation will be saved into output_dir
% 
% frames        A cell array with paths to BLESS frames
% output_dir    The output directory 
% it_num        Number of iterations (granularity of the evaluation)
% gamma         Minimum value of the similarity considered

PR_K = 1;
BOXPLOT = 1;
PR_GRAPH = 1;
ANOVA = 0;

% Ensure that output directory exists
if (exist(output_dir,'dir') <= 0)
    mkdir(output_dir);
end

for i=1:length(frames)
    fprintf('%s\n',frames{i})
    
    % Precision-k curves (per relation and cumulative)
    if(PR_K)
        frame = load_bless_frame(frames{i});
        frame_name = get_frame_name(frames{i});
        pr_eval(frame, output_dir, it_num, frame_name, gamma);
    end

    % Vizualize sim.distribution across relation types with boxplots
    % and check significance in distributions with ANOVA
    if(BOXPLOT)
        gems_boxplot(frames{i}, output_dir, ANOVA);
    end
end

% Precision-Recall curve 
if(PR_GRAPH)
    if(length(frames) > 1)
        pr_graph(frames, output_dir, it_num, gamma);
    else if(length(frames) == 1)
        pr_graph(frames, output_dir, it_num, gamma, ....
            strcat('-',get_frame_name(frames{1})));
    end
end

end