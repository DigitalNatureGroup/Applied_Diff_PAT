clear all
close all
clc

% For reproducibility
rng('default')

N_list = [2, 4, 8, 16, 32];
number_of_samples = 1000;
max_pressure = 950;
minimum_pressure = 10;

xyz_amp = 0.1;
z_center = 0.1;

for nn = 1:length(N_list)
    target_x = (rand(N_list(nn), number_of_samples)-0.5).*xyz_amp;
    target_y = (rand(N_list(nn), number_of_samples)-0.5).*xyz_amp;
    target_z = (rand(N_list(nn), number_of_samples)-0.5).*xyz_amp + z_center;
    target_phase = rand(N_list(nn), number_of_samples).*(2*pi);
    amplitude = rand(N_list(nn), number_of_samples);
    amplitude = amplitude ./ sum(amplitude,1);
    target_amplitude = amplitude.*(max_pressure-(N_list(nn).*minimum_pressure)) + minimum_pressure;
    writematrix(target_x,['Target_Field_Additional\Target_X_N_' num2str(N_list(nn)) '.csv'])
    writematrix(target_y,['Target_Field_Additional\Target_Y_N_' num2str(N_list(nn)) '.csv'])
    writematrix(target_z,['Target_Field_Additional\Target_Z_N_' num2str(N_list(nn)) '.csv'])
    writematrix(target_amplitude,['Target_Field_Additional\Target_Amp_N_' num2str(N_list(nn)) '.csv'])
    writematrix(target_phase,['Target_Field_Additional\Target_Phase_N_' num2str(N_list(nn)) '.csv'])
end