function [ hi ] = h( M, gradU, param )
%h Landau-Lifshitz energy term to be minimized
    
    I = eye(3);
    I(param.prefdir,param.prefdir) = 0;
    hi = 0;
    
    % anisotropy
    if param.flagAnisotropy
        anisotropy = -param.q*(I*M(:,2));
        hi = hi + anisotropy;
    end
    
    % exchange 
    if param.flagExchange
        exchange =  param.epsilon*lapl(M, param);
        hi = hi + exchange;
    end
    
    % stray
    if param.flagStray
        stray = - gradU;
        hi = hi + stray;
    end
    
    % zeeman
    if param.flagZeeman
        extField = param.He;
        hi = hi + extField;
    end

    %[norm(anisotropy), norm(exchange), norm(stray), norm(extField)]
end

function [ val ] = lapl( M, param )
    if(size(M,2) == 5)
        val = (-M(:,5) + 16*M(:,4) - 30*M(:,3) + 16*M(:,2) - M(:,1))/...
              (12*param.deltax^2);
        return
    end
    
    val = (M(:,3) + M(:,1) - 2*M(:,2))/(param.deltax^2);
    
end