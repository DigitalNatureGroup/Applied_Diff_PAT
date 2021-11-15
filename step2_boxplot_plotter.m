clear all
close all
clc

%%
% Manuscript: "Target Acoustic Field and Transducer State Optimization using Diff-PAT"
% Authors: Tatsuki Fushimi*, Kenta Yamamoto*, Yoichi Ochiai
% Corresponding email: tfushimi@slis.tsukuba.ac.jp

% This program generates figure 2 in the manuscript from the dataset.

%% Load Data
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
return

%% Plot graphs, export as PDF
figure
clf
m = boxplot([N2_A_i_amp', N2_B_i_amp', N2_C_i_amp'], 'Whisker',1.5,'Symbol','ko');
ylim([0 1.5])
set(gca,'FontSize',30)
ylabel('R_a [-]')
axis square
set(gca,'LineWidth',2)
set(m,'LineWidth',2)
return
% exportgraphics(gcf,'analysed\N2_i_amp.pdf', 'ContentType', 'vector');

clf
m = boxplot([N2_A_ii_amp', N2_B_ii_amp', N2_C_ii_amp'], 'Whisker',1.5,'Symbol','ko');
ylim([0 1.5])
set(gca,'FontSize',30)
ylabel('R_a [-]')
axis square
set(gca,'LineWidth',2)
set(m,'LineWidth',2)
exportgraphics(gcf,'analysed\N2_ii_amp.pdf', 'ContentType', 'vector');

clf
m = boxplot([N2_A_iii_amp', N2_B_iii_amp', N2_C_iii_amp'], 'Whisker',1.5,'Symbol','ko');
ylim([0 1.5])
set(gca,'FontSize',30)
ylabel('R_a [-]')
axis square
set(gca,'LineWidth',2)
set(m,'LineWidth',2)
exportgraphics(gcf,'analysed\N2_iii_amp.pdf', 'ContentType', 'vector');

clf
m = boxplot([N2_A_i_pha', N2_B_i_pha', N2_C_i_pha'], 'Whisker',1.5,'Symbol','ko');
ylim([0 0.5])
set(gca,'FontSize',30)
ylabel('R_p [-]')
axis square
set(gca,'LineWidth',2)
set(m,'LineWidth',2)
exportgraphics(gcf,'analysed\N2_i_pha.pdf', 'ContentType', 'vector');

clf
m = boxplot([N2_A_ii_pha', N2_B_ii_pha', N2_C_ii_pha'], 'Whisker',1.5,'Symbol','ko');
ylim([0 0.5])
set(gca,'FontSize',30)
ylabel('R_p [-]')
axis square
set(gca,'LineWidth',2)
set(m,'LineWidth',2)
exportgraphics(gcf,'analysed\N2_ii_pha.pdf', 'ContentType', 'vector');

clf
m = boxplot([N2_A_iii_pha', N2_B_iii_pha', N2_C_iii_pha'], 'Whisker',1.5,'Symbol','ko');
ylim([0 0.5])
set(gca,'FontSize',30)
ylabel('R_p [-]')
axis square
set(gca,'LineWidth',2)
set(m,'LineWidth',2)
exportgraphics(gcf,'analysed\N2_iii_pha.pdf', 'ContentType', 'vector');

clf
m = boxplot([N4_A_i_amp', N4_B_i_amp', N4_C_i_amp'], 'Whisker',1.5,'Symbol','ko');
ylim([0 1.5])
set(gca,'FontSize',30)
ylabel('R_a [-]')
axis square
set(gca,'LineWidth',2)
set(m,'LineWidth',2)
exportgraphics(gcf,'analysed\N4_i_amp.pdf', 'ContentType', 'vector');

clf
m = boxplot([N4_A_ii_amp', N4_B_ii_amp', N4_C_ii_amp'], 'Whisker',1.5,'Symbol','ko');
ylim([0 1.5])
set(gca,'FontSize',30)
ylabel('R_a [-]')
axis square
set(gca,'LineWidth',2)
set(m,'LineWidth',2)
exportgraphics(gcf,'analysed\N4_ii_amp.pdf', 'ContentType', 'vector');

clf
m = boxplot([N4_A_iii_amp', N4_B_iii_amp', N4_C_iii_amp'], 'Whisker',1.5,'Symbol','ko');
ylim([0 1.5])
set(gca,'FontSize',30)
ylabel('R_a [-]')
axis square
set(gca,'LineWidth',2)
set(m,'LineWidth',2)
exportgraphics(gcf,'analysed\N4_iii_amp.pdf', 'ContentType', 'vector');

clf
m = boxplot([N4_A_i_pha', N4_B_i_pha', N4_C_i_pha'], 'Whisker',1.5,'Symbol','ko');
ylim([0 0.5])
set(gca,'FontSize',30)
ylabel('R_p [-]')
axis square
set(gca,'LineWidth',2)
set(m,'LineWidth',2)
exportgraphics(gcf,'analysed\N4_i_pha.pdf', 'ContentType', 'vector');

clf
m = boxplot([N4_A_ii_pha', N4_B_ii_pha', N4_C_ii_pha'], 'Whisker',1.5,'Symbol','ko');
ylim([0 0.5])
set(gca,'FontSize',30)
ylabel('R_p [-]')
axis square
set(gca,'LineWidth',2)
set(m,'LineWidth',2)
exportgraphics(gcf,'analysed\N4_ii_pha.pdf', 'ContentType', 'vector');

clf
m = boxplot([N4_A_iii_pha', N4_B_iii_pha', N4_C_iii_pha'], 'Whisker',1.5,'Symbol','ko');
ylim([0 0.5])
set(gca,'FontSize',30)
ylabel('R_p [-]')
axis square
set(gca,'LineWidth',2)
set(m,'LineWidth',2)
exportgraphics(gcf,'analysed\N4_iii_pha.pdf', 'ContentType', 'vector');