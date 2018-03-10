clear
clc
close all
% Domain variables
param.delta = 1e-1;        % Scaled film thickness
param.deltat = 2.5e-13;   % [s]           
param.nx = 10;
param.deltax = 1/param.nx;
x = 0:param.deltax:1;
param.x = x;

% internal flags
param.flagAnisotropy = true;
param.flagExchange = true;
param.flagStray = false;
param.flagZeeman = false;

param.flagInitRandom = false;


for l = 1 : param.nx+1
        vec = randn(3,1);
        M(:,l) = vec ./ norm(vec);
end
 M(:,1)=[0 1 0];
 M(:,param.nx+1)=[0 1 0];
 
 visual(M, param, 'hallo');
axis equal