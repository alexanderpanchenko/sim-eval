sim-eval: A tool for evaluation of semantic similarity measures
===============================================================

This repository contains data and scripts for evaluation of similarity measures. The script performs two kinds of evaluation: correlations with human judgements and semantic relation ranking. 

The evaluation procedure relies on two types of ground truth datasets: human judgments about semantic similarity and manually crafted semantic relations. This procedure reuses 4 common openly available datasets MC (Miller and Charles, 91), RG (Rubenstein and Goodenougth, 1965), WordSim353 (Finkelstein et al., 2001), BLESS (Baroni and Lenci, 2011). Rights on these data belong to their corresponding authors please consult the listed above references for terms of use of these data. 

Human Judgements Datasets
-------------------------

The first type of ground truth datasets is a set of tuples <c_i, c_j, s_ij>, where c_i, c_j are terms, and s_ij is their similarity obtained from by human judgment. The quality of a measure here is assessed with Pearson and Spearman's correlation between the similarity scores of humans and a measure. This evaluation directly assesses performance of the measure and indirectly assesses quality of relation extraction with the measure. We use three standard human judgments datasets MC (Miller and Charles, 91), RG (Rubenstein and Goodenougth, 1965) and WordSim353 (Finkelstein et al., 2001) composed of  30, 65, and 353 pairs of terms respectively.


Semantic Relations Datasets
-------------------------

The second type of ground truth are semantic relations $R$, such as <agitator, synonym, activist>, <dishwasher, cohyponym, reezer>, <hawk , hypernym, predator>, and <gun, synonym,weapon>. Each "target" term has roughly the same number of meaningful and random relations. This type of datasets indirectly assesses performance of a
measure, and directly assesses relation extraction with the measure.

This evaluation is based on the number of correctly retrieved relations with  Precision, Recall, Fmeasure, and Mean Average Precision (MAP). 

We use two semantic relation datasets: BLESS (Baroni and Lenci, 2001), and SN. The first relates 200 target terms (100 animate and 100 inanimate nouns) to 8625 relatum terms with 26554 semantic relations (14440 are meaningful and 12154 are random). Every relation has one of the following types:  hyponymy, cohyponym,  meronymy,  attribute,  event, or random. 

We built the SN (Semantic Neighbors) dataset in order to complement the BLESS, because the latter contains no synonyms. SN relates 462 target terms (nouns) to 5910 relatum terms with 14682 semantic relations (7341 are meaningful and 7341 are random).  The SN contains synonyms coming from three sources: WordNet (Miller, 1995), Roget's (Kennedy, 2004), and a synonyms database (http://synonyms-database.downloadaces.com/).


Organization of the directory
=============================

src
---

This directory contains sources of MATLAB scripts which perform evaluation of a similarity measure performance. The main function is evaluate_measure.m. Examples of use are provided in sample_1.m and sample_2.m files. Please consider that the scripts are not optimized. 

The script takes as input a path to the directory which should contain five files -- bless-frame.csv, sn-frame.csv, rg-frame.csv, mc-frame.csv, wordsim-frame.csv. Examples of these files can be found in the "results" directory. The results will be saved to the same directory. Some output with the scores will be also written to the standard output. 

The scripts were tested on MATLAB 2010a running on a 64-bit Windows Server 2008 R2 machine and MATLAB 2011b running on a 64-bit Ubuntu Linux 12.04. However, there should be no problem to run the scripts with other versions of MATLAB and on other platforms. To run an example, open in MATLAB sample_1.m or sample_2.m scripts run the script.


datasets
--------

sn.csv  	Semantic Neighbors (SN) dataset
bless.csv	BLESS dataset
mc.csv 		MC dataset
rg.csv 		RG dataset
wordsim.csv	WordSim353 dataset

measures
--------

This directory contains sample evaluation data of some similarity measures. 

Each subdirectory in this directory contains five files -- bless-frame.csv, sn-frame.csv, rg-frame.csv, mc-frame.csv, wordsim-frame.csv (some files have extension .mat they are binary files with the same content which can be opened in MATLAB). 

Each line of these CSV files have the following format:
"target-term;relatum-term;field-3;similarity-score"
For instance, line may look as follows: "acacia;willow;coord;0.30656".
Here "target-term" and "relatum-term" are words such as "acacia" or "willow", and "similarity-score" is similarity between target and relatum terms. The "field-3" contains similarity score between terms obtained by a human jugement for mc-frame.csv, rg-frame.csv, and wordsim-frame.csv file. For instance, "telephone;communication;7.50;0.48163". For the files bless-frame.csv and sn-frame.csv "frame-3" contains type of semantic relation between the target and relatum term. For instance, line may look like "ambulance;rescue;event;0.44537". Here "event" is type of relation. Type of relation must have one of the following values: attri, mero, coord, event, hyper, random.

In order to evaluate a new similarity measure you need to create a new directory and put files bless-frame.csv, sn-frame.csv, rg-frame.csv, mc-frame.csv, wordsim-frame.csv in it. Each of these files should contain scores which were generated by your measure. Then the evaluation can be started. The only thing which you need to input to *evaluate_measure.m* script is the path to the directory containing these CSV files. The output will be saved into the same directory. Some information will also be printed to the standard output. 

More measures can be downloaded from http://cental.fltr.ucl.ac.be/team/~panchenko/sim-eval/measures/measures.tgz. For details see http://cental.fltr.ucl.ac.be/team/~panchenko/sim-eval/.

Requirements
===========

- Matlab 2011 or higher. Normally, the scripts should work on the prior versions of Matlab, but I did test it.
- Statistics Toolbox (http://www.mathworks.nl/products/statistics/)

Quick Start 
===========
1. Open MATLAB
2. Change to directory "src"
3. Open "sample_1.m" or "sample_2.m" script
4. Run it. The evaluation scores will be printed to the standard output. Additional information will be saved in the directory with the measure scores (e.g. "measures/sample") 

Contact
=======

For any question concerining this evaluation script please write to Alexander Panchenko (alexander.panchenko@uclouvain.be). Center for Natural Language Processing (CENTAL), Université catholique de Louvain, Belgium.

Related Resources
================

* Comparison of the baseline similarity measures with these scripts: http://cental.fltr.ucl.ac.be/team/~panchenko/sim-eval/
* Semantic similarity measure "PatternSim": https://github.com/cental/patternsim
* A lexico-semantic search engine "Serelex" based on the "PatternSim" measure: http://serelex.cental.be/ 

References
==========

MILLER, G. A. et CHARLES, W. G. (1991). Contextual correlates of semantic similarity. Language
and Cognitive Processes, 6(1):1-28.

RUBENSTEIN, H. et GOODENOUGH, J. B. (1965). Contextual correlates of synonymy. Communications of the ACM, 8(10):627-633.

FINKELSTEIN, L., GABRILOVICH, E., MATIAS, Y., RIVLIN, E., SOLAN, Z., WOLFMAN, G. et RUPPIN, E.
(2001). Placing search in context : The concept revisited. In WWW 2001, pages 406-414. ACM

BARONI, M., BERNARDINI, S., FERRARESI, A. et ZANCHETTA, E. (2009). The wacky wide web : A
collection of very large linguistically processed web-crawled corpora. LREC, 43(3):209-226.

MILLER, G. A. (1995). Wordnet : a lexical database for english. Communications of ACM,
38(11):39-41

KENNEDY, A. et SZPAKOWICZ, S. (2008). Evaluating rogets thesauri. ACL-08 HLT, pages 416-424.





