%% Initialize variables
clc
clear

% Constants
Ku = 100;           % [J/m^3]
Cex = 1.3e-11;      % [J/m]
Ms = 8e5;           % [A/m]
gamma = 1.76e11;    % [(Ts)^-1]
alpha = 1e-2;       % [-]
mu0 = 4*pi*10^-7;   % [N/A^2]
L = 1e-6;              % [m]
He = [0;Ms/2;0];             % For now
stepsize = 0.0000001;

% dimensionlessness
q = 2*Ku/(mu0*Ms*Ms);               % [-]
epsilon = 2*Cex/(mu0*Ms*Ms*L*L);    % [-]
he = He ./ Ms;

% Domain variables
deltat = 2.5e-13;   % [s]           
nx = 256;
deltax = 1/nx;
x = 0:deltax:1;

times = 10;
mValue = Inf;
for k = 1 : times
    M = zeros(3,nx+1);
    for l = 1 : nx + 1
        
        M(:,l) = [0; sign(rand - 0.5); 0];
    end
    res = FLL( M, q, eps, he, stepsize );
    if res <= mValue
        mValue = res;
        mMin = M;
    end
end
mValue