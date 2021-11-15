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

x_c = -0.07:lambda/20:0.07;
y_c = -0.07:lambda/20:0.07;
[XX, YY] = ndgrid(x_c, y_c);
t = 0.05:0.1:2*pi;
x1 = 35e-03.*cos(t);
y1 = 35e-03.*sin(t);
x2 = 45e-03.*cos(t);
y2 = 45e-03.*sin(t);
pgon = polyshape({x1,x2},{y1,y2});
x3 = [-0.07, -0.07, 0.07, 0.07];
y3 = [-0.07, 0.07,0.07, -0.07];
pgon2 = addboundary(pgon,x3,y3);
cd(cur_d)
%% Targets

for ii = [3]
    for jj = [3]
        Hologram_amplitude = readtable(['results\Amplitude_exports_N_' num2str(60)  '_Trans_' tras_side{jj} '_Target_' target_side{ii} '_settings.csv'],'Delimiter',',');
        Hologram_amplitude = table2array(Hologram_amplitude);
        Hologram_phase = readtable(['results\Phase_exports_N_' num2str(60)  '_Trans_' tras_side{jj} '_Target_' target_side{ii}  '_settings.csv'],'Delimiter',',');
        Hologram_phase = table2array(Hologram_phase);
        
        clf
        p1 = 0;
        for tr = 1:length(Trans_x)
            r_prep_x = XX-Trans_x(tr);
            r_prep_y = YY-Trans_y(tr);
            r_prep_z = 0.1-Trans_z(tr);
            
            R = sqrt((r_prep_x).^2 + (r_prep_y).^2 + (r_prep_z).^2);
            dotproduct = r_prep_x.*trans_q(1) + r_prep_y.*trans_q(2) + r_prep_z.*trans_q(3);
            theta = acos(dotproduct./R./sqrt(trans_q(1).^2+trans_q(2).^2+trans_q(3).^2));
            theta(theta==0) = realmin;
            D = directivity_fun(k, a, theta);
            
            p1 = p1 + (p_0./R).* Hologram_amplitude(tr) .* D .* exp(1j.*(k.*R+Hologram_phase(tr)));
        end
        figure('units','normalized','outerposition',[0 0 1 1])
        pcolor(x_c, y_c, abs(p1)')
        hold on
        plot(pgon2)
        shading interp
        axis square
        colormap hot
        caxis([0 60])
        set(gca,'FontSize', 40)
        exportgraphics(gca, ['amplitude.png'],'Resolution',300);
%         return
        figure('units','normalized','outerposition',[0 0 1 1])
        pcolor(x_c, y_c, angle(p1)')
        hold on
        plot(pgon2)
        
        shading interp
        axis square
        colormap hsv
        set(gca,'FontSize', 40)
%         colorbar
        exportgraphics(gca, ['phase.png'],'Resolution',300);
    end
end


