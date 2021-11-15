Dataset for: "Target Acoustic Field and Transducer State Optimization using Diff-PAT".
Authors: Tatsuki Fushimi, Kenta Yamamoto, Yoichi Ochiai
Journal: AIP Advances.
Accepted: 15-Nov-2021
Correspondence Email: tfushimi@slis.tsukuba.ac.jp

This readme describes how to interpret the files contained within this folder.
This folder contains 4 subfolders, and 22 items. 
4 subholders are:
- results : Contains raw data as optimized by each optimizer
- analysed : Contains analysed data for the purpose of visual/key metric extractions.
- Fig_Files : Fig files for the manuscript
- supplementary_material: All data for supplementary material (incl. figures) are inside this subfolder.

22 items in the default directory are:
- Readme file (this file, README.txt)
- Main Python Optimization files (JAX_Diff_PAT_BoxPlot_Ver2.ipynb).
- MATLAB Files for analysis / figure generation (step1_results_analysis.m, step2_boxplot_plotter.m, step3_key_number_extraction.m, step4_noise_reduction_level.m, convergence_graph.m, directivity_fun.m)
- CSV Files for transducer position specfication (transducer_x.csv, transducer_y.csv, transducer_z.csv)
- CSV Files for target position specification (Target_X_N_2.csv, Target_X_N_4.csv, Target_Y_N_2.csv, Target_Y_N_4.csv, Target_Z_N_2.csv, Target_Z_N_4.csv)
- CSV Files for target amplitude specification for corresponding positions (Target_Amp_N_2.csv, Target_Amp_N_4.csv)
- CSV Files for target phase specficaition for corresponding positions (Target_Phase_N_2.csv, Target_Phase_N_4.csv)

The prequisite package for main python optimization packages are:
- JAX (This paper used version 0.2.17)
- Numpy
- Pandas

Easiest way to run these file is to upload the IPYNB and target CSV file to Google Colab. 

Prequisite toolbox for MATLAB files are: 
Statistics and Machine Learning Toolbox

1. CSV File structure

File Name: Target_Amp_N_<num_points>.csv
Structure of *.csv files:

Target1 Amplitude[Pa], ...
.
.
.
TargetN Amplitude[Pa], ...


File Name: Target_Phase_N_<num_points>.csv
Structure of *.csv files:

Target1 Phase[rad], ...
.
.
.
TargetN Phase[rad], ...

File Name: Target_X_N_<num_points>.csv
Structure of *.csv files:

Target1 X [m], ...
.
.
.
TargetN X [m], ...

File Name: Target_Y_N_<num_points>.csv
Structure of *.csv files:

Target1 Y [m], ...
.
.
.
TargetN Y [m], ...

File Name: Target_Z_N_<num_points>.csv
Structure of *.csv files:

Target1 Z [m], ...
.
.
.
TargetN Z [m], ...

File Name: transducer_x.csv
Structure of *.csv files:

Transducer Position in X [m]
.
.
.


File Name: transducer_y.csv
Structure of *.csv files:

Transducer Position in Y [m]
.
.
.


File Name: transducer_z.csv
Structure of *.csv files:

Transducer Position in Z [m]
.
.
.


------------------------------------------------------
For CSV files in [results]: This folder contains optimized results for each optimizers. 

File Name: Amplitude_exports_N_<num_points>_Trans_<Transducer Settings>_Target_<Target Point Settings>_settings.csv
Structure of *.csv files:

1st Sample 0th Transducer Normalized Amplitude [-], ... 1st Sample Tth Transducer Normalized Amplitude [-]
.
. 
.

1000th Sample 0th Transducer Normalized Amplitude [-], ... 1000th Sample Tth Transducer Normalized Amplitude [-]


File Name: Phase_exports_N_<num_points>_Trans_<Transducer Settings>_Target_<Target Point Settings>_settings.csv
Structure of *.csv files:

1st Sample 0th Transducer Phase [rad], ... 1st Sample Tth Transducer Phase [rad]
.
. 
.

1000th Sample 0th Transducer Phase [rad], ... 1000th Sample Tth Transducer Phase [rad]



File Name: Amplitude_exports_N_<num_points>_Trans_<Transducer Settings>_Target_<Target Point Settings>_settings.csv
Structure of *.csv files:

1st Sample 0th Step Loss Value [-], ... 1st Sample 1000th Step Loss value [-]
.
. 
.

1000th Sample 0th Step Loss Value [-], ... 1000th Sample 1000th Step Loss Value [-]

