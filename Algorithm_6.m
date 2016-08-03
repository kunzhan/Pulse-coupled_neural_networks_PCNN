%   The Image Restoration demo code was written by Kun Zhan, Hongjuan Zhang
%   $Revision: 1.0.0.0 $  $Date: 2008/09/04 $ 22:28:10 $

%   Reference:
%   K Zhan, H Zhang, Y Ma
%   "New spiking cortical model
%   for invariant texture retrieval and image processing," 
%   IEEE Transactions on Neural Networks, 20(12), 1980-1986

I = im2double(imread('cameraman.tif')); 
[r,c] = size(I); rc=r*c;
J = imnoise(I,'gaussian',0,0.001);
%_______________________________________
I_median = medfilt2(J);
PSNR_median = psnr_mse_maxerr(255*I,255*I_median)
I_mean = conv2(J,ones(3)./9,'same');
PSNR_mean = psnr_mse_maxerr(255*I,255*I_mean)
%_______________________________________
U = zeros(r,c); E = U + 1;  Y = U; B = U; T = U;
f = 0.03;       g = 0.99;   gamma = 1;
n = 0;
while sum(sum(B))<rc
    n = n+1; 
    for i = 1:r
        for j = 1:c
            U(i,j) = J(i,j) + f*U(i,j);
            Q = 1./(1+exp(-gamma*(U(i,j)-E(i,j))));
            if Q > 0.5 || E(i,j) < 0.08
                Y(i,j) = 1; B(i,j) = 1; T(i,j) = n; E(i,j) = 100000;
            else               
                Y(i,j) = 0;
            end                        
        end
    end                       
    E(B~=1)=g*E(B~=1);  
end
S = padarray(J,[1 1],'symmetric');
Time_matrix = padarray(T,[1 1],'symmetric');
I_SCM = zeros(r,c);
Delta = 0.02; 
for ii = 2:r+1
    for jj = 2:c+1
        K = Time_matrix(ii-1:ii+1,jj-1:jj+1);
        if isequal(K(1),K(2),K(3),K(4),K(5),K(6),K(7),K(8),K(9))
            I_SCM(ii-1,jj-1) = 1/9*(sum(sum(S(ii-1:ii+1,jj-1:jj+1))));
        else
            tmp = sort(K);
            if tmp(5) == K(5)
                I_SCM(ii-1,jj-1) = S(ii,jj);
            elseif tmp(1) == K(5)
                I_SCM(ii-1,jj-1) = S(ii,jj) - Delta;  
            elseif tmp(9) == K(5)
                I_SCM(ii-1,jj-1) = S(ii,jj) + Delta;  
            else
                kk = medfilt2(S(ii-1:ii+1,jj-1:jj+1));
                I_SCM(ii-1,jj-1) = kk(5);
            end
        end
    end
end
%_______________________________________
PSNR_SCM = psnr_mse_maxerr(255*I,255*I_SCM)