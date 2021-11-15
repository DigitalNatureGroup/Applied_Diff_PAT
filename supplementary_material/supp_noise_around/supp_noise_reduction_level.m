clear all
close all
clc

%%
% Manuscript: "Target Acoustic Field and Transducer State Optimization using Diff-PAT"
% Authors: Tatsuki Fushimi*, Kenta Yamamoto*, Yoichi Ochiai
% Corresponding email: tfushimi@slis.tsukuba.ac.jp

% This program evaluates and plots the histograms on ambient noise around
% the focal point.


p_0 = 1; %
f0 = 40e03; % Hz
c0 = 346; % m/s
side_length = 0.08; % m
center_z = 0.1;

lambda = c0/f0;
k = 2*pi*f0/c0;
a = 5e-03; % Transducer Radius

%% Transducer
Trans_x = readtable(['transducer_x.csv'],'Delimiter',',');
Trans_x = table2array(Trans_x);
Trans_y = readtable(['transducer_y.csv'],'Delimiter',',');
Trans_y = table2array(Trans_y);
Trans_z = readtable(['transducer_z.csv'],'Delimiter',',');
Trans_z = table2array(Trans_z);
trans_q = [0 0 1];
setting = [1,2,3];
tras_side = {'A','B','C'};
target_side = {'i','ii','iii'};
name = categorical({'Point 1','Point 2','Point 3','Point 4'});
modulati = {'[i] Phase','[ii] Amplitude','[iii] P&A'};
N_list = [2,4,8,16,32];
side_len = 0.03;
nn = 1;
for nn = 1:length(N_list)
    close all
    %% Targets
    Target_amp = readtable(['Target_Field_Additional\Target_amp_N_' num2str(N_list(nn)) '.csv'],'Delimiter',',');
    Target_amp = table2array(Target_amp);
    
    Target_pha = readtable(['Target_Field_Additional\Target_Phase_N_' num2str(N_list(nn)) '.csv'],'Delimiter',',');
    Target_pha = table2array(Target_pha);
    
    g_x = readtable(['Target_Field_Additional\Target_X_N_' num2str(N_list(nn)) '.csv'],'Delimiter',',');
    g_x = table2array(g_x);
    g_y = readtable(['Target_Field_Additional\Target_Y_N_' num2str(N_list(nn)) '.csv'],'Delimiter',',');
    g_y = table2array(g_y);
    g_z = readtable(['Target_Field_Additional\Target_Z_N_' num2str(N_list(nn)) '.csv'],'Delimiter',',');
    g_z = table2array(g_z);
    figure('units','normalized','outerposition',[0 0 1 1])
    
    radius_criteria = 2.5*lambda;
    sum_p = zeros(2, 1000);
    ii = 2;
    sel_tra = [1,3];
    
    for JJ = 1:length(sel_tra)
        jj = sel_tra(JJ);
        Hologram_amplitude = readtable(['results\Amplitude_exports_N_' num2str(N_list(nn))  '_Trans_' tras_side{jj} '_Target_' target_side{ii} '_settings.csv'],'Delimiter',',');
        Hologram_amplitude = table2array(Hologram_amplitude);
        Hologram_phase = readtable(['results\Phase_exports_N_' num2str(N_list(nn))  '_Trans_' tras_side{jj} '_Target_' target_side{ii}  '_settings.csv'],'Delimiter',',');
        Hologram_phase = table2array(Hologram_phase);
        
        for mm = 1:1000
            sum_p1 = 0;
            for kk = 1:N_list(nn)
                p1 = 0;
                
                x_c = g_x(kk, mm)-side_len:lambda/20:g_x(kk, mm)+side_len;
                y_c = g_y(kk, mm)-side_len:lambda/20:g_y(kk, mm)+side_len;
                [XX, YY] = ndgrid(x_c, y_c);
                
                parfor tr = 1:length(Trans_x)
                    r_prep_x = XX-Trans_x(tr);
                    r_prep_y = YY-Trans_y(tr);
                    r_prep_z = g_z(kk, mm)-Trans_z(tr);
                    
                    R = sqrt((r_prep_x).^2 + (r_prep_y).^2 + (r_prep_z).^2);
                    dotproduct = r_prep_x.*trans_q(1) + r_prep_y.*trans_q(2) + r_prep_z.*trans_q(3);
                    theta = acos(dotproduct./R./sqrt(trans_q(1).^2+trans_q(2).^2+trans_q(3).^2));
                    theta(theta==0) = realmin;
                    D = directivity_fun(k, a, theta);
                    
                    p1 = p1 + (p_0./R).* Hologram_amplitude(mm, tr) .* D .* exp(1j.*(k.*R+Hologram_phase(mm, tr)));
                end
                
                R = sqrt((XX-g_x(kk, mm)).^2+(YY-g_y(kk, mm)).^2);
                p1(R<radius_criteria) = 0;
                sum_p1 = sum_p1 + sum(sum(abs(p1)));
            end
            sum_p(JJ, mm) = sum_p1;
        end
    end
    A = sum_p(2,:)./sum_p(1,:);
    
    figure('units','normalized','outerposition',[0 0 1 1])
    histogram(sum_p(1,:), 50)
    hold on
    histogram(sum_p(2,:), 50)
    legend('A:ii','C:ii')
    
    ylabel('Occurences [-]')
    xlabel('Sum of Ambient Noise [Pa]')
    set(gca,'FontSize',40)
    grid on
    exportgraphics(gcf,['N_' num2str(N_list(nn)) '.jpg'],'ContentType','vector');
end