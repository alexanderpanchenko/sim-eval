function name = get_frame_name(frame_path)
% Get the name of the frame (dirname + filename)
%
% frame_path           Full path to the frame file

if(~exist(frame_path, 'file'))
    %fprintf('Error: frame %s does not exist\n', frame_path);
    name = frame_path;
    return 
end

[path, filename, foo] = fileparts(frame_path);
path_parts = strread(path, '%s', 'delimiter', '/');
dirname = path_parts{end};
name = strcat(dirname, '-', filename);

end
