%% Initialize variables
clc
clear

% Constants
param.Ku = 100;           % [J/m^3]
param.Cex = 1.3e-11;      % [J/m]
param.Ms = 8e5;           % [A/m]
param.gamma = 1.76e11;    % [(Ts)^-1]
param.alpha = 1e-2;       % [-]
param.mu0 = 4*pi*10^-7;   % [N/A^2]
param.L = 1e-6;              % [m]
param.He = [0;0.5;0.];             % For now
param.domaindir = 1;      % Domain in x direction
param.prefdir = 2;        % Preferred direction for material
param.bounddir = 2;

% internal flags
param.flagAnisotropy = false;
param.flagExchange = true;
param.flagStray = false;
param.flagZeeman = false;

param.flagInit = 'Neel';

param.q = 2*param.Ku/(param.mu0*param.Ms*param.Ms);               % [-]
param.q = 1;               % [-]
param.epsilon = 2*param.Cex/(param.mu0*param.Ms*param.Ms*param.L*param.L);    % [-]
param.epsilon = 1e-3;    % [-]

% Domain variables
param.delta = 1e-2;        % Scaled film thickness
param.deltat = 2.5e-13;   % [s]       
param.deltat = 2.5e-0;   % [s]       
param.nx = 50;
param.deltax = 1/param.nx;
x = 0:param.deltax:1;
param.x = x;

gU = zeros(3,param.nx+1);
M = initM(param);

visual(M,param,'Initial magnetization');

param.timeLoops = 500;
for timeidx=1:param.timeLoops   
    percentage = timeidx/param.timeLoops * 100;
    if mod(percentage,10)==0
        disp(['time runs: ' num2str(percentage) '%']);
    end
    %mcopy = M;
    if(param.flagStray)
        gU = strayField(M,param);
    end
    for i=2:param.nx
        if i == 2 || i == param.nx
            subM = M(:,i-1:i+1);
        else
            subM = M(:,i-2:i+2);
        end
        M(:,i) = M(:,i) + param.deltat*h( subM, gU(:,i), param );
        M(:,i) = M(:,i)/norm(M(:,i));
    end
    %M = mcopy;
    %visual(M)
end

%% Plotting

% figure
% plot(x, M(1,:))
% 
% figure
% plot(x, M(2,:))
% 
% figure
% plot(x, M(3,:))

myTitle = ['magnetization after ' num2str(param.timeLoops) ' runs'];
visual(M,param,myTitle);
