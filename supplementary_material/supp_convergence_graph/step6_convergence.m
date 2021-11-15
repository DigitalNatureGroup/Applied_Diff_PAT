clear all
close all
clc
N_list = [2,4];

cur_pwd = pwd;

for nn = 1:length(N_list)
    cd ..
    cd ..
    
    Ai_convergence = table2array(readtable(['results\Loss_exports_N_' num2str(N_list(nn)) '_Trans_A_Target_i_settings.csv'],'Delimiter',','));
    Ci_convergence = table2array(readtable(['results\Loss_exports_N_' num2str(N_list(nn)) '_Trans_C_Target_i_settings.csv'],'Delimiter',','));
    Aii_convergence = table2array(readtable(['results\Loss_exports_N_' num2str(N_list(nn)) '_Trans_A_Target_ii_settings.csv'],'Delimiter',','));
    Cii_convergence = table2array(readtable(['results\Loss_exports_N_' num2str(N_list(nn)) '_Trans_C_Target_ii_settings.csv'],'Delimiter',','));
    Aiii_convergence = table2array(readtable(['results\Loss_exports_N_' num2str(N_list(nn)) '_Trans_A_Target_iii_settings.csv'],'Delimiter',','));
    Ciii_convergence = table2array(readtable(['results\Loss_exports_N_' num2str(N_list(nn)) '_Trans_C_Target_iii_settings.csv'],'Delimiter',','));
    
    
    Ai_mean = mean(Ai_convergence, 1);
    Ci_mean = mean(Ci_convergence, 1);
    Aii_mean = mean(Aii_convergence, 1);
    Cii_mean = mean(Cii_convergence, 1);
    Aiii_mean = mean(Aiii_convergence, 1);
    Ciii_mean = mean(Ciii_convergence, 1);
    
    cd(cur_pwd)
    
    close all
    figure('units','normalized','outerposition',[0 0 1 1])
   
    subplot(3,1,1)
    hold on
    plot(Ai_mean, 'LineWidth',2)
    plot(Ci_mean, 'LineWidth',2)
    title('i')
    ylabel('Loss [-]')
    set(gca,'YScale','log')
    set(gca,'FontSize',24)
    legend('A','C')
    subplot(3,1,2)
    hold on
    plot(Aii_mean, 'LineWidth',2)
    plot(Cii_mean, 'LineWidth',2)
    title('ii')
    ylabel('Loss [-]')
    set(gca,'YScale','log')
    set(gca,'FontSize',24)
    legend('A','C')
    subplot(3,1,3)
    hold on
    plot(Aiii_mean, 'LineWidth',2)
    plot(Ciii_mean, 'LineWidth',2)
    title('iii')
    xlabel('Iteration # [-]')
    ylabel('Loss [-]')
    set(gca,'YScale','log')
    set(gca,'FontSize',24)
    legend('A','C')
    
    exportgraphics(gcf,['convergence_N_' num2str(N_list(nn)) '.jpg'])
end