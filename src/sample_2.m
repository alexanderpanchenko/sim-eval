% A sample script which shows how to use evaluate_measure.m function
% This script evaluates 35 measures at the same in a loop.
% The script additionally saves standard output to a log file.

% Names of subdirectories in the results directory with measures data
% Each name corresponds to one directory
MEASURES = {...
'random',... % A random similarity measure
'wordnet-lesk',... % Extended Lesk similarity measure
'wordnet-jcn',... % Jiang-Conrath similarity measure
'def-wiktionary',... % Wiktionary gloss overlap similarity measure
'corpus-context-window',... % Context Window distributional similarity measure
'corpus-syn-context',... % Syntactic Contexts distributional similarity measure
};

% Get full paths to the directories with the measures
MEASURES = strcat(ROOT, 'measures/', MEASURES, '/');

% Evaluate measures 
for i=1:length(MEASURES)
    evaluate_measure(MEASURES{i},10);
end