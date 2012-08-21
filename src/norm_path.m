function normalized_path = norm_path(path)
% This function normalizes paths. It converts all occurences of '/' to '\'
% since in MATLAB the latter is a valid separator for all platforms. 

normalized_path = regexprep(path, '\', '/');

end

