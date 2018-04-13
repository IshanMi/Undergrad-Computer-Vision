% This is an attempt at creating a script capable of calculating Strehl 
% ratios for all the given images at once, as opposed to the current method
% of finding them one by one.
 
% Copy to Remote Desktop PC in appropriate directory when done to test & debug.
 
% Define Variables
d =  300; f =  200; pix = 1.67; mag = 100; lambda = 0.405; NA = sin(atan(d/(2*f))); % diffraction_limit = lambda/(2*NA);
aaa = -2:0.005:2;
 
% Get right side of variable tree
airyd= @(k,NA,a,I_0) I_0*(2*besselj(1,k*NA*a)./(k*NA*a)).^2;
th_airy = airyd(2*pi/lambda,NA,aaa,1); 
th_airy(round(length(aaa)/2)) = 1;
th_airy2 = th_airy(184:617); 
aaa2 = aaa(184:617);
th_airy3 = th_airy2/(sum(th_airy2)*(aaa2(2)-aaa2(1)));
th_airy4 = th_airy3/max(th_airy3);
 
for i = 1:2
    matrix1(:,:,i) = im2double(imread(['pad_1_',num2str(i),'.bmp']));
end
for i = 1:3
    matrix4(:,:,i) = im2double(imread(['pad_4_',num2str(i),'.bmp']));
end
for i = 1:4
    matrix3(:,:,i) = im2double(imread(['pad_3_',num2str(i),'.bmp']));
end
for i = 1:6
    matrix2(:,:,i) = im2double(imread(['pad_2_',num2str(i),'.bmp']));
end
 
% Insert corresponding x-values
 
matrix1_x = zeros(1,2);
matrix1_x(1) = 2738; matrix1_x(2) = 2738;
 
matrix2_x = zeros(1,6);
matrix2_x(1) = 2307; matrix2_x(2) = 2309; matrix2_x(3) = 2313;
matrix2_x(4) = 2319; matrix2_x(5) = 2321; matrix2_x(6) = 2323;
 
matrix3_x = zeros(1,4);
matrix3_x(1) = 2564; matrix3_x(2) = 2423; matrix3_x(3) = 2431;
matrix3_x(4) = 2431;
 
matrix4_x = zeros(1,3);
matrix4_x(1) = 1885; matrix4_x(2) = 1879; matrix4_x(3) = 1875;
 
% Most of the bugs are probably related to indexing; using (:, i) or (i, :) will probably fix most of the bugs
% Do a check to test how accurate the results are.
 
%{
Still to add:
 
X_CUT = x_cut(index_lower:index_upper);
YY = Y(index_lower:index_upper);
X_CUT2 = X_CUT/(sum(X_CUT)*(YY(2)-YY(1)))
X_CUT3 = X_CUT2/max(th_airy3);
strehl_ratio = max(X_CUT3)/max(th_airy4);
disp(['Strehl Ratio is ',num2str(strehl_ratio)]);
 
%}
 
for i = 1:2
    temp1(:,i) = matrix1(:, matrix1_x(i));
    matrix1_cut(i) = temp1(i)-min(temp1(i));
    matrix1_cut = matrix1_cut/max(matrix1_cut);
    [~, matrix1_max(i)] = max(matrix1_cut(i));
     
    shift = 2*(round(length(matrix1_cut(i))/2)-matrix1_max(i));
    if shift > 0
        matrix1_cut(i) = matrix1_cut(i, 1:end - shift);
    elseif shift < 0
        matrix1_cut(i) = matrix1_cut(i, -shift:end);
    end
     
    y1(i) = 1:length(matrix1_cut(i));
    Y1(i) = linspace(-max(y1(i)/2), max(y1(i))/2, length(y(i)))*pix/mag;
    [~, index1_lower(i)] = min(abs(Y1(i)+1));
    [~, index1_upper(i)] = min(abs(Y1(i)-1));
    YY1(i) = Y1(index1_lower(i):index1_upper(i));
end
 
for i = 1:6
    temp2(:,i) = matrix2(:, matrix2_x(i));
    matrix2_cut(i) = temp2(i)-min(temp2(i));
    matrix2_cut(i) = matrix2_cut(i)/max(matrix2_cut(i));
    [~, matrix2_max(i)] = max(matrix2_cut(i));
     
    shift = 2*(round(length(matrix2_cut(i))/2)-matrix2_max(i));
    if shift > 0
        matrix2_cut(i) = matrix2_cut(i, 1:end - shift);
    elseif shift < 0
        matrix2_cut(i) = matrix2_cut(i, -shift:end);
    end
     
    y2(i) = 1:length(matrix2_cut(i));
    Y2(i) = linspace(-max(y2(i)/2), max(y2(i))/2, length(y2(i)))*pix/mag;
    [~, index2_lower(i)] = min(abs(Y2(i)+1));
    [~, index2_upper(i)] = min(abs(Y2(i)-1));
    YY2 = Y2(index2_lower(i):index2_upper(i));
end
 
for i = 1:4
    temp3(:,i) = matrix3(:, matrix3_x(i));
    matrix3_cut(i) = temp3(i)-min(temp3(i));
    matrix3_cut(i) = matrix3_cut(i)/max(matrix3_cut(i));
    [~, matrix3_max(i)] = max(matrix3_cut(i));
     
    shift = 2*(round(length(matrix3_cut(i))/2)-matrix3_max(i));
    if shift > 0
        matrix3_cut(i) = matrix3_cut(i, 1:end-shift);
    elseif shift < 0
        matrix3_cut(i) = matrix3_cut(i, -shift:end);
    end
     
    y3(i) = 1:length(matrix3_cut(i));
    Y3(i) = linspace(-max(y3(i)/2), max(y3(i))/2, length(y3(i)))*pix/mag;
    [~, index3_lower(i)] = min(abs(Y3(i)+1));
    [~, index3_upper(i)] = min(abs(Y3(i)-1));
    YY3 = Y3(index3_lower(i):index3_upper(i));
end
 
for i = 1:3
    temp4(:, i) = matrix4(:, matrix4_x(i));
    matrix4_cut(i) = temp4(i)-min(temp4(i));
    matrix4_cut(i) = matrix4_cut(i)/max(matrix4_cut(i));
    [~, matrix4_max(i)] = max(matrix4_cut(i));
     
    shift = 2*(round(length(matrix4_cut(i))/2)-matrix4_max(i);
    if shift > 0
        matrix4_cut(i) = matrix4_cut(i, 1:end-shift);
    elseif shift < 0
        matrix4_cut(i) = matrix4_cut(i, -shift:end);
    end
     
    y4(i) = 1:length(matrix4_cut(i));
    Y4(i) = linspace(-max(y4(i)/2), max(y4(i))/2, length(y4(i)))*pix/mag;
    [~, index4_lower(i)] = min(abs(Y4(i)+1));
    [~, index4_upper(i)] = max(abs(Y4(i)-1));
    YY4 = Y4(index4_lower(i):index4_upper(i));
end
