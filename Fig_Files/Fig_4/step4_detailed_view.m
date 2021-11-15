clear all
close all
clc

%%
% Manuscript: "Acoustic Hologram Optimisation Using Automatic Differentiation"
% Authors: Tatsuki Fushimi*, Kenta Yamamoto*, Yoichi Ochiai
% Corresponding email: tfushimi@slis.tsukuba.ac.jp

% This program generates supplementary figure 1 in the manuscript from the dataset.
cur_d = pwd;

p_0 = 1; %
f0 = 40e03; % Hz
c0 = 346; % m/s
side_length = 0.08; % m
center_z = 0.1;

lambda = c0/f0;
k = 2*pi*f0/c0;
a = 5e-03; % Transducer Radius

%% Transducer
cd ..
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
side_len = 0.05;
nn = 1;

g_x = [-0.05, -0.05, 0.05, 0.05];
g_y = [-0.05, 0.05, 0.05, -0.05];
g_z = [0.1, 0.1, 0.1, 0.1];


x_c = -0.09:lambda/20:0.09;
y_c = -0.09:lambda/20:0.09;
[XX, YY] = ndgrid(x_c, y_c);

cd(cur_d)
%% Targets
figure('units','normalized','outerposition',[0 0 1 1])
for ii = [2]
    for jj = [1,3]
        Hologram_amplitude = readtable(['results\Amplitude_exports_N_' num2str(4)  '_Trans_' tras_side{jj} '_Target_' target_side{ii} '_settings.csv'],'Delimiter',',');
        Hologram_amplitude = table2array(Hologram_amplitude);
        Hologram_phase = readtable(['results\Phase_exports_N_' num2str(4)  '_Trans_' tras_side{jj} '_Target_' target_side{ii}  '_settings.csv'],'Delimiter',',');
        Hologram_phase = table2array(Hologram_phase);
        
        clf
        p1 = 0;
        for tr = 1:length(Trans_x)
            r_prep_x = XX-Trans_x(tr);
            r_prep_y = YY-Trans_y(tr);
            r_prep_z = g_z(1)-Trans_z(tr);
            
            R = sqrt((r_prep_x).^2 + (r_prep_y).^2 + (r_prep_z).^2);
            dotproduct = r_prep_x.*trans_q(1) + r_prep_y.*trans_q(2) + r_prep_z.*trans_q(3);
            theta = acos(dotproduct./R./sqrt(trans_q(1).^2+trans_q(2).^2+trans_q(3).^2));
            theta(theta==0) = realmin;
            D = directivity_fun(k, a, theta);
            
            p1 = p1 + (p_0./R).* Hologram_amplitude(tr) .* D .* exp(1j.*(k.*R+Hologram_phase(tr)));
        end
        pcolor(x_c, y_c, abs(p1)')
        hold on
        scatter(g_x, g_y, 500,'kx','LineWidth',2)
        shading interp
        axis square
        colormap hot
        set(gca,'FontSize', 40)
        caxis([0 250])
        colorbar
        exportgraphics(gcf, [tras_side{jj} '_view.png'],'Resolution',300);
    end
end
