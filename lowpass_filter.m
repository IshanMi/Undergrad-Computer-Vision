% Implement spatial-domain low-pass filtering
% Evaluate the difference between the filtered image and the original image
% using Mean Squared Error (MSE) and Peak Signal-to-Noise Ratio (PSNR)
 
% Given two images (size N1 x N2), x(n1,n2) & y(n1,n2), 
% MSE = 1/(N1*N2) * sum(n1 = 1 to N1) sum(n2=1 to N2) of
% [x(n1,n2)-y(n1,n2)]^2
 
% PSNR = 10 log(MAX^2/MSE), where MAX is the maximum pixel value of the
% image
 
%% Variables
MAX = 255;
 
% Step 2: Convert Image from uint8 to double
x = double(imread('lena.gif'));
 
% Step 3: Create a Low-Pass Filter
low_pass_filter = ones(3,3)*(1/9);
 
% Step 4: Use the Low-Pass Filter
y = imfilter(x, low_pass_filter, 'replicate');
 
[N1,N2] = size(x);
 
summ = 0;
for n1 = 1:N1
    for n2 = 1:N2
        summ = summ + (x(n1,n2)-y(n1,n2))^2;
    end
end
MSE = summ/N1/N2; 
 
% Step 5
PSNR = 10*log10(MAX^2/MSE);
 
% MSE for im2double was 0.002576653963535
 
% Repeat with 5x5 low pass filter
 
low_pass_filter5 = ones(5,5)*1/25;
 
y2 = imfilter(x, low_pass_filter5, 'replicate');
 
summation = 0;
for n1 = 1:N1
    for n2 = 1:N2
        summation = summation + (x(n1,n2)-y2(n1,n2))^2;
    end
end
MSE1 = summation/N1/N2;
PSNR1 = 10*log10(MAX^2/MSE1);
