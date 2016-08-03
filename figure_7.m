%   The Image Segmentation demo code was written by Kun Zhan, Jinhui Shi, Haibo Wang
%   $Revision: 1.0.0.0 $  $Date: 2016/04/06 $ 11:05:38 $

%   Reference:
%   K Zhan, J Shi, H Wang, Y Xie, Q Li,
%   "Computational Mechanisms of
%   Pulse-Coupled Neural Networks: A Comprehensive Review," 
%   Archives of Computational Methods in Engineering, 2016.

close all; clear,figure
I = double(ones(256, 256))*230;
I(65:192, 65:192) = 205;
S = I;

S(:, 128:256) = S(:, 128:256)*0.5;
subplot(1,2,1), imshow(uint8(S))
%____________________________________
[r, c] = size(S);
Y = zeros(r,c); T = Y;
W = fspecial('gaussian',7,1);
F = S;
beta = 2;
Th = 255*ones(r,c);
dT = 1;
Vt = 400;
fire_num = 0;
n = 0;
while fire_num < r*c
    n = n + 1;
    L = imfilter(Y,W,'symmetric');
    Th = Th - dT + Vt*Y;
    fire = 1;
    while fire == 1
        Q = Y;
        U = F.*(1 + beta*L);
        Y = double(U > Th);
        if isequal(Q,Y);
            fire = 0;
        else
            L = imfilter(Y,W,'symmetric');
        end
    end
	T = T + n.*Y;
    fire_num = fire_num + sum(sum(Y));    
end
%____________________________________
T = 256 - T;
subplot(1,2,2), imshow(uint8(T))
% Io = S./T.*0.9; figure, imshow(uint8([I 255*Io]))