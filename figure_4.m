%   The PCNN wave demo code was written by Kun Zhan
%   $Revision: 1.0.0.0 $  $Date: 2016/03/28 $ 13:22:02 $

%   Reference:
%   K Zhan, J Shi, H Wang, Y Xie, Q Li, 
%   "Computational Mechanisms of 
%   Pulse-Coupled Neural Networks: A Comprehensive Review," 
%   Archives of Computational Methods in Engineering, 2016.

close all;clc,clear
S = zeros(11);	Yv = S;
S(2:10,2:10) = [2 3 3 3 1 2 3 0 1;
                1 2 1 3 0 0 3 1 1;
                0 1 1 3 3 3 3 0 0;
                0 1 0 3 0 1 2 0 0;
                0 1 0 3 3 0 1 0 0;
                0 2 2 1 3 3 1 1 1;
                0 1 1 0 1 3 3 0 0;
                0 1 0 1 0 1 3 3 3;
                0 1 0 2 0 1 2 0 3;];
Yv(6,6) = 1;	Yu = Yv;
W = [1 1 1; 
     1 1 1; 
     1 1 1];
Theta = 3;
N = 5;
for n = 1:N
    U =  4.*conv2(Yu,W,'same');
    V =  S.*(1+0.1*conv2(Yv,W,'same'));
    Yu = double(U > Theta); 
    Yv = double(V > Theta);
    subplot(2,N,n),imshow(Yu,[],'InitialMagnification','fit');
    subplot(2,N,n+N),imshow(Yv,[],'InitialMagnification','fit');
end