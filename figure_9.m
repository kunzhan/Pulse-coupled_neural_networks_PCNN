%   The Image Enhancement demo code was written by Kun Zhan
%   $Revision: 1.0.0.0 $  $Date: 2016/03/07 $ 16:27:29 $

%   Reference:
%   K Zhan, J Shi, H Wang, Y Xie, Q Li,
%   "Computational Mechanisms of
%   Pulse-Coupled Neural Networks: A Comprehensive Review,"
%   Archives of Computational Methods in Engineering, 2016.

addpath('functions\'); 
addpath('images\')
I = imread('tire.tif');
J = FLM(I);
imshow([I, J])
