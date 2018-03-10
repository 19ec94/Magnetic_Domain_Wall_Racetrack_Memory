function [ res ] = FLL( m, q, eps, he, stepsize )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

n=size(m,2);

deltax = 1/n;
%x = 0:deltax:1;

%anisotropy energy
Fa=0;
for i=1:n
    Fa=Fa + m(2,i)^2 + m(3,i)^2;
end

Fa = q * Fa

%Exchange Energy

Fe=0;

for i=2:n-1
    gradm = (m(:,i+1) - m(:,i-1)) / (2 * deltax);
    Fe = Fe + gradm' * gradm;
end

Fe = eps * Fe

%Stray Field Energy

Fs = 0;
prefDir = 1;
for i = 1:n
    x = i*deltax;
    gradu = 1/(2 * stepsize) * (Uconv(x + stepsize, m, deltax) - Uconv(x - stepsize, m, deltax));
    Fs = Fs + gradu * m(prefDir,i);
end

Fs = 1/2 * Fs

%Zeeman Energy
Fz = 0;

for i = 1:n
    Fz = Fz+he' * m(:,i);
end

Fz = -1 * Fz

res = Fa + Fe + Fs + Fz;
end

