clear all
close all
clc

curpwd = pwd;
cd ..
cd ..

T= table2array(readtable('results\Amplitude_exports_N_2_Trans_B_Target_ii_settings.csv'));
% percentage = mean(sum((T<0.1), 2)./(256));
figure('units','normalized','outerposition',[0 0 1 1])
histogram(T(1,:), 50)
xlabel('Transducer Amplitude [-]')
ylabel('Occurences [-]')
set(gca,'FontSize',24)
cd(curpwd)
exportgraphics(gcf,'supp_trans_amp.pdf','ContentType','vector');

cd ..
f0 = 40e03; % Hz
c0 = 346; % m/s
lambda = c0/f0; % wavelength m
k = 2.*pi.*f0./c0;

trans_x = table2array(readtable('transducer_x.csv'));
trans_y = table2array(readtable('transducer_y.csv'));
trans_z = table2array(readtable('transducer_z.csv'));

target_x = table2array(readtable('Target_X_N_2.csv'));
target_y = table2array(readtable('Target_Y_N_2.csv'));
target_z = table2array(readtable('Target_Z_N_2.csv'));
% for xi = 1:1000
xi = 100;
phase_matrix = zeros(2, 256);
for ii = 1:2
    for tr = 1:256
        R = sqrt((trans_x(tr) - target_x(ii, xi)).^2 + (trans_y(tr) - target_y(ii, xi)).^2 + (trans_z(tr) - target_z(ii, xi)).^2);
        phase = k.*R;
        phase_matrix(ii, tr) = mod(phase, 2.*pi);
    end
end
figure
scatter(T(1,:), phase_matrix(1, :))
hold on
scatter(T(1,:), phase_matrix(2, :))
% end
