clear all
close all
clc
%%
% Manuscript: "Target Acoustic Field and Transducer State Optimization using Diff-PAT"
% Authors: Tatsuki Fushimi*, Kenta Yamamoto*, Yoichi Ochiai
% Corresponding email: tfushimi@slis.tsukuba.ac.jp

% This program calculates and extracts the statistic information presented
% in the manuscript. 

tras_side = {'A','B','C'};
target_side = {'i','ii','iii'};
N_list = [2,4];
for nn = 1:2
    for ii = 1:3
        for jj = 1:3
            load(['analysed\N_' num2str(N_list(nn))  '_Trans_' tras_side{jj} '_Target_' target_side{ii} '_settings.mat'], 'amplitude', 'phase');
            eval(['N' num2str(N_list(nn)) '_' tras_side{jj} '_' target_side{ii} '_amp=amplitude;']);
            eval(['N' num2str(N_list(nn)) '_' tras_side{jj} '_' target_side{ii} '_pha=phase;']);
        end
    end
end
%% Question 1
disp('Question 1 Average phase accuracy in i')
disp(['N=2 A:i = ' num2str(round(mean(N2_A_i_pha),3,'significant'))])
disp(['N=2 B:i = ' num2str(round(mean(N2_B_i_pha),3,'significant'))])
disp(['N=2 C:i = ' num2str(round(mean(N2_C_i_pha),3,'significant'))])
disp(['N=4 A:i = ' num2str(round(mean(N4_A_i_pha),3,'significant'))])
disp(['N=4 B:i = ' num2str(round(mean(N4_B_i_pha),3,'significant'))])
disp(['N=4 C:i = ' num2str(round(mean(N4_C_i_pha),3,'significant'))])
disp('---------------------------------------------')

disp('Question 2 Average amplitude accuracy in ii')
disp(['N=2 A:ii = ' num2str(round(mean(N2_A_ii_amp),3,'significant'))])
disp(['N=2 B:ii = ' num2str(round(mean(N2_B_ii_amp),3,'significant'))])
disp(['N=2 C:ii = ' num2str(round(mean(N2_C_ii_amp),3,'significant'))])
disp(['N=4 A:ii = ' num2str(round(mean(N4_A_ii_amp),3,'significant'))])
disp(['N=4 B:ii = ' num2str(round(mean(N4_B_ii_amp),3,'significant'))])
disp(['N=4 C:ii = ' num2str(round(mean(N4_C_ii_amp),3,'significant'))])
disp('---------------------------------------------')

disp('Question 3 Percentage of transducer amplitudes below 10% in B:ii')
T= table2array(readtable('results\Amplitude_exports_N_2_Trans_B_Target_ii_settings.csv'));
percentage = mean(sum((T<0.01), 2)./(256));
disp(['N = 2 Mean Transducer Off: ' num2str(percentage)])
T= table2array(readtable('results\Amplitude_exports_N_4_Trans_B_Target_ii_settings.csv'));
percentage = mean(sum((T<0.01), 2)./(256));
disp(['N = 4 Mean Transducer Off: ' num2str(percentage)])
disp('---------------------------------------------')

disp('Question 4 Average amplitude accuracy in iii')
disp(['N=2 A:iii = ' num2str(round(mean(N2_A_iii_amp),3,'significant'))])
disp(['N=2 B:iii = ' num2str(round(mean(N2_B_iii_amp),3,'significant'))])
disp(['N=2 C:iii = ' num2str(round(mean(N2_C_iii_amp),3,'significant'))])
disp(['N=4 A:iii = ' num2str(round(mean(N4_A_iii_amp),3,'significant'))])
disp(['N=4 B:iii = ' num2str(round(mean(N4_B_iii_amp),3,'significant'))])
disp(['N=4 C:iii = ' num2str(round(mean(N4_C_iii_amp),3,'significant'))])
disp('---------------------------------------------')

disp('Question 5 Average phase accuracy in iii')
disp(['N=2 A:iii = ' num2str(round(mean(N2_A_iii_pha),3,'significant'))])
disp(['N=2 B:iii = ' num2str(round(mean(N2_B_iii_pha),3,'significant'))])
disp(['N=2 C:iii = ' num2str(round(mean(N2_C_iii_pha),3,'significant'))])
disp(['N=4 A:iii = ' num2str(round(mean(N4_A_iii_pha),3,'significant'))])
disp(['N=4 B:iii = ' num2str(round(mean(N4_B_iii_pha),3,'significant'))])
disp(['N=4 C:iii = ' num2str(round(mean(N4_C_iii_pha),3,'significant'))])
disp('---------------------------------------------')




