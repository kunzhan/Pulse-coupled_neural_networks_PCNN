function TS = SCM(I)
%   The SCM demo code was written by Kun Zhan
%   $Revision: 1.0.0.0 $  $Date: 2009/04/03 $ 19:26:48 $

%   Reference:
%   K Zhan, H Zhang, Y Ma
%   "New spiking cortical model
%   for invariant texture retrieval and image processing," 
%   IEEE Transactions on Neural Networks, 20(12), 1980-1986

[m,n] = size(I);
S = im2double(I);

W = [0.1091 0.1409 0.1091;
     0.1409   0    0.1409;
     0.1091 0.1409 0.1091];
%________________
Y = zeros(m,n); U = Y; E = Y + 1;
%________________
k = 40;
TS = zeros(1, k);
for t = 1 : k
    U = 0.2.*U + S.*conv2(Y,W,'same') + S;
    E = 0.9*E + 20.*Y;
    X = 1./(1+exp(E - U));
    Y = double(X > 0.5);
    TS(t) = sum(sum(Y));
end