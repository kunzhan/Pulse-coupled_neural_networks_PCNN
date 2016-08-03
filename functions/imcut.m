function NewIm = imcut(Image)
%   The code was written by Kun Zhan
%   $Revision: 1.0.0.0 $  $Date: 2008/08/30 $ 10:10:18 $

%   Reference:
%   K Zhan, H Zhang, Y Ma
%   "New spiking cortical model
%   for invariant texture retrieval and image processing," 
%   IEEE Transactions on Neural Networks, 20 (12), 1980-1986

[r,c] = size(Image);
cc = floor(c/2);
cr = floor(r/2);
NewIm = Image( (cr - 63):(cr + 64),(cc - 63):(cc + 64) );