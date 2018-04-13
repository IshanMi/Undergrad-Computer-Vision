%{
To find:
 
Young's modulus 
 
 
Tensile Strength
 
 
Stress at break - Done
Stress value at the last data point: Wrong because it falls
Maximum value of graph
 
Strain at break - Done
Strain value at the last data point: Wrong because it falls
index corresponding to maximum stress value
%}
close all
clear all
clc
 
file_type = '*.csv';
list_of_files = dir(file_type);
len = length(list_of_files);
 
tensile_strength = [];strain_break = [];stress_break = [];
 
for i = 1:len
    file_name = list_of_files(i).name;
    data_table = readtable(file_name); % this includes headers!
     
    table_time = data_table(2:end, 1);
    table_load = data_table(2:end, 2);
    table_stress = data_table(2:end, 5);
    table_extension = data_table(2:end, 4);
    table_strain = data_table(2:end, 3);
     
    stress = []; 
    strain = [];
    time = [];
    extension = [];
    load = [];
    for j = 1:height(table_stress)
        stress(end+1) = str2num(table_stress{j,1}{1});
        strain(end+1) = str2num(table_strain{j,1}{1});
        load(end+1) = str2num(table_load{j,1}{1});
        time(end+1) = str2num(table_time{j,1}{1});
        extension(end+1) = str2num(table_extension{j,1}{1});
    end
     
    % Young's Modulus
     
     
    % Tensile Strength
     
    tensile_strength(end+1) = max(stress);
     
     
     
    % Stress at break
     
    stress_break(end+1) = max(stress);
     
     
    % Strain at break
     
    k = find(stress == max(stress));
    strain_break(end+1) = strain(k);
     
     
    figure
    plot(strain,stress)
    grid on
    title(num2str(i))
    xlabel('Strain')
    ylabel('Stress')
     
end
disp('Tensile')
disp(tensile_strength')
disp('stress at break')
disp(stress_break')
disp('strain at break')
disp(strain_break')
