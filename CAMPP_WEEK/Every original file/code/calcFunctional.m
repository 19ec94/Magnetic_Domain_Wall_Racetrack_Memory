n = 1000;
M= zeros(3,n);
a = 0;
b = 1;
step = 1/n;
Ku = 100;
Cex = 1.3e-11;
Ms = 8e5;

Fa(M, Ku) + Fe(M, Cex, Ms, step)

function [ y ] = Fa(M, Ku, Ms)
    sum = 0;
    for i = 1 : size(M,2)
        sum = sum + (M(2,i)^2 + M(3,i)^2);
    end
    y = sum * Ku / Ms^2;

end

function [ y ] = Fe(M, Cex, Ms, step)
    sum = 0;
    for i = 1 : size(M,2)-1
        gradMSquared = (1/step * (M(:,i+1) - M(:,i)))^2;
        sum = sum + gradMSquared;
    end
    y = sum * Cex / Ms^2;
end

function [ y ] = Fs(M, 

    function 
