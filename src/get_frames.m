
function [bless_file, sn_file, mc_file, rg_file, wordsim_file, ...
    bless2t_file, bless3t_file] = get_frames(work_dir)
% Check which evaluation frames are present in the directory.    
% If a frame is present then is path to is returned, otherwise the void
% string is returned. 

    % Names of frames
    BLESS_FRAME_CSV = 'bless-frame.csv';
    BLESS_FRAME_MAT = 'bless-frame.mat';
    SN_FRAME_CSV = 'sn-frame.csv';
    SN_FRAME_MAT = 'sn-frame.mat';
    MC_FRAME = 'mc-frame.csv';
    RG_FRAME = 'rg-frame.csv';
    WORDSIM_FRAME = 'wordsim-frame.csv';
    % Additional files
    BLESS_FRAME_2T = 'bless2t-frame.csv'; 
    BLESS_FRAME_3T = 'bless3t-frame.csv';
    
    % Initialization
    bless_file = '';
    sn_file = '';
    mc_file = '';
    rg_file = '';
    wordsim_file = '';
    bless2t_file = '';
    bless3t_file = '';
    
    % Check if the frames exist
    if(exist(strcat(work_dir, '/', BLESS_FRAME_CSV),'file'))
        bless_file = strcat(work_dir, '/', BLESS_FRAME_CSV);
    elseif (exist(strcat(work_dir, '/', BLESS_FRAME_MAT),'file'))
        bless_file = strcat(work_dir, '/', BLESS_FRAME_MAT);
    end
        
    if(exist(strcat(work_dir, '/', SN_FRAME_CSV),'file'))
        sn_file = strcat(work_dir, '/', SN_FRAME_CSV);
    elseif (exist(strcat(work_dir, '/', SN_FRAME_MAT),'file'))
        sn_file = strcat(work_dir, '/', SN_FRAME_MAT);
    end
    
    if(exist(strcat(work_dir, '/', MC_FRAME),'file'))
        mc_file = strcat(work_dir, '/', MC_FRAME);    
    end
    
    if(exist(strcat(work_dir, '/', RG_FRAME),'file'))
        rg_file = strcat(work_dir, '/', RG_FRAME);    
    end
    
    if(exist(strcat(work_dir, '/', WORDSIM_FRAME),'file'))
        wordsim_file = strcat(work_dir, '/', WORDSIM_FRAME);    
    end
    
    if(exist(strcat(work_dir, '/', BLESS_FRAME_2T),'file'))
        bless2t_file = strcat(work_dir, '/', BLESS_FRAME_2T);    
    end
    
    if(exist(strcat(work_dir, '/', BLESS_FRAME_3T),'file'))
        bless3t_file = strcat(work_dir, '/', BLESS_FRAME_3T);    
    end
end
