function [Y] = TrackFcn()
Y = [];
t=0:1:2000;
array2 = sin(t./30);
init = array2;
%axes(handles.maxes1); %make ax1 the current axes
    imaqreset;
%create color and depth kinect videoinput objects
colorVid = videoinput('kinect', 1);
preview(colorVid);
depthVid = videoinput('kinect', 2);
triggerconfig (depthVid,'manual');
%triggerconfig (colorVid,'immediate');
framesPerTrig = 1;
depthVid.FramesPerTrigger=framesPerTrig;
depthVid.TriggerRepeat=inf;
src = getselectedsource(depthVid);
src.EnableBodyTracking = 'on';  
start([depthVid]);
%himg = figure;
SkeletonConnectionMap = [ [4 3];  % Neck 1
                          [3 21]; % Head 2
                          [21 2]; % Right Leg 
                          [2 1];    %
                          [21 9]; %
                          [9 10];  % Hip 
                          [10 11]; %7
                          [11 12]; % Left Leg 8
                          [12 24]; %9
                          [12 25]; %10
                          [21 5];  % Spine 11
                          [5 6];
                          [6 7];   % Left Hand
                          [7 8];
                          [8 22];
                          [8 23];
                          [1 17];
                          [17 18];
                          [18 19];  % Right Hand 19
                          [19 20];
                          [1 13];
                          [13 14];
                          [14 15];
                          [15 16];
                        ];
   
tic
for i = 1:1000
%x= true;
%while (x == true)%ishandle(plotGraph1)
[depthMap, depthMetaData] = getsnapshot(depthVid);

anyBodiesTracked = any(depthMetaData.IsBodyTracked ~= 0);
trackedBodies = find(depthMetaData.IsBodyTracked);
nBodies = length(trackedBodies);
colors = ['g';'b';'c';'y';'m'];
 if  sum(depthMetaData.IsBodyTracked) >0
 skeletonJoints = depthMetaData.DepthJointIndices (:,:,depthMetaData.IsBodyTracked);
 for i = 1:24
 for body = 1:nBodies
 X1 = [skeletonJoints(SkeletonConnectionMap(i,1),1,body); skeletonJoints(SkeletonConnectionMap(i,2),1,body)];
 Y1 = [skeletonJoints(SkeletonConnectionMap(i,1),2,body), skeletonJoints(SkeletonConnectionMap(i,2),2,body)];
neckKoord=depthMetaData.JointPositions(3,1:2, trackedBodies);
spineBaseKoord=depthMetaData.JointPositions(1,1:2, trackedBodies);
hipKoord =depthMetaData.DepthJointIndices(6,1:2, trackedBodies);
rightKneeKoord=depthMetaData.JointPositions(14,1:2, trackedBodies);
rightShoulderKoord=depthMetaData.JointPositions(9,1:2, trackedBodies);
rightHand =depthMetaData.JointPositions(12,1:2, trackedBodies);
%RhandKoord =depthMetaData.JointPositions(1, 1:2, trackedBodies);
%x = [(neckKoord(1) - spineBaseKoord(1)) (neckKoord(2) - spineBaseKoord(2))]
%y = neckKoord(2) - hipKoord(2)
xDiff = (neckKoord(1) - spineBaseKoord(1));
yDiff = (neckKoord(2) - spineBaseKoord(2));
xDiff2 = (rightKneeKoord(1) - spineBaseKoord(1));
yDiff2 = (rightKneeKoord(2) - spineBaseKoord(2));
xDiff3 = (rightShoulderKoord(1) - rightHand(1));
yDiff3 = (rightShoulderKoord(2) - rightHand(2));
bodyAngle = atan((yDiff)/(xDiff)) * 180/pi;
armAngle = atan((yDiff3)/(xDiff3)) * 180/pi;
Y = [Y bodyAngle];
end
 end
 else armAngle = 10;
     bodyAngle = -19;
     Y = [Y bodyAngle];
 end 
end


%  % %initializerar variabler
%   time = 0;
%  data1 = 0;
%  data2 = 0;
%  data3 = 0;
%  count = 0;
%  
% xxLabel = 'time(s)';
% yyLabel = 'data(signal)';
% 
% 
% axes(handles.maxes1)
% %Graf_1 maxes1: grafikdel av beräkningar
% %konstanter
% 
% plotGrid1 = 'on';
% min1 = -100;
% max1 = 100;
% scrollwidth1 = 10;
% delay1 = .001;
% count1 = 0;
% 
% %Grafikdetaljer
% plotGraph0 = plot(time,data1,'-o',...
%     'LineWidth',1,...
%     'MarkerSize',3,...
%     'MarkerEdgeColor','k',...
%     'MarkerFaceColor','r');
% hold on;
% 
% %Grafikspecifikationer
% title('Graf 1','FontSize',15);
% xlabel(xxLabel,'FontSize',12);
% ylabel(yyLabel,'FontSize',12);
% axis([0 10 min1 max1]);
% grid(plotGrid1) %aktiverar grid
% 
% %funktion of death
% inputvalue0 = (armAngle.*toc./toc); %(bodyAngle.*t./t);
% if(~isempty(inputvalue0)) %ej tom och ej float
%       %disp('1.1 isamptyy')
%       count1=count1+1;
%       time(count1) = toc;  %tar tiden
%       data1(count1) = inputvalue0(count1);%tar datan
%       if(scrollwidth1 > 0)
%           %disp('2.1 if scroll')
%           set(plotGraph0,'XData',time(time > time(count1)-scrollwidth1),...
%               'YData',data1(time > time(count1)-scrollwidth1));
%           axis([time(count1)-scrollwidth1 time(count1) min1 max1]);
%           
%           
%       else
%           %disp('2.2 ELSE LOL')
%           set(plotGraph0,'XData',time,'YData',data1);
%           axis([0 time(count1) min1 max1]);
%       end
%       %pause(delay1);
% end
% 
% % 
% 
% 
% axes(handles.maxes2)
% %Graf_2 maxes2: grafikdel av beräkningar
% %konstanter
% 
% plotGrid2 = 'on';
% min2 = -100;
% max2 = 100;
% scrollwidth2 = 10;
% delay2 = .001;
% 
% %Grafikdetaljer
% plotGraph2 = plot(time,data2,'-o',...
%     'LineWidth',1,...
%     'MarkerSize',3,...
%     'MarkerEdgeColor','k',...
%     'MarkerFaceColor','r');
% hold on;
% 
% %Grafikspecifikationer
% title('Graf 2','FontSize',15);
% xlabel(xxLabel,'FontSize',12);
% ylabel(yyLabel,'FontSize',12);
% axis([0 10 min2 max2]);
% grid(plotGrid2) %aktiverar grid
% 
% %funktion of death
% inputvalue2 = (2.*toc);
% if(~isempty(inputvalue2)) %ej tom och ej float
%       %disp('1.1 isamptyy')
%       count=count+1;
%       
%       time(count) = toc;  %tar tiden
%       data2(count) = inputvalue2(count);%tar datan
%       if(scrollwidth2 > 0)
%           %disp('2.1 if scroll')
%           set(plotGraph2,'XData',time(time > time(count)-scrollwidth2),...
%               'YData',data2(time > time(count)-scrollwidth2));
%           axis([time(count)-scrollwidth2 time(count) min2 max2]);
%           
%           
%       else
%           %disp('2.2 ELSE LOL')
%           set(plotGraph2,'XData',time,'YData',data2);
%           axis([0 time(count) min2 max2]);
%       end
%       %pause(delay2);
% end
% end
% 
% %fclose(s);
% %clear all;
% disp('THE END')
% Y
