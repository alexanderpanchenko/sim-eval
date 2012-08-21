function [p10, p20, p50, f50, k_p80, r_p80, f_p80, map20, map50, r50, n10, n20, n50] = calc_bless_scores(frame, filename, it_num, gamma)
% Calculates the five scores required to the EACL evaluation from a binary 
% with bless frame file frame*.mat [target relatum type score]
% p10 - Precision@k10, p20 - Precision@k20, p50 - Precision@k50, f50 - Fmeasure@k50,
% k_p80 - k@Precision=0.80, r_p80 - Recall@Precision=0.80, f_p80 - Fmeasure@Precision=0.80
% MAP(20), MAP(50) -- Mean Average Precision

% Set the default values
if (nargin < 3)
    fprintf('Iteration number was not provided! Using it_num=50, gamma=0 by default.\n');
    it_num = 50;
    gamma = 0;
end

% Calculate scores
R = calc_evaluation_scores(frame, filename, it_num, gamma);
syn_index = find(strcmp(R.types,'all'));

% k = 10%
index_k10 = find(R.t == 0.1);
p10 = R.precision(syn_index, index_k10);
n10 = R.number(index_k10);

% k = 20% 
index_k20 = find(R.t == 0.2);
p20 = R.precision(syn_index, index_k20);
n20 = R.number(index_k20);

% k = 50%
index_k50 = find(R.t == 0.5);
p50 = R.precision(syn_index, index_k50);
r50 = R.recall(syn_index, index_k50);
f50 = R.fmeasure(syn_index, index_k50);
n50 = R.number(index_k50);

% Find index of Precision=0.8 (approximate)
delta = abs(R.precision(syn_index,:) - 0.8);
index_p80 = find(min(delta)==delta);

% Get k@Precision=0.80, Recall@Precision=0.80, Fmeasure@Precision=0.80 (approximate)
k_p80 = R.t(index_p80);
r_p80 = R.recall(syn_index, index_p80);
f_p80 = R.fmeasure(syn_index, index_p80);

% Calculate MAP(20) and MAP(50)
map20 = get_map(20, R.precision(syn_index, :));
map50 = get_map(50, R.precision(syn_index, :));

end
