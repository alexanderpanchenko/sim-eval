function map = get_map(M, precision)
% Calculates Mean Average Precision for a given vector of Precision values
% (each value of the vector -- precision at certain level of the threshold)
% We assume that precision(1) = precision at k=1%, and precision(end) =
% precision at k = 100%
%
% precision        Vector of precisions from 0 to 100 kNN threshold
% M                Value from 0 to 100
%
% map              Mean Average Precision at the range of kNN threshold [1;M]

% Check input parameters
if(M > 100 || M < 0) 
    fprintf('Wrong value of M\n')    
    return
end

% Number of points for input M
points_num = round( (M/100)*length(precision) );

% Calculate MAP
map = sum(precision(1:points_num)) / points_num;

end