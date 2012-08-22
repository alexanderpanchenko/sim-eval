% A sample script which shows how to use evaluate_measure.m function
% This script evaluates one similarity measure located in a specific
% directory. The directory should contain five files --  bless-frame.csv,
% sn-frame.csv, rg-frame.csv, mc-frame.csv, wordsim-frame.csv. 
% Use the number of iterations (second parameter of the function evaluate_measure
% which takes values from 10 to 100) to improve precision of the evaluation. 

clc 

% Full path to the measure which is evaluated
MEASURE = strcat(norm_path(pwd),'/../measures/sample/');

% The default use of the evaluation script (it_num=20, no plots)
tic
evaluate_measure(MEASURE);
toc

% Long, but the most precise evaluation scores 
tic
it_num = 100; 
evaluate_measure(MEASURE, it_num);
toc

% Output additional plots 
tic
it_num = 20; 
plots=1;
evaluate_measure(MEASURE, it_num, plots);
toc