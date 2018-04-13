clear all
clc
 
pix = 1.67; % pixels on lens - check whether 1.67 or 2.2
mag = 100; % magnification
NA = 1.1; 
% Build matrices for all the focal spots
 
for i = 0:6
    matrix_blue405_53(:,:,i+1) = im2double(imread(['image_Blens_405_N1.53_',num2str(i),'.tif']));
end
 
for i = 0:4
    matrix_blue405_54(:,:,i+1) = im2double(imread(['image_Blens_405_N1.54_',num2str(i),'.tif']));
end
 
for i = 0:5
    matrix_blue532(:,:,i+1) = im2double(imread(['image_Blens_532_N1.53_', num2str(i), '.tif']));
    matrix_green405(:,:,i+1) = im2double(imread(['image_Glens_405_N1.53_', num2str(i), '.tif']));
    matrix_green1_532(:,:,i+1) = im2double(imread(['image_Glens_532_N1.53_', num2str(i), '.tif']));    
end
 
for i = 0:3
    matrix_green2_532(:,:,i+1) = im2double(imread(['image_Glens2_532_N1.53_',num2str(i), '.tif']));
end
 
% Generate matrices to store focal spots x-coordinates
 
% Find x-coordinates for all these focal spots
matrix_blue_405_N1_53_x_index = zeros(1,7);
matrix_blue_405_N1_53_x_index(1) = 1938; 
matrix_blue_405_N1_53_x_index(2) = 1938;
matrix_blue_405_N1_53_x_index(3) = 1939; 
matrix_blue_405_N1_53_x_index(4) = 1939;
matrix_blue_405_N1_53_x_index(5) = 1941; 
matrix_blue_405_N1_53_x_index(6) = 1939;
matrix_blue_405_N1_53_x_index(7) = 1935;
 
matrix_blue_405_N1_54_x_index = zeros(1,5);
matrix_blue_405_N1_54_x_index(1) = 1760;
matrix_blue_405_N1_54_x_index(2) = 1757;
matrix_blue_405_N1_54_x_index(3) = 1755;
matrix_blue_405_N1_54_x_index(4) = 1761;
matrix_blue_405_N1_54_x_index(5) = 1753;
 
matrix_blue_532_x_index = zeros(1,6);
matrix_blue_532_x_index(1) = 1959;
matrix_blue_532_x_index(2) = 1955;
matrix_blue_532_x_index(3) = 1953;
matrix_blue_532_x_index(4) = 1957;
matrix_blue_532_x_index(5) = 1947;
matrix_blue_532_x_index(6) = 1945;
 
matrix_green_405_x_index = zeros(1,6);
matrix_green_405_x_index(1) = 2332;
matrix_green_405_x_index(2) = 2331;
matrix_green_405_x_index(3) = 2329;
matrix_green_405_x_index(4) = 2331;
matrix_green_405_x_index(5) = 2334;
matrix_green_405_x_index(6) = 2333;
 
matrix_green_532_x_index = zeros(1,6);
matrix_green_532_x_index(1) = 1861;
matrix_green_532_x_index(2) = 1860;
matrix_green_532_x_index(3) = 1855;
matrix_green_532_x_index(4) = 1860;
matrix_green_532_x_index(5) = 1858;
matrix_green_532_x_index(6) = 1855;
 
matrix_green2_532_x_index = zeros(1,4);
matrix_green2_532_x_index(1) = 1962;
matrix_green2_532_x_index(2) = 1967;
matrix_green2_532_x_index(3) = 1963;
matrix_green2_532_x_index(4) = 1965;
 
% Make cut matrices for use later
matrix_blue405_53_cut = zeros(1,size(matrix_blue405_53, 1));
matrix_blue405_54_cut = zeros(1,size(matrix_blue405_54, 1));
matrix_blue532_cut = zeros(1, size(matrix_blue532,1));
matrix_green405_cut = zeros(1, size(matrix_green405, 1));
matrix_green1_532_cut = zeros(1, size(matrix_green1_532, 1));
matrix_green2_532_cut = zeros(1, size(matrix_green2_532, 1));
 
for i = 1:7
    temp_blue405_53 = matrix_blue405_53(:, matrix_blue_405_N1_53_x_index(i), i);
    matrix_blue405_53_cut(i, :) = temp_blue405_53 - min(temp_blue405_53);
end
 
for i = 1:5
    temp_blue405_54 = matrix_blue405_54(:, matrix_blue_405_N1_54_x_index(i), i);
    matrix_blue405_54_cut(i, :) = temp_blue405_54 - min(temp_blue405_54);
end
 
for i = 1:6
    temp_blue532 = matrix_blue532(:, matrix_blue_532_x_index(i), i);
    matrix_blue532_cut(i, :) = temp_blue532 - min(temp_blue532);
     
    temp_green405 = matrix_green405(:, matrix_green_405_x_index(i), i);
    matrix_green405_cut(i, :) = temp_green405 - min(temp_green405);
     
    temp_green1_532 = matrix_green1_532(:, matrix_green_532_x_index(i), i);
    matrix_green1_532_cut(i, :) = temp_green1_532 - min(temp_green1_532);
end
 
for i = 1:4
    temp_green2_532 = matrix_green2_532(:, matrix_green2_532_x_index(i), i);
    matrix_green2_532_cut(i, :) = temp_green2_532 - min(temp_green2_532);
end
 
y7 = 1:length(matrix_blue405_53_cut);
y5 = 1:length(matrix_blue405_54_cut);
y6 = 1:length(matrix_blue532_cut);
y4 = 1:length(matrix_green2_532_cut);
 
% Create matrices to store final (useful) values
 
FWHM_blue405_53_V = zeros(1,7);
space_blue405_53_fit = zeros(7, length(y7));
 
FWHM_blue405_54_V = zeros(1,5);
space_blue405_54_fit = zeros(5, length(y5));
 
FWHM_blue532_V = zeros(1,6);
space_blue532_fit = zeros(6, length(y6));
FWHM_green405_V = zeros(1,6);
space_blue405_fit = zeros(6, length(y6));
FWHM_green1_532_V = zeros(1,6);
space_green1_532_fit = zeros(6, length(y6));
 
FWHM_green2_532_V = zeros(1,4);
space_green2_532_fit = zeros(4, length(y4));
 
for i = 1:7
    temp_blue405_53 = fit(y7', matrix_blue405_53_cut(i,:)', 'Gauss1');
    space_blue405_53_fit(i,:) = gauss(y7, temp_blue405_53.a1, temp_blue405_53.b1, temp_blue405_53.c1);
    FWHM_blue405_53_V(i) = 2*temp_blue405_53.c1*sqrt(log(2))*pix/mag; 
end
 
for i = 1:5
    temp_blue405_54 = fit(y5', matrix_blue405_54_cut(i,:)' ,'Gauss1');
    space_blue405_54_fit(i,:) = gauss(y5,  temp_blue405_54.a1, temp_blue405_54.b1, temp_blue405_54.c1);
    FWHM_blue405_54_V(i) = 2*temp_blue405_54.c1*sqrt(log(2))*pix/mag;
end
 
for i = 1:6
    temp_blue532 = fit(y6', matrix_blue532_cut(i,:)' ,'Gauss1');
    space_blue532_fit(i,:) = gauss(y5,  temp_blue532.a1, temp_blue532.b1, temp_blue532.c1);
    FWHM_blue532_V(i) = 2*temp_blue532.c1*sqrt(log(2))*pix/mag;
     
    temp_green405 = fit(y6', matrix_green405_cut(i,:)' ,'Gauss1');
    space_green405_fit(i,:) = gauss(y5,  temp_green405.a1, temp_green405.b1, temp_green405.c1);
    FWHM_green405_V(i) = 2*temp_green405.c1*sqrt(log(2))*pix/mag;
     
    temp_green1_532 = fit(y6', matrix_green1_532_cut(i,:)' ,'Gauss1');
    space_green1_532_fit(i,:) = gauss(y5,  temp_green1_532.a1, temp_green1_532.b1, temp_green1_532.c1);
    FWHM_green1_532_V(i) = 2*temp_green1_532.c1*sqrt(log(2))*pix/mag;
end
 
for i = 1:4
    temp_green2_532 = fit(y4', matrix_green2_532_cut(i,:)' ,'Gauss1');
    space_green2_532_fit(i,:) = gauss(y5,  temp_green2_532.a1, temp_green2_532.b1, temp_green2_532.c1);
    FWHM_green2_532_V(i) = 2*temp_green2_532.c1*sqrt(log(2))*pix/mag;
end
 
disp('For blue lens, 405nm, N1_53 : ')
disp(FWHM_blue405_53_V')
disp('For blue lens, 405nm, N1_54 : ')
disp(FWHM_blue405_54_V')
disp('For blue lens, 532nm : ')
disp(FWHM_blue532_V')
disp('For green lens, 405nm : ')
disp(FWHM_green405_V')
disp('For green lens 1, 532nm : ') 
disp(FWHM_green1_532_V')
disp('For green lens 2, 532 nm : ')
disp(FWHM_green2_532_V')
 
save('vertical_cut.mat', 'FWHM_blue405_53_V', 'FWHM_blue405_54_V', 'FWHM_blue532_V', 'FWHM_green1_532_V', 'FWHM_green2_532_V', 'FWHM_green405_V')
