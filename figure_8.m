%   The Feature Extraction demo code was written by Kun Zhan, Jinhui Shi
%   $Revision: 1.0.0.0 $  $Date: 2016/04/11 $ 21:21:04 $

%   Reference:
%   K Zhan, J Shi, H Wang, Y Xie, Q Li,
%   "Computational Mechanisms of
%   Pulse-Coupled Neural Networks: A Comprehensive Review,"
%   Archives of Computational Methods in Engineering, 2016.

clear,close all,
addpath('functions\'); addpath('images\')
x = imread('D12.gif');
figure, 
for sc =1:2
    xs = imresize(x,0.2*sc+0.6); 
    for rt = 1:3
        xr = imrotate(xs,rt*30-30,'bilinear','crop');
        xo = imcut(xr); subplot(6, 3, 3*rt+9*(sc-1)-2), imshow(xo)
        h = imhist(xo); subplot(6, 3, 3*rt+9*(sc-1)-1), plot(h), xlim([0, 256])
        set(gca,'xtick',[],'xticklabel',[]); set(gca,'ytick',[],'yticklabel',[]);
        ts = SCM(xo);  subplot(6, 3, 3*rt+9*(sc-1)), plot(ts), ylim([0, 5000])
        set(gca,'xtick',[],'xticklabel',[]); set(gca,'ytick',[],'yticklabel',[]);
    end
end