clear all
clc
 
% Y co-ordinates
Strehl_Ratio_blue405_53_H = [ 0.65911 0.65897 0.64445 0.64307 0.64591 0.65144 0.68124];
Strehl_Ratio_blue405_53_V = [ 0.60704 0.63759 0.65140 0.65300 0.63695 0.67240 0.70937];
 
Strehl_Ratio_blue405_54_H = [ 0.59738 0.61642 0.62145 0.60330 0.59177];
Strehl_Ratio_blue405_54_V = [ 0.58162 0.60520 0.60987 0.59455 0.64829];
 
Strehl_Ratio_blue532_H = [ 0.60492 0.60758 0.62095 0.63387 0.57829 0.59376];
Strehl_Ratio_blue532_V = [ 0.60697 0.63687 0.64744 0.61858 0.58880 0.60455];
 
Strehl_Ratio_green2_532_H = [ 0.74045 0.74954 0.73531 0.72730];
Strehl_Ratio_green2_532_V = [ 0.77051 0.74153 0.78042 0.73802];
 
% X co-ordinates
sample_blue_405_53 = [0:6];
sample_blue_405_54 = [0:4];
sample_blue_532 = [0:5];
sample_green2_532 = [0:3];
 
figure
plot( sample_blue_405_53, Strehl_Ratio_B_n_1_7_H, 'r*', sample_blue_405_53, Strehl_Ratio_B_n_1_7_V,  'b*')
legend('Horizontal Cut', 'Vertical Cut')
xlabel('Sample Number')
ylabel('Strehl Ratio')
title('Blue Lens, 405nm, N1.53')
 
figure
plot(sample_blue_405_54, Strehl_Ratio_blue405_54_H, 'r*',  sample_blue_405_54, Strehl_Ratio_blue405_54_V, 'b*')
legend('Horizontal Cut', 'Vertical Cut')
xlabel('Sample Number')
ylabel('Strehl Ratio')
title('Blue Lens, 405nm, N1.54')
 
figure
plot(sample_blue_532, Strehl_Ratio_blue532_H,  'r*', sample_blue_532, Strehl_Ratio_blue532_V,  'b*')
legend('Horizontal Cut', 'Vertical Cut')
xlabel('Sample Number')
ylabel('Strehl Ratio')
title('Blue Lens, 532nm')
 
figure
plot(sample_green_405, Strehl_Ratio_green405_H,  'r*', sample_green_405, Strehl_Ratio_green405_V,  'b*')
legend('Horizontal Cut', 'Vertical Cut')
xlabel('Sample Number')
ylabel('Strehl Ratio')
title('Green Lens, 405nm')
 
figure
plot(sample_green1_532, Strehl_Ratio_green1_532_H,  'r*', sample_green1_532, Strehl_Ratio_green1_532_V,  'b*')
legend('Horizontal Cut', 'Vertical Cut')
xlabel('Sample Number')
ylabel('Strehl Ratio')
title('Green Lens 1, 532nm')
 
figure
plot(sample_green2_532, Strehl_Ratio_green2_532_H,  'r*',  sample_green2_532, Strehl_Ratio_green2_532_V, 'b*')
legend('Horizontal Cut', 'Vertical Cut')
xlabel('Sample Number')
ylabel('Strehl Ratio')
title('Green Lens 2, 532nm')
