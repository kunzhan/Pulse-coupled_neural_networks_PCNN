%   The PCNN 1-D demo code was written by Kun Zhan
%   $Revision: 1.0.0.0 $  $Date: 2016/03/25 $ 20:25:48 $

%   Reference:
%   K Zhan, J Shi, H Wang, Y Xie, Q Li, 
%   "Computational Mechanisms of 
%   Pulse-Coupled Neural Networks: A Comprehensive Review," 
%   Archives of Computational Methods in Engineering, 2016.

clear
T = 40;
s = [0.5 0.35 0.5 0.8 0.63 0.5 0.99];
[~, n] = size(s);
Y = zeros(T+1,n); F = Y; L = F; E = F + 1; U = F;
for t = 1:T;
    K = conv(Y(t,:),[0.707 1 0.707],'same');
    F(t+1,:) = exp(-0.2).*F(t,:) +  0.1*K + s;
    L(t+1,:) = exp(-0.5).*L(t,:) + 0.2.*K;
    U(t+1,:) = F(t+1,:).*(1+0.5*L(t+1,:));
    E(t+1,:) = exp(-0.2).*E(t,:) + 6.*Y(t,:);
    Y(t+1,:) = double(U(t+1,:)>E(t+1,:));
end
t = [0:1:T];
c = (n+1)./2;
figure(1)
plot(t,E(:,c),'k-d',...
     t,U(:,c),'b-s',...
     t,F(:,c),'g*-',...
     t,L(:,c),'m+-')

axis square, axis([0 40 0 15])
h = legend('$\Theta_{ij}(n)$','$U_{ij}(n)$',...
    '$F_{ij}(n)$','$L_{ij}(n)$',1);
set(h,'Interpreter','latex')
title('$f=0.8,g=0.8,\Theta_{ij}(0)=1, U_{ij}(0)=0,\forall i,j$','Interpreter','latex')
xlabel('Iterative time \it{n}')
figure(2),
stem(t,Y(:,c))
axis([0 40 0 1.2])