function [ sF ] = strayField( M, param )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    sF = zeros(3, param.nx+1);

    mfunc1 = griddedInterpolant(param.x, M(1,:));
    mfunc2 = griddedInterpolant(param.x, M(2,:));
    mfunc3 = griddedInterpolant(param.x, M(3,:));

    parfor i = 1:param.nx+1
        y = (i-1)*param.deltax;
        sF(:,i) = [quadgk(@(x) gammaDelta(x-y, param).*mfunc1(x), 0, 1);...
                0;...
                quadgk(@(x) gammaDelta(x-y, param).*mfunc3(x), 0, 1)];
    end

    sF(1,:) = M(1,:) - sF(1,:);

end

function [ gD ] = gammaDelta( x, param )

    gD = log(1+(4*param.delta^2)./x.^2)/(4*pi*param.delta);

end