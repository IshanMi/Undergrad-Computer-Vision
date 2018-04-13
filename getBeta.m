clear all;
 
%% Declarations of constant and parameters
nm=1e-9;
 
file_name = '/Users/ishanmishra/Dropbox (MIT)/Capasso Group SEAS/Simulations/Dielectric Circular Waveguide/Analytical solution/TiO2.txt';
 
%% Reading TiO2 data from file
fileID = fopen(file_name,'r');
reading_matrix = fscanf(fileID, '%f');
 
%% Sorting the data from file
for i=1:length(reading_matrix)
    if (mod(i,3)==1)
        wlexp((i-1)/3+1,1)=reading_matrix(i)*nm;
    end
    if (mod(i,3)==2)
        index(((i-2)/3+1),1)=reading_matrix(i);
    end
    if (mod(i,3)==0)
        index(i/3,2)=reading_matrix(i);
    end
end
 
 
%%% Defining range of computation
a_vec = [80]*nm;
wl_vec = [532]*nm;
 
for a_ind = 1 : length(a_vec)
    for wl_ind = 1 : length(wl_vec)
        a = a_vec(a_ind);
        wl = wl_vec(wl_ind);
        wli = min(find(wlexp>=wl));
        n1 = index(wli);
        n2 = 1 ;
         
        eps0 = 8.85418782*10^(-12);
        eps1 = eps0*n1^2;
        eps2 = eps0*n2^2;
         
        n = 1;
        k0 = 2*pi/wl;
        hmax = k0*sqrt(n1^2 - n2^2);
         
        c = 299792458;
        mu0 = 4*pi*10^(-7);
        w0 = c*k0;
         
        syms x;
        y = sqrt(a.^2*k0^2*(n1^2-n2^2)-x.^2);
        beta = sqrt(k0^2*n1^2-(x/a).^2);
         
        LEFT1 = (besselj(n-1,x)-besselj(n+1,x))./(2*x.*besselj(n,x)) -...
            (besselk(n-1,y)+besselk(n+1,y))./(2*x.*besselk(n,y));
        LEFT2 = n1^2*(besselj(n-1,x)-besselj(n+1,x))./(2*x.*besselj(n,x)) -...,
            n2^2*(besselk(n-1,y)+besselk(n+1,y))./(2*x.*besselk(n,y));
        RIGHT = n^2*((1./x).^2+(1./y).^2).^2.*(beta/k0).^2;
         
        S(a_ind,wl_ind) = vpasolve(LEFT1.*LEFT2 - RIGHT == 0, x)
    end
end
