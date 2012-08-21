function FRAME = set_mode(FRAME, mode)
% Changes the tags in the input frame according to the mode
%   FRAME       Dataframe to update.
%   mode        Type of semantic relations, one of the following:
%   "binary", "random", "random-nvj", "randon-nvj?".

if(strcmp(mode,'binary'))
    %types = {'relation';'random'};
    FRAME = replace(FRAME, 'attri', 'relation');
    FRAME = replace(FRAME, 'coord', 'relation');
    FRAME = replace(FRAME, 'event', 'relation');
    FRAME = replace(FRAME, 'coord', 'relation');
    FRAME = replace(FRAME, 'hyper', 'relation');
    FRAME = replace(FRAME, 'mero', 'relation');
    FRAME = replace(FRAME, 'random-n', 'random');
    FRAME = replace(FRAME, 'random-v', 'random');
    FRAME = replace(FRAME, 'random-j', 'random');
    FRAME = replace(FRAME, '?', 'random');
    
elseif(strcmp(mode,'random'))
    %types = {'attri';'coord';'event';'hyper';'mero';'random'};
    FRAME = replace(FRAME, 'random-n', 'random');
    FRAME = replace(FRAME, 'random-v', 'random');
    FRAME = replace(FRAME, 'random-j', 'random');
    FRAME = replace(FRAME, '?', 'random');
    
elseif(strcmp(mode,'random-nvj'))
    %types = {'attri';'coord';'event';'hyper';'mero';'random-n';'random-v';'random-j'};
    FRAME = replace(FRAME, '?', 'random');
    
elseif(strcmp(mode,'random-nvj?') || strcmp(mode,'random-nvj'))
    %types = {'attri';'coord';'event';'hyper';'mero';'random-n';'random-v';'random-j';'?'};
    %types = {'attri';'coord';'event';'hyper';'mero';'random-n';'random-v';'random-j'};
    % Change nothing  
else     
    % Change nothing  
end

end


function FRAME = replace (FRAME, type, newtype)
% Replaces in a FRAME labels from type TYPE to NEWTYPE

index = find(strcmp(FRAME(:,3),type));
for i=1:length(index)
    FRAME{index(i),3} = newtype;
end

end


