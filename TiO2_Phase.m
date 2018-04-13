clear;
folder_name = 'Sweep';
 
% READ DAT FILES
addpath(folder_name);
dat_files = dir('*.mat'); 
% Make sure .mat files are in the SAME DIRECTORY
% Otherwise try: dat_files = dir([folder_name, '\*.mat']);
 
temp = [dat_files(:).datenum].';
[~,temp] = sort(temp);
dat_files = {dat_files(temp).name}; % sorted list of dat files
load(char(dat_files(1)));
 
% STORE DATA FROM DAT FILES
phase_matrix = zeros(length(dat_files),length(lambda));
T_matrix = zeros(length(dat_files),length(lambda));
para_matrix = zeros(length(dat_files),3);
 
 
for i = 1:length(dat_files)
    load(char(dat_files(i)));
    phase_matrix(i,:) = phases;
    T_matrix(i,:) = T;
    para_matrix(i,:) = [U H R];
end
 
lambda = lambda*1e9;
rmpath(folder_name);
 
figure;
imagesc(lambda,para_matrix(:,3)*1e9,phase_matrix)
xlabel('Wavelength (nm)');
ylabel('Pillar radius (nm)');
title('Phase');
 
figure;
imagesc(lambda,para_matrix(:,3)*1e9,T_matrix)
xlabel('Wavelength (nm)');
ylabel('Pillar radius (nm)');
title('Transmission');
 
library = zeros(size(phase_matrix,1),size(phase_matrix,2),2);
library(:,:,1) = phase_matrix; library(:,:,2) = T_matrix;
radii = para_matrix(:,3);
save('phaseamp_lib','library','radii','lambda');
