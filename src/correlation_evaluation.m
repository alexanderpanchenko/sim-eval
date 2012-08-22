function [pearson, spearman] = correlation_evaluation(corr_file)
% Evaluates a similarity measure by computing correlaiton of semantic
% similarity scores of some measure to the golden standard similarity
% scores obtained by a human e.g. by MC, RG, or WordSim353
%
% corr_file     Path to a correlation frame -- a CSV file "word1;word2;gold-sim;sim"
%
% pearson       Pearson correlation coefficient between human judgements and similarity
% spearman      Spearam correlation coefficient between human judgements and similarity

% Check if the input file exist
if(~exist(corr_file,'file'))
    fprintf('The input file %s not found!\n', corr_file);
    return
end

% Reading the data from corr_file
[foo1, foo2, golden_sim, sim] = textread(corr_file, '%s%s%f%f','delimiter',';');

% Normalize similarity scores
golden_sim = norm_scores(golden_sim,'');
sim = norm_scores(sim,'');

% Calculating Pearson and Spearman correlation coefficients
[pearson, pvalue] = corr(golden_sim, sim, 'type', 'Pearson');
fprintf('Pearson correlation = %f (pvalue=%f)\n', pearson, pvalue);

[spearman, pvalue] = corr(golden_sim, sim, 'type', 'Spearman');
fprintf('Spearman correlation = %f (pvalue=%f)\n', spearman, pvalue);

end
