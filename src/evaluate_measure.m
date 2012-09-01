function evaluate_measure(work_dir, it_num, plots, gamma)
% Evaluates a single measure those data are in the working_dir: 
% bless-frame.(mat|csv) -- BLESS dataset; a file with similarity scores "target;relatum;type;sim"
% sn-frame.(mat|csv) -- SN dataset; a file with similarity scores target;relatum;type;sim"
% rg-frame.csv -- RG dataset; a file with "word1;word2;golden-sim;sim"
% mc-frame.csv -- MC dataset; a file with "word1;word2;golden-sim;sim"
% wordsim-frame.csv -- WordSim353 dataset; a file with "word1;word2;golden-sim;sim"
%
% The results of the evaluation are either printed to the standard output or saved in the work_dir

scores = strcat(work_dir,'/scores.txt');
if exist(scores, 'file')
    delete(scores);
end
diary(scores);

% Parameters
MC_EVAL = 1;
RG_EVAL = 1;
WORDSIM_EVAL = 1;
BLESS_EVAL = 1;
SN_EVAL = 1;
BLESS2T_EVAL = 1;
BLESS3T_EVAL = 1;

% Set default parameters
if(nargin > 4)
    error('Function requires at most 3 optional inputs');
elseif(nargin == 1)
    it_num = 20;
    plots = 0;
    gamma = 0;
elseif( nargin == 2)
    plots = 0;
    gamma = 0;
elseif( nargin == 3)
    gamma = 0;
end

work_dir = norm_path(work_dir);
% Make sure the working directory exist
if(exist(work_dir,'dir'))
    try
    % Get the paths to the frame files
    [bless_file, sn_file, mc_file, rg_file, wordsim_file, bless2t_file,...
        bless3t_file] = get_frames(work_dir);
  
    % Ensure that all frames are found in the working directory
    if(strcmp(strcat(bless_file, sn_file, mc_file, rg_file, wordsim_file),''))
        fprintf('Error: no frames were found in the directory %s.\n', work_dir);
        return
    elseif (strcmp(bless_file,'') || strcmp(sn_file,'') || strcmp(mc_file,'') || strcmp(rg_file,'') || strcmp(wordsim_file,''))
        fprintf('Error: some frames were found in the directory %s.\n', work_dir);
    end
    
    % Name of the measure = name of the directory
    path = regexprep(work_dir, '/$', '');
    [~, measure_name, ~] = fileparts(path);
    print_spacer(); print_spacer(); print_spacer();
    fprintf('%s (%s)\n\n', measure_name, work_dir);
    
    % Start evaluation on all found evaluation frames
    if(~strcmp(mc_file,'') && MC_EVAL)
         run_correlation_eval(mc_file);
    end
    
    if(~strcmp(rg_file,'') && RG_EVAL)
        run_correlation_eval(rg_file);            
    end
        
    if(~strcmp(wordsim_file,'') && WORDSIM_EVAL)
        run_correlation_eval(wordsim_file);    
    end
    
    if(~strcmp(bless_file,'') && BLESS_EVAL)
        run_bless_eval(bless_file, work_dir, it_num, gamma, plots)
    end
            
    if(~strcmp(sn_file,'') && SN_EVAL)
        run_bless_eval(sn_file, work_dir, it_num, gamma, plots)
    end
    
    if(~strcmp(bless2t_file,'') && BLESS2T_EVAL)
        run_bless_eval(bless2t_file, work_dir, it_num, gamma, plots);        
    end    
    
    if(~strcmp(bless3t_file,'') && BLESS3T_EVAL)
        run_bless_eval(bless3t_file, work_dir, it_num, gamma, plots);
    end    
    
    catch exception
        fprintf('Evaluation of the measure %s failed: %s\n',...
            work_dir, exception.message);
    end
else
    fprintf('Directory %s not found. \nThe directory should contain files bless-frame.csv, sn-frame.csv, rg-frame.csv, mc-frame.csv, wordsim-frame.csv\n', work_dir);
end

diary off

end

function print_whiteline()
    fprintf('\n')
end

function run_correlation_eval(frame_file)
    print_spacer();
    fprintf('%s\n', frame_file);
    correlation_evaluation(frame_file);    
    print_whiteline();
end

function run_bless_eval(frame_file, work_dir, it_num, gamma, plots)
    print_spacer();
    fprintf('%s\n', frame_file);
    if(plots)
        bless_evaluation({frame_file}, work_dir, it_num, gamma);
    end
    [p10, p20, p50, f50, k_p80, r_p80, f_p80, map20, map50, r50, n10, n20, n50] =...
        get_bless_scores(frame_file, it_num, gamma);
    print_bless_scores(p10, p20, p50, f50, k_p80, r_p80, f_p80, map20, map50, r50, n10, n20, n50);
    print_whiteline();
end
