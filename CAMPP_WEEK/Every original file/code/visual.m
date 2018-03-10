function [  ] = visual( M, param, titleText )
%   visual plots the spins in a 3d Space
%M:----------------Matrix to be visualised
%param:------------parameter struct
%                   if you leave this and all following out, the x-axis is equal to the matrix index
%anzahl_pfeile:----how many arrows shall be shown
%                   if you want to visualise all of the arrows this
%                   argument can be left out

if((nargin<=2)&&(nargin>0))
    N=size(M,2);
    figure
    for i=1:N
        p0 = [i-1;0;0];
        p1 = p0+M(:,i);

        vectarrow(p0,p1, true)
        hold on
    end
    %plot racetrack
    p0=[0 0 0];
    p1=[N-1 0 0];
    vectarrow(p0,p1, false)
    
    
elseif(nargin==3)
    N=param.nx;
    deltax=param.deltax;
    figure
    for i=1:N+1
        p0 = [(i-1)*(deltax);0;0];
        p1 = p0+M(:,i);

        vectarrow(p0,p1, true)
        hold on
    end
    %plot racetrack
    p0=[0 0 0];
    p1=[1 0 0];
    vectarrow(p0,p1, false)
    
    
% elseif(nargin>=3)
%     N=param.nx;
%     deltax=param.deltax;
%     if((anzahl_pfeile==0)==false)
%         
%     
%     anzahl_pfeile=anzahl_pfeile-1;
%     
%     step=round(N/anzahl_pfeile);
%     figure
%     for i=1:step:N
%             p0 = [(i-1)*(deltax);0;0];
%             p1 = p0+M(:,i);
% 
%             vectarrow(p0,p1, true)
%             hold on
%             counter=i;
%         
%     end
%     
%     p0 = [1;0;0];
%     p1 = p0+M(:,i);
% 
%     vectarrow(p0,p1, true)
%     hold on
%     end
%     %plot racetrack
%     p0=[0 0 0];
%     p1=[1 0 0];
%     vectarrow(p0,p1, false)
%     if nargin >=4
%         title(titleText);
%     end
end

dim = [.7 .1 .3 .3];
% str = 'Straight Line Plot from 1 to 10';
strAnisotropy='Anisotropy ';
strExchange='Exchange ';
strStray='Stray ';
strZeeman='Zeeman ';


if(param.flagAnisotropy)
    strAnisotropy=[strAnisotropy, '1'];
else
    strAnisotropy=[strAnisotropy, '0'];

end

if(param.flagExchange)
    strExchange=[strExchange, '1'];
else
    strExchange=[strExchange, '0'];    
end

if(param.flagStray)
    strStray=[strStray, '1'];
else
    strStray=[strStray, '0'];
end

if(param.flagZeeman)
    strZeeman=[strZeeman, '1'];
else
    strZeeman=[strZeeman, '0'];
end

str={strAnisotropy,strExchange,strStray,strZeeman};

%a=annotation('textbox',dim,'String',str);
%a.Color = 'red';
%a.FontSize = 14;
%title(titleText);
set(findall(gca, 'Type', 'Line'),'LineWidth',4);
set(gca,'linewidth',4);
xlabel('X','FontSize',24,'FontWeight','bold');
ylabel('Y','FontSize',24,'FontWeight','bold');
zlabel('Z','FontSize',24,'FontWeight','bold');

end

%     str=[str, 'Anisotropy \n'];
%     strcat(str, 'Anisotropy');







