function M= initM( param )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here


    x = linspace(0,1,param.nx+1);
    x0 = 0.5;
    A = -2/pi;
    sigma = 1/80;

    switch( param.flagInit )
        case 'Random'
            M = rand(3, param.nx+1);
            M(1,:) = zeros(1,param.nx+1);

            for i = 1:param.nx+1
                M(:,i) = M(:,i)/norm(M(:,i));
            end
            M(:,1) = [0,1,0];
            M(:,end) = [0,-1,0];
        case 'Unit'
            M = zeros(3,param.nx+1);
            M(2,:) = -ones(1, param.nx+1);
            half = floor((param.nx+1)*0.5);
            M(2,floor(1:half)) = ones(1,half);
            
        case 'Bloch'
            M = zeros(3,param.nx+1);
            M(2,:) = A*atan( (x-x0)/sigma );
            M(3,:) = sqrt(1- A^2*atan( (x-x0)/sigma ).^2);
            M(1,:) = 1e-2*rand(1, param.nx+1);
            for i = 1:param.nx+1
                M(:,i) = M(:,i)/norm(M(:,i));
            end
            M(:,1) = [0,1,0];
            M(:,end) = [0,-1,0];
            
        case 'Neel'
            M = zeros(3,param.nx+1);
            M(2,:) = A*atan( (x-x0)/sigma );
            M(1,:) = sqrt(1- A^2*atan( (x-x0)/sigma ).^2 );
            M(3,:) = 1e-2*rand(1, param.nx+1);
            for i = 1:param.nx+1
                M(:,i) = M(:,i)/norm(M(:,i));
            end
            M(:,1) = [0,1,0];
            M(:,end) = [0,-1,0];
            
        otherwise
            M = zeros(3,param.nx+1);
            M(2,:) = A*atan( (x-x0)/sigma );
            M(1,:) = sqrt(1- A^2*atan( (x-x0)/sigma ).^2);
            M(:,1) = [0,1,0];
            M(:,end) = [0,-1,0];
    end
%     M = rand(3, param.nx+1);
%     
%     for i = 1:param.nx+1
%         M(:,i) = M(:,i)/norm(M(:,i));
%     end
%     M(2,:) = ones(1,param.nx+1);
%     M(:,25) = [0,0,0];

end

