function F = calcF(params)
%CALCF Summary of this function goes here
%   Detailed explanation goes here

    F=zeros(params.NTime, 3, params.NSpatial);
    
%     syms x t;
%     mExact(x,t) = [ cos(x*x*(1-x)^2)*sin(t); ...
%         sin(x*x*(1-x)^2)*sin(t); ...
%         cos(t) ];
    mExact = @(x,t) [ cos(x*x*(1-x)^2)*sin(t); ...
        sin(x*x*(1-x)^2)*sin(t); ...
        cos(t) ];
    mExactXX = @(x,t) (mExact(x+params.deltaPos,t) - 2.*mExact(x,t) + ...
        mExact(x-params.deltaPos,t))./(params.deltaPos*params.deltaPos);
    mExactT = @(x,t) (mExact(x,t+params.deltaT) - ...
        mExact(x,t))./params.deltaT;
%     mExactT = @(x,t) [ cos(x*x*(1-x)^2)*cos(t); ...
%         sin(x*x*(1-x)^2)*cos(t); ...
%         -sin(t) ];

    for idxTime=1:params.NTime
        for idxPos=1:params.NSpatial
            
            x = (idxPos-1)*params.deltaPos;
            t = (idxTime-1)*params.deltaT;
            
            F(idxTime, :, idxPos) = mExactT(x,t) + cross(mExact(x,t),mExactXX(x,t));
            
        end
    end
end