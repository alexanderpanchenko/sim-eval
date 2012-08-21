function  [frame, frame_name, score] = load_bless_frame(input_file)
% Loading a BLESS frame [word1 word2 type sim] from a input_file which is
% either a binary .mat file or a "word1;word2;type;sim" CVS file.
%
% frame         BLESS frame "target;relatum;type;sim"
% frame_name    Name of the frame file without extension

% Get frame name and file extension
[foo1, foo2, ext] = fileparts(input_file);
frame_name = get_frame_name(input_file);

if(strcmp(ext, '.mat'))
    % Loading from the binary file
    f = load(input_file); 
    frame = f.FRAME;
elseif (strcmp(ext, '.csv'))
    % Loading from the text file
    [ct, cr, type, score] = textread(input_file, '%s%s%s%f','delimiter',';');

    % Compose the frame from these data
    frame = [ct cr type num2cell(score)];
    frame = sortrows(frame, [1 -4]);
    score =  cell2mat(frame(:,4));
end

end
