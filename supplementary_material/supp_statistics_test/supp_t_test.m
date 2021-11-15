clear all
close all
clc

cur_pwd = pwd;

cd ..
cd ..

res = {'Not Rejected', 'Rejected'};
%% N = 2
load('analysed\N_2_Trans_A_Target_ii_settings.mat')

A_ii_amplitude = amplitude;

load('analysed\N_2_Trans_C_Target_ii_settings.mat')

C_ii_amplitude = amplitude;

[h,p] = ttest2(A_ii_amplitude,C_ii_amplitude);

disp(['N = 2, Amplitude performance of A:ii vs C:ii: the null hypothesis is ' res{h+1} ' with p-value = ' num2str(p, 3)]) 

load('analysed\N_2_Trans_A_Target_iii_settings.mat')

A_iii_amplitude = amplitude;
A_iii_phase = phase;
load('analysed\N_2_Trans_C_Target_iii_settings.mat')

C_iii_amplitude = amplitude;
C_iii_phase = phase;
[h,p] = ttest2(A_iii_amplitude,C_iii_amplitude);
disp(['N = 2, Amplitude performance of A:iii vs C:iii: the null hypothesis is ' res{h+1} ' with p-value = ' num2str(p, 3)]) 

[h,p]  = ttest2(A_iii_phase,C_iii_phase);
disp(['N = 2, Phase performance of A:iii vs C:iii: the null hypothesis is ' res{h+1} ' with p-value = ' num2str(p, 3)]) 

%% N = 4
res = {'Not Rejected', 'Rejected'};
load('analysed\N_4_Trans_A_Target_ii_settings.mat')

A_ii_amplitude = amplitude;

load('analysed\N_4_Trans_C_Target_ii_settings.mat')

C_ii_amplitude = amplitude;

[h,p] = ttest2(A_ii_amplitude,C_ii_amplitude);
disp(['N = 4, Amplitude performance of A:ii vs C:ii: the null hypothesis is ' res{h+1} ' with p-value = ' num2str(p, 3)]) 

load('analysed\N_4_Trans_A_Target_iii_settings.mat')

A_iii_amplitude = amplitude;
A_iii_phase = phase;
load('analysed\N_4_Trans_C_Target_iii_settings.mat')

C_iii_amplitude = amplitude;
C_iii_phase = phase;
[h,p] = ttest2(A_iii_amplitude,C_iii_amplitude);
disp(['N = 4, Amplitude performance of A:ii vs C:ii: the null hypothesis is ' res{h+1} ' with p-value = ' num2str(p, 3)]) 

[h,p]  = ttest2(A_iii_phase,C_iii_phase);
disp(['N = 4, Phase performance of A:ii vs C:ii: the null hypothesis is ' res{h+1} ' with p-value = ' num2str(p, 3)]) 

cd(cur_pwd)

boxplot([A_ii_amplitude; C_ii_amplitude]')
names = {'A:ii'; 'C:ii'};
set(gca,'xtick',[1:2],'xticklabel',names)
title('N = 4, Amplitude Performance')
ylabel('R_a [-]')
set(gca,'FontSize',24)
exportgraphics(gcf,'supp_n_4_boxplot.png')