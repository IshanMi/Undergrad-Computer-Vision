tic;
% All values of physical dimensions are in microns
% =========================================================================
% Defining Variables
 
PARTITION=1;                                                % current piece                                                              
OUTOF=1;                                           % total number of pieces                                                                   
 
radius = 125;                                              % radius of Lens
NA = 1.1;% = sin(atan(D/(2*f)))                % numerical aperture of lens
n = 1.5396;                                   % soda glass refractive index
f = radius/tan(asin(NA/n));        % definition of focus for immersion lens
Lamb = 0.405/n;                                           % design wavelength
 
Theta=0;                                  %Angle with x-direction in degree
Phi=0;                                    %Angle with z-direction in degree
xf=f*cosd(Theta)*sind(Phi);                              % x-coord of focus
yf=f*sind(Theta)*sind(Phi);                              % y-coord of focus
zf=f*cosd(Phi);                                          % z-coord of focus
 
% Nanofin Dimensions
L = 0.120-0.02;                                         % length of nanofin
W = 0.060-0.02;                                          % width of nanofin 
 
unit = 0.150;                                                   % unit cell
% =========================================================================
fitnum = floor((radius-unit/2)/unit); 
% fitnum is the number of unit cells that can fit into radius-(unitcell/2); 
NUM = 2*fitnum+1; 
% As such, NUM is the # of unit cells that fit across the diameter of the lens
 
matrixofpositions = zeros(NUM,NUM,2);
xvec = -fitnum*unit:unit:fitnum*unit; % x positions on the horizontal
yvec = -fitnum*unit:unit:fitnum*unit; % y positions on the vertical
 
[matrixofpositions(:,:,1),matrixofpositions(:,:,2)] = meshgrid(xvec,yvec);
% create two 2D matrices each only having x positions and y positions,
% respectively
 
NaN_matrix = makecircle(radius,matrixofpositions); % carve out circle
 
matrixofpositions(:,:,1) = matrixofpositions(:,:,1) + NaN_matrix;
matrixofpositions(:,:,2) = matrixofpositions(:,:,2) + NaN_matrix;
% These two lines change all non-NaNs with the numbers in the
% corresponding matrixofpositions matrix
 
% =========================================================================
% Spherical Phase Distribution of Lens
 
% Lens
angles = zeros(NUM,NUM);
for i = 1:NUM
     
    angles(i,:) = 2*pi-2*pi/Lamb*(sqrt((...
        matrixofpositions(i,:,1)-xf).^2 + ...
        (matrixofpositions(i,:,2)-yf).^2 + (0 - zf).^2) - f);%-atan2(matrixofpositions(i,:,2),matrixofpositions(i,:,1));
end
 
 
% Spiral
matrix1 = -atan2(matrixofpositions(:,:,2),matrixofpositions(:,:,1));
    
        for m = 1 : size(matrix1,1);%length(test);
            for n = 1:length(matrix1);
                if matrix1(m,n) < 0
                    matrix2(m,n) = matrix1(m,n) + 2*pi;
                elseif matrix1(m,n) >=0
                    matrix2(m,n) = matrix1(m,n);
                end
            end
        end
    donut=matrix2;
     
    matrix_final = angles + matrix2;
    angles = matrix_final./2;
%angles = angles./2; % rotation angle of nanofins to produce desired phase
% =========================================================================
 
% Generate Initial Print Matrix
PrintMatrix1 = NaN*ones(4,2,NUM,NUM); % Why these dimensions?
 
L_matrix=[L/2 ; -L/2 ; -L/2 ; L/2 ]; % where L is the Length of Nanofin
W_matrix=[W/2 ;  W/2 ; -W/2 ; -W/2]; % where W is the Width of Nanofin
 
for i = (PARTITION-1)*ceil(NUM/OUTOF)+ 1 : min(PARTITION*ceil(NUM/OUTOF),NUM)
    for j=1:NUM
        phi_B=angles(i,j);
        cosphi_B=cos(phi_B);
        sinphi_B=sin(phi_B);
        PrintMatrix1(:,:,i,j)=[L_matrix*cosphi_B+W_matrix*sinphi_B+matrixofpositions(i,j,1),L_matrix*(-sinphi_B)+W_matrix*cosphi_B+matrixofpositions(i,j,2)];
        % this pinpoints the vertices of the nanofin after being
        % transformed by the rotation matrix
    end
end
 
% ++++++++++++++++++++++ CROSS STUFF ++++++++++++++++++++++++++++++++++++++
% This produces alignment marks
% Corner cross dimensions
L_cross = 50; % length of cross
W_cross = 0.3; % width of cross
D = 50;
cross_positions = [-D-radius, -D-radius; 
    D+radius, -D-radius;  % [a,c ; b,d ; a,d ; b,c] 
    -D-radius, D+radius;
    D+radius, D+radius]; 
L_cross_matrix1 = [L_cross/2 ; -L_cross/2 ; -L_cross/2 ;  L_cross/2];
W_cross_matrix1 = [W_cross/2 ;  W_cross/2 ; -W_cross/2 ; -W_cross/2];
L_cross_matrix2 = [W_cross/2 ; -W_cross/2 ; -W_cross/2 ;  W_cross/2];
W_cross_matrix2 = [L_cross/2 ;  L_cross/2 ; -L_cross/2 ; -L_cross/2];
 
% Calculate (x,y) coord at each corner of the cross for each cross
Print_cross = zeros(4,2,8);
for i = 1:4
    Print_cross(:,:,i)=[L_cross_matrix1+cross_positions(i,1),W_cross_matrix1+cross_positions(i,2)];
    Print_cross(:,:,i+4)=[L_cross_matrix2+cross_positions(i,1),W_cross_matrix2+cross_positions(i,2)];
end
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 
% Name of DXF file
name=strcat('TiO2_Immerse_',num2str(Lamb*1e3),'nm_D_',num2str(round(radius*2)),...
    'um_f_',num2str(round(f)),'um_L_',num2str(L*1e3),'nm_W_',num2str(W*1e3),'nm_',...
    'U_',num2str(unit*1e3),'nm_',num2str(PARTITION),'_OUT_OF_',num2str(OUTOF));
 
[fid,err] = DXF_start1(strcat(name,'.dxf'),1); % initiate file
 
global unitscale
global dxfhandle
 
PrintMatrix2 = zeros(4,2,0); % Final print matrix for writing
 
% Add in bottom row of crosses
if PARTITION == 1
    PrintMatrix2(:,:,1:2) = Print_cross(:,:,[1,5]);
    PrintMatrix2(:,:,3:4) = Print_cross(:,:,[2,6]);     
end
 
% Remove NaN values from writing
for i=(PARTITION-1)*ceil(size(angles,1)/OUTOF)+1:min(PARTITION*ceil(size(angles,1)/OUTOF),size(angles,1))
    for j = 1:size(angles,1)
        if ~isnan(PrintMatrix1(:,:,i,j))
            PrintMatrix2(:,:,size(PrintMatrix2,3)+1)=PrintMatrix1(:,:,i,j);
        end
    end
end
 
% Add in top row of crosses
if PARTITION/OUTOF == 1
    PrintMatrix2(:,:,size(PrintMatrix2,3)+1:size(PrintMatrix2,3)+2) = Print_cross(:,:,[3,7]);
    PrintMatrix2(:,:,size(PrintMatrix2,3)+1:size(PrintMatrix2,3)+2) = Print_cross(:,:,[4,8]);
end
 
% Writing Entities into DXF file
for ii = 1:size(PrintMatrix2,3);
    fprintf(fid,'0\nLWPOLYLINE\n5\n%s\n100\nAcDbEntity\n8\nDEFAULT\n6\nCONTINUOUS\n62\n5\n100\nAcDbPolyline\n90\n5\n10\n%1.8g\n20\n%1.8g\n30\n0.0\n10\n%1.8g\n20\n%1.8g\n30\n0.0\n10\n%1.8g\n20\n%1.8g\n30\n0.0\n10\n%1.8g\n20\n%1.8g\n30\n0.0\n10\n%1.8g\n20\n%1.8g\n30\n0.0\n',upper(sprintf('%6x',dxfhandle)),[PrintMatrix2(:,:,ii);PrintMatrix2(1,:,ii)]'*unitscale);  % x coord code
    % The POLYLINE entity defines a structure by specifying its vertices.
    % In order of the points, lines are connected to create a polygon.
     
    dxfhandle=dxfhandle+1;
    if(dxfhandle==55)
        dxfhandle=dxfhandle+1;
    end
end
 
DXF_end(fid); % end writing                                                         
 
toc
