function [results, frame] = topp_threshold(frame, p, gamma)
% Calculates relations with TOPP KNN 
%
% frame		Data frame [target relatum type sim]
% p      	KNN threshold -- percents of NN which will be kept (from zero to one).
% gamma    	Minimal score    

% Check input data
if(p > 1 || p < 0) 
    disp('Enter p between one and zero.');
    return;
end

% Sort dataframe by target and score 
frame = sortrows(frame, [1 -4 2]); % 2 is really necessary so pairs with zero sim have random order
scores = cell2mat(frame(:,4));

% Calculate relations with KNN threshold
previous_target = '';
results = zeros(length(frame),1);

for i=1:length(frame)
    current_target = frame(i,1);
    if(~strcmp(current_target,previous_target))
	% The first NN is always related
        results(i) = 1;
        current_target_len = length(frame(strcmp(frame(:,1),current_target))); % Number of relations of the target
        n = round(p*current_target_len) - 1;
    else
	% Only n-1 rest first NN are related
        %results(i) = ((n > 0) && (scores(i) >= gamma)); % if gamma = 0 then a relation established even between pairs with zero...
        results(i) = ((n > 0) && (scores(i) > gamma));
        n = n - 1;
    end
    previous_target = current_target;
end

end
