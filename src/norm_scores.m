function  score = norm_scores(score, measure)
% Preprocess similarity scores calculated by an external similarity measure
%
% score         Vector of similarity scores to normalize (positive)
% measure       Measure of semantic similarity e.g. Wordnet::Similarity or MSR server.
% One of the following: path, hso, lch, lesk, lin, jcn, res, vector_pairs, wup, nss, pmi.
% Specify 'standard' if no special treatment is needed.

score = remove_bad_scores(score);
score(score < 0) = 0;

% Do some transformation specific to measure
switch measure     
    case {'res','path','lch','vector_pairs','hso','wup','lin','nss','pmi','standard'}  
        % No special transformation 
    case {'jcn'}        
        fprintf('Number of scores more than 3=%f\n', sum(score > 3));
        score(score > 3)
        score(score > 3) = 3;            
    case {'lesk'}
        fprintf('Number of scores more than 3=%f\n', sum(score > 1000));
        score(score > 1000)
        score(score > 1000) = 1000;                
    otherwise
        % No special transformation 
end

% Map to the [0;1] interval
%score = score - min(score); %score = score ./ max(score);
score = (score - min(score)) ./ (max(score) - min(score));
%sim_stat(score); %sim_stat(original_score);

if(strcmp(measure,'zscore'))
    score = (score - mean(score)) ./ std(score); % Transform to z score
    score = score - min(score); % Make z score positive
end

score = remove_bad_scores(score);

end

function score = remove_bad_scores(score)
% Removes "bad" score values
    score(isinf(score)) = 0;
    score(isnan(score)) = 0;    
end