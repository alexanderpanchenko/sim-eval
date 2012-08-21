function [precision, recall, fmeasure, number, number_all] = get_pr(frame, results)
% Calculates precision, recall, fmeasure, and number of extracted relations.
% Output for precision, recall, and fmeasure is 6 dimensions vectors  
% [attri coord event hyper mero all]. Freq of extracted relations are
% given in the extracted_count variable. The precision and recall are
% calculated with respect to the frame, thus if it should contain all the
% pairs, not only the calculated ones.
%
% frame             Data frame [target relatum type score] 
% results           Results vector

types = {'attri', 'coord','event', 'hyper', 'mero','random'};

% Calculate numbers
number = zeros(1,6);
for i=1:length(types)
    number(i) = extracted(frame, results, types{i});
end
number_all = sum(number); %extracted_count = length(find(results==1));

% Calculate precisions 
precision = zeros(1, 6);
for i=1:(length(types)-1)
    precision(i) = number(i) / number_all;
end
precision(6) = (number_all - number(6)) / number_all;

% Calculate recalls 
recall = zeros(1, 6);
for i=1:(length(types)-1)
    recall(i) = number(i) / all(frame,types{i});
end
recall(6) = (number_all - number(6)) / (length(frame) - all(frame,'random'));

% Calculate F-measures
fmeasure = 2 * precision.*recall ./ (precision+recall);

end

function num = extracted(frame,results,type)
% Returns number of extracted relations of type X in the frame.
% frame     Data frame
% results   Results vector
% type      Relation type

num = length( find(results==1 & strcmp(frame(:,3),type) )) ;

end

function num = all(frame,type)
% Returns number of relations of type X in the frame
% frame     Data frame
% type      Relation type

num = length( find(strcmp(frame(:,3),type) )) ;

end


