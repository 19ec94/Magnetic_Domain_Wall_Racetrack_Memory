function [ U ] = solveU( M, param )
%SOLVEU Summary of this function goes here
%   Detailed explanation goes here
    n = param.nx+1;
    
    divM = zeros(1,n);
    
    laplaceDiscrete = diag(-2*ones(n,1),0) + diag(ones(n-1,1),1) + diag(ones(n-1,1),-1);
    laplaceDiscrete = laplaceDiscrete/param.deltax^2;

    divM(1) = ones(3,1)*(M(:,2)-M(:,1))/param.deltax;
    for i = 2:n-1
        divM(i) = ones(3,1)*(M(:,i+1) - M(:,i-1))/(2*param.deltax);
    end
    divM(n) = ones(3,1)*(M(:,2)-M(:,1))/param.deltax;
    
    U = laplaceDiscrete\divM;
    
end

