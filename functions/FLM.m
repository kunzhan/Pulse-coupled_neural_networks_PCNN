function Rep1gs = FLM(I)
%   The FLM demo was written by Kun Zhan, Jicai Teng, Jinhui Shi
%   $Revision: 1.0.0.0 $  $Date: 2014/11/21 $ 16:58:08 $

%   Reference:
%   K Zhan, J Teng, J Shi, Q Li, M Wang, 
%   "Feature-linking model for image enhancement," 
%   Neural Computation, 28(6), 1072-1100, 2016.

funInverse = @(x) max(max(x)) + 1 - x;
funNormalize = @(x) ( x-min(min(x)))/( max(max(x))-min(min(x)) + eps);
[r,c] = size(I);  rc = r*c;
S = funNormalize(double(I)) + 1/255;
W=[0.7 1 0.7; 1  0  1 ; 0.7 1 0.7;];
Y=zeros(r,c);   U = Y;  Time = Y; sumY = 0;  n = 0;
%_____________________Theta_0______________
Lap = fspecial('laplacian',0.2);
Theta = 1 + imfilter(S,Lap,'symmetric');
%_____________________f____________________
f = 0.75 * exp(-(S).^2 / 0.16) + 0.05;
G = fspecial('gaussian',7,1);
f = imfilter(f,G,'symmetric');
%___________________Parameters____________
h = 2e10; d = 2; g = 0.9811; alpha = 0.01; beta = 0.03;
while sumY < rc
    n = n + 1;
    K = conv2(Y,W,'same');
    Wave = alpha * K + beta .* S .* (K - d);
    U = f.*U + S + Wave;
    Theta = g*Theta + h.*Y;
    Y = double(U > Theta);
    Time = Time + n .* Y;
    sumY = sumY + sum(Y(:));
end
Rep = funInverse(Time);
Rep = funNormalize(Rep);
Rep = uint8(Rep * 255);
Rep1gs = GrayStretch(Rep,0.98);
