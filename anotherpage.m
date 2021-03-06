function varargout = anotherpage(varargin)
% ANOTHERPAGE MATLAB code for anotherpage.fig
%      ANOTHERPAGE, by itself, creates a new ANOTHERPAGE or raises the existing
%      singleton*.
%
%      H = ANOTHERPAGE returns the handle to a new ANOTHERPAGE or the handle to
%      the existing singleton*.
%
%      ANOTHERPAGE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANOTHERPAGE.M with the given input arguments.
%
%      ANOTHERPAGE('Property','Value',...) creates a new ANOTHERPAGE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before anotherpage_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to anotherpage_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help anotherpage

% Last Modified by GUIDE v2.5 14-Mar-2019 15:41:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @anotherpage_OpeningFcn, ...
                   'gui_OutputFcn',  @anotherpage_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before anotherpage is made visible.
function anotherpage_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to anotherpage (see VARARGIN)

% Choose default command line output for anotherpage
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes anotherpage wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = anotherpage_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles);
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton1

% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% num = str2double(get(handles.edit1,'string'));
% x=0:0.01:2*pi;
% y=num*cos(x);
% axes(handles.axes1)
% plot(x,y)
% axis([0 2*pi -num num])
% Hint: get(hObject,'Value') returns toggle state of togglebutton1
a = [];
t=0:1:2000;
array2 = sin(t./30);
init = array2;
parpool(6);
%axes(handles.maxes1); %make ax1 the current axes
    imaqreset;
%create color and depth kinect videoinput objects
colorVid = videoinput('kinect', 1);
%preview(colorVid);
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
for i = 1:200
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
a = [a bodyAngle];
end
 end
 else armAngle = 10;
     bodyAngle = -19;
     a = [a bodyAngle];
 end
 
 % %initializerar variabler
  time = 0;
 data1 = 0;
 data2 = 0;
 data3 = 0;
 count = 0;
 
xxLabel = 'time(s)';
yyLabel = 'data(signal)';


axes(handles.maxes1)
%Graf_1 maxes1: grafikdel av beräkningar
%konstanter

plotGrid1 = 'on';
min1 = -100;
max1 = 100;
scrollwidth1 = 10;
delay1 = .001;
count1 = 0;

%Grafikdetaljer
plotGraph0 = plot(time,data1,'-o',...
    'LineWidth',1,...
    'MarkerSize',3,...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor','r');
hold on;

%Grafikspecifikationer
title('Graf 1','FontSize',15);
xlabel(xxLabel,'FontSize',12);
ylabel(yyLabel,'FontSize',12);
axis([0 10 min1 max1]);
grid(plotGrid1) %aktiverar grid

%funktion of death
inputvalue0 = (3.*toc); %(bodyAngle.*t./t);
if(~isempty(inputvalue0)) %ej tom och ej float
      %disp('1.1 isamptyy')
      count1=count1+1;
      time(count1) = toc;  %tar tiden
      data1(count1) = inputvalue0(count1);%tar datan
      if(scrollwidth1 > 0)
          %disp('2.1 if scroll')
          set(plotGraph0,'XData',time(time > time(count1)-scrollwidth1),...
              'YData',data1(time > time(count1)-scrollwidth1));
          axis([time(count1)-scrollwidth1 time(count1) min1 max1]);
          
          
      else
          %disp('2.2 ELSE LOL')
          set(plotGraph0,'XData',time,'YData',data1);
          axis([0 time(count1) min1 max1]);
      end
      %pause(delay1);
end

% 


axes(handles.maxes2)
%Graf_2 maxes2: grafikdel av beräkningar
%konstanter

plotGrid2 = 'on';
min2 = -100;
max2 = 100;
scrollwidth2 = 10;
delay2 = .001;

%Grafikdetaljer
plotGraph2 = plot(time,data2,'-o',...
    'LineWidth',1,...
    'MarkerSize',3,...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor','r');
hold on;

%Grafikspecifikationer
title('Graf 2','FontSize',15);
xlabel(xxLabel,'FontSize',12);
ylabel(yyLabel,'FontSize',12);
axis([0 10 min2 max2]);
grid(plotGrid2) %aktiverar grid

%funktion of death
inputvalue2 = (armAngle.*toc./toc);
if(~isempty(inputvalue2)) %ej tom och ej float
      %disp('1.1 isamptyy')
      count=count+1;
      
      time(count) = toc;  %tar tiden
      data2(count) = inputvalue2(count);%tar datan
      if(scrollwidth2 > 0)
          %disp('2.1 if scroll')
          set(plotGraph2,'XData',time(time > time(count)-scrollwidth2),...
              'YData',data2(time > time(count)-scrollwidth2));
          axis([time(count)-scrollwidth2 time(count) min2 max2]);
          
          
      else
          %disp('2.2 ELSE LOL')
          set(plotGraph2,'XData',time,'YData',data2);
          axis([0 time(count) min2 max2]);
      end
      %pause(delay2);
end
end

%fclose(s);
%clear all;
disp('THE END')
a


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%TrackFcn(hObject, eventdata, handles);

%parpool(3)
depthVid = videoinput('kinect', 2);

job1 = batch('TrackFcn')
job2 = batch('CountFcn')
 wait(job2);
 res = load(job2)
 disp(res)
 wait(job1);
 Y=load(job1)
 plot(Y)
 
 
% x = true;
% while (x ==true)
% f1 = parfeval(@TrackFcn, 1);
% %f2 = parfeval(@CountFcn, 1);
% % fetchNext waits for one of the functions to complete,
% % and also gets the result
% [idx, result] = fetchNext([f1]);%, f2]);
% % We're done, so we can cancel f1 and f2 (one will actually already be complete)
% result
% cancel([f1]);%, f2]);
% delete(gcp);
% end

% parfor i = 1:2
%     if i == 1
%       TrackFcn(hObject, eventdata, handles)
%     else
%      CountFcn
%     end
% end

% hObject    handle to togglebutton1 (see GCBO)


