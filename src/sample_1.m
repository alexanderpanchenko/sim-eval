% A sample script which shows how to use evaluate_measure.m function
% This script evaluates one similarity measure located in a specific
% directory. The directory should contain five files --  bless-frame.csv,
% sn-frame.csv, rg-frame.csv, mc-frame.csv, wordsim-frame.csv. 
% Use the number of iterations (second parameter of the function evaluate_measure
% which takes values from 10 to 100) to improve precision of the evaluation. 

clc 

% Full path to the measure which is evaluated
MEASURE = strcat(norm_path(pwd),'/../measures/sample-with-output/');

% The default use of the evaluation script
tic
evaluate_measure(MEASURE); % the default value it_num=20 (~2.5 minutes). 
toc

tic
it_num = 10; % the fastest, but the less precise evaluation scores (~1.5 minutes)
evaluate_measure(MEASURE, it_num);
toc

tic
it_num = 100; % the longest, but the most precise evaluation scores (~11 min) 
evaluate_measure(MEASURE, it_num);
toc
