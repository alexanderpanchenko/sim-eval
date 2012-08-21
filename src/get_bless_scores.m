function [p10, p20, p50, f50, k_p80, r_p80, f_p80, map20, map50, r50, n10, n20, n50] = get_bless_scores(frame_file, it_num, gamma)
% Returns the five scores required to the EACL evaluation from a binary 
% with bless frame file FRAME*.mat [target relatum type score]
% p10 - Precision@k10, p20 - Precision@k20, p50 - Precision@k50, f50 - Fmeasure@k50,
% k_p80 - k@Precision=0.80, r_p80 - Recall@Precision=0.80, f_p80 - Fmeasure@Precision=0.80
% MAP(20), MAP(50) -- Mean Average Precision
%
% frame_file        bless frame file FRAME*.mat [target relatum type score] or a CSV frame

% A test example
%frame_file = 'D:\work\syn-with-stopwords\exact5\1000000000\FRAME-cos-kbeta10000.mat';

% Load the frame
if(~exist(frame_file,'file'))
    p10 = 0; p20 = 0; p50 = 0; f50 = 0; k_p80 = 0; r_p80 = 0; f_p80 = 0;
    map20 = 0; map50 = 0; r50 = 0;
    return
end

[frame, filename] = load_bless_frame(frame_file);
[p10, p20, p50, f50, k_p80, r_p80, f_p80, map20, map50, r50, n10, n20, n50] =...
    calc_bless_scores(frame, filename, it_num, gamma);

end