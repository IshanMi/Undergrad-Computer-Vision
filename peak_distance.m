mag = 1; % magnification
% Build matrices for all the focal spots
%{
f = [xFspot,yFspot, E_Fspot];
f = double(f);
[val,ind] = max(f); % f is the intensity profile
[mx col] = max(val);
row = ind(col); % col is the x-value for the cut
row1 = row; % row1 is the y-value for the cut
%}
matrix1(:,:,1) = im2double(imread('600nm_B10nm.tif'));
 
% im2double(imread(['image_Blens_405_N1.53_',num2str(i),'.tif']));
 
%{
imagesc(imread('111.bmp'))
imagesc(xFspot, yFspot, E_Fspot)
 
both produce the same colormap result.
%}
 
x_ind = (1317+1323)/2;
y_ind = (1550+1110)/2;
norm = 0.99;
 
% Generate matrices to store focal spots x-coordinates
% Find x-coordinates for all these focal spots
matrix1_x_index = zeros(1,1);
matrix1_x_index(1) = x_ind;
 
% Make cut matrices for use later
matrix1_cut = zeros(1,size(matrix1, 1));
 
temp1 = matrix1(:, matrix1_x_index(1),1);
matrix1_cut(1, :) = temp1 - min(temp1);
 
y1 = 1:length(matrix1_cut);
 
% Create matrices to store final (useful) values
 
FWHM = zeros(1,1);
space_1_fit = zeros(1, length(y1));
 
temp1 = fit(y1', matrix1_cut(1,:)', 'Gauss1');
space_1_fit(1,:) = gauss(y1, temp1.a1, temp1.b1, temp1.c1);
FWHM(1) = 2*temp1.c1*sqrt(log(2));
 
 
% FWHM returns a quantity in pixels
% so you multiply it by the size of the pixel (pix) and divide it by the
% magnification you are viewing it in (mag) to get the original FWHM of the
% beam.
 
disp('FWHM ')
disp(FWHM)
%approx = lamb/(2*NA);
%disp('Lambda / 2NA')
%disp(approx)
