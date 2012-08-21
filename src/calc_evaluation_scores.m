function R = calc_evaluation_scores(FRAME, name, it_num, gamma)
% Calculates a structure containig precision, recall, fmeasure, number of
% extracted relations, and tabulation scores for a given dataframe. The
% calculation of scores is done with the TOPP thresholding method.
%
% FRAME             Data frame
% name              Name of the semantic measure contained in the FRAME
% it_num            Number of measurements (the more, the more precise plot will be generated)
% gamma         Minimum value of score (gamma)

% Initialization
FRAME(strcmp(FRAME(:,3),'?'),:) = []; % Removing unlabeled data
REL_TYPES_COUNT = 6;
precision = zeros(REL_TYPES_COUNT, it_num);
recall = zeros(REL_TYPES_COUNT, it_num);
fmeasure = zeros(REL_TYPES_COUNT, it_num);
number = zeros(REL_TYPES_COUNT, it_num);
t = zeros(it_num, 1);

% Calculate delta
p_min = 0; % min percent
p_max = 1; % max percent
delta = (p_max - p_min)/it_num;

% Run it_num tests with different threshold values (use TOPP KNN threshold)
for i=1:it_num
    p = delta*(i-1);    
    [results, FRAME] = topp_threshold(FRAME, p, gamma);     
    [precision(:,i), recall(:,i), fmeasure(:,i), foo1, number(i)] = get_pr(FRAME, results); %number(:,i),
    t(i) = p;    
end

% Save results in a structure
R.name = name;
R.precision = precision;
R.recall = recall;
R.fmeasure = fmeasure;
R.number = number;
R.t = t;
R.types = {'attri', 'coord', 'event', 'hyper', 'mero', 'all'};

end
