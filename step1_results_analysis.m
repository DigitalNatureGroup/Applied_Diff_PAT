clear all
close all
clc

%%
% Manuscript: "Target Acoustic Field and Transducer State Optimization using Diff-PAT"
% Authors: Tatsuki Fushimi*, Kenta Yamamoto*, Yoichi Ochiai
% Corresponding email: tfushimi@slis.tsukuba.ac.jp

% This program generates figure 2 in the manuscript from the dataset.

%% Settings
p_0 = 1; % Pa
f0 = 40e03; % Hz
c0 = 346; % m/s
side_length = 0.08; % m
center_z = 0.1; % m

lambda = c0/f0; % wavelength m
k = 2*pi*f0/c0; % wavenumber
a = 5e-03; % Transducer Radius

%% Transducer
Trans_x = readtable(['transducer_x.csv'],'Delimiter',',');
Trans_x = table2array(Trans_x);
Trans_y = readtable(['transducer_y.csv'],'Delimiter',',');
Trans_y = table2array(Trans_y);
Trans_z = readtable(['transducer_z.csv'],'Delimiter',',');
Trans_z = table2array(Trans_z);

%% Names
trans_q = [0 0 1];
setting = [1,2,3];
tras_side = {'A','B','C'};
target_side = {'i','ii','iii'};
name = categorical({'Point 1','Point 2','Point 3','Point 4'});
modulati = {'[i] Phase','[ii] Amplitude','[iii] P&A'};
N_list = [2,4];

%% Analysis Loop
for nn = 1:2
    %% Load Targets
    Target_amp = readtable(['Target_amp_N_' num2str(N_list(nn)) '.csv'],'Delimiter',',');
    Target_amp = table2array(Target_amp);
    
    Target_pha = readtable(['Target_Phase_N_' num2str(N_list(nn)) '.csv'],'Delimiter',',');
    Target_pha = table2array(Target_pha);
    
    g_x = readtable(['Target_X_N_' num2str(N_list(nn)) '.csv'],'Delimiter',',');
    g_x = table2array(g_x);
    g_y = readtable(['Target_Y_N_' num2str(N_list(nn)) '.csv'],'Delimiter',',');
    g_y = table2array(g_y);
    g_z = readtable(['Target_Z_N_' num2str(N_list(nn)) '.csv'],'Delimiter',',');
    g_z = table2array(g_z);
    
    for ii = 1:3
        for jj = 1:3
            %% Load Hologram
            Hologram_amplitude = readtable(['results\Amplitude_exports_N_' num2str(N_list(nn))  '_Trans_' tras_side{jj} '_Target_' target_side{ii} '_settings.csv'],'Delimiter',',');
            Hologram_amplitude = table2array(Hologram_amplitude);
            Hologram_phase = readtable(['results\Phase_exports_N_' num2str(N_list(nn))  '_Trans_' tras_side{jj} '_Target_' target_side{ii}  '_settings.csv'],'Delimiter',',');
            Hologram_phase = table2array(Hologram_phase);
            
            %% Store Data
            amplitude = zeros(1, 1000*N_list(nn));
            phase = zeros(1, 1000*N_list(nn));
            
            %% 
            for mm = 1:1000
                amp_t = zeros(1, N_list(nn));
                pha_t = zeros(1, N_list(nn));
                %% Find Pressure Amplitude/Phase
                for kk = 1:N_list(nn)
                    p1 = 0;
                    for tr = 1:length(Trans_x)
                        r_prep_x = g_x(kk, mm)-Trans_x(tr);
                        r_prep_y = g_y(kk, mm)-Trans_y(tr);
                        r_prep_z = g_z(kk, mm)-Trans_z(tr);
                        
                        R = sqrt((r_prep_x).^2 + (r_prep_y).^2 + (r_prep_z).^2);
                        dotproduct = r_prep_x.*trans_q(1) + r_prep_y.*trans_q(2) + r_prep_z.*trans_q(3);
                        theta = acos(dotproduct./R./sqrt(trans_q(1).^2+trans_q(2).^2+trans_q(3).^2));
                        theta(theta==0) = realmin;
                        D = directivity_fun(k, a, theta);
                        
                        p1 = p1 + (p_0./R).* Hologram_amplitude(mm, tr) .* D .* exp(1j.*(k.*R+Hologram_phase(mm, tr)));
                    end
                    amp_t(kk) = abs(p1);
                    pha_t(kk) = angle(p1);
                end
                %% Store it
                amplitude((mm-1)*N_list(nn)+1:mm*N_list(nn)) = (amp_t./Target_amp(:,mm)');
                phase((mm-1)*N_list(nn)+1:mm*N_list(nn)) = (abs(cos(Target_pha(:,mm))-cos(pha_t)'));
                
            end
            %% Save it
            save(['analysed\N_' num2str(N_list(nn))  '_Trans_' tras_side{jj} '_Target_' target_side{ii} '_settings.mat'], 'amplitude', 'phase');
        end
    end
end
