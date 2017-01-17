%   The Image Histogram demo code was written by Kun Zhan, Jinhui Shi, Qiaoqiao Li
%   $Revision: 1.0.0.0 $  $Date: 2016/03/30 $ 20:11:35 $

%   Reference:
%   K Zhan, J Shi, H Wang, Y Xie, Q Li,
%   "Computational Mechanisms of
%   Pulse-Coupled Neural Networks: A Comprehensive Review,"
%   Archives of Computational Methods in Engineering, 2016.

S = imread('images\lena.jpg');
[r,c] = size(S);
E = 254*ones(r,c);
Y = zeros(r,c);
H = zeros(256,1);
h = double(max(S(:))) + 1;
for i = 1:256
    Y = double(S > E);
    H(257-i) = sum(Y(:));
    E = E - 1 + h*Y;
end
sum(abs(H - h));
figure(1), 
H1 = imhist(S);
plot((0:255),H(1:256),'rx-',(0:255),H1(1:256),'b.-');    
h = legend('PCNN histogram','Standard histogram',1);
set(h,'Interpreter','none')
xlim([0,255])
