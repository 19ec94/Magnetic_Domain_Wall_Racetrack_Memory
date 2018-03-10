clc;
clear variables;

%% inits
params.NSpatial = 1000;
params.NTime = 100;
params.TEnd = 0.02;
params.deltaT = params.TEnd/params.NTime;
params.deltaPos = 1/(params.NSpatial-1);
m = zeros(3,params.NSpatial);
params.omega = 1.;


% init m
m(3,:) = ones(params.NSpatial,1);

% init pos
position = linspace(0,1,params.NSpatial);
y = zeros(1,size(position,2));
z = zeros(1,size(position,2));

%% exact sol
mExact = zeros(3,params.NSpatial);
posTmp = position.^2 .* (1-position).^2;
mExact(1,:) = cos(posTmp)*sin(params.TEnd);
mExact(2,:) = sin(posTmp)*sin(params.TEnd);
mExact(3,:) = cos(params.TEnd);

% plot(position,mExact(1,:))

%% temporal iterations

g = zeros(3,params.NSpatial);
F = calcF(params);
FLocal = zeros(3,params.NSpatial);

n = params.NSpatial;
laplaceDiscret = diag(-2*ones(n,1),0) + diag(ones(n-1,1),1) + diag(ones(n-1,1),-1);
laplaceDiscret = laplaceDiscret/params.deltaPos^2;

I = eye(params.NSpatial);
gTmp = zeros(params.NSpatial);
for idxTime=1:params.NTime
    
    % calc g^n
    for idx=1:3
        g(idx,:) = (I-params.deltaT*laplaceDiscret) \ m(idx,:)';         
    end    
    
    FLocal(:,:) = F(idxTime, :, :);
    
    m(1,:) = m(1,:) + params.omega*(g(2,:).*m(3,:) - g(3,:).*m(2,:)) ...
        + params.deltaT.*FLocal(1, :);
    
    g(1,:) = (I-params.deltaT*laplaceDiscret) \ m(1,:)'; 
    
    m(2,:) = m(2,:) + params.omega*(g(3,:).*m(1,:) - g(1,:).*m(3,:)) ...
        + params.deltaT.*FLocal(2, :);
    
    g(2,:) = (I-params.deltaT*laplaceDiscret) \ m(2,:)';
    
    m(3,:) = m(3,:) + params.omega*(g(1,:).*m(2,:) - g(2,:).*m(1,:)) ...
        + params.deltaT.*FLocal(3, :);
    
end

%% Plots

figure
plot(position, m(1,:))
ylim([0.019955, 0.020005])

figure
plot(position, m(2,:))
ylim([-0.0002, 0.0014])

figure
plot(position, m(3,:))
ylim([0.95, 1.05])