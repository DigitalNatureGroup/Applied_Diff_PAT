clear all
close all
clc

trans_q = [0 0 1];
setting = [1,2,3];
tras_side = {'A','B','C'};
target_side = {'i','ii','iii'};


name = categorical({'Point 1','Point 2','Point 3','Point 4'});
modulati = {'[i] Phase','[ii] Amplitude','[iii] P&A'};
figure('units','normalized','outerposition',[0 0 1 1])
for ii = 1:length(setting)
    for jj = 1:length(setting)
        %% Acoustic Hologram
        Loss_list = readtable(['results\Loss_exports_N_2_Trans_' tras_side{jj} '_Target_' target_side{ii} '_settings.csv'],'Delimiter',',');
        Loss_list = table2array(Loss_list);
        clf
        plot(Loss_list','LineWidth',2)
%         ylim([0.001 1000])
        xlim([0 1100])
        set(gca, 'YScale', 'log')
        set(gca,'FontSize',20)
        exportgraphics(gcf,['convergence\Conv_Trans_' tras_side{jj} '_Target_' target_side{ii} '_settings.pdf'],'BackgroundColor','none','ContentType','vector')
    end
    
end
