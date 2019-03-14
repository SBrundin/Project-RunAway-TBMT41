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
himg = true;       
while himg(true)

%while ishandle(himg);
%trigger (depthVid);
%trigger (colorVid);

%[colorImg] = getdata(colorVid); 
[depthMap, depthMetaData] = getsnapshot(depthVid);
anyBodiesTracked = any(depthMetaData.IsBodyTracked ~= 0);
trackedBodies = find(depthMetaData.IsBodyTracked);
nBodies = length(trackedBodies);
colors = ['g';'b';'c';'y';'m'];
%imshow(colorImg);
%hold on;
%imshow (depthMap, [0 4096]);
 if  sum(depthMetaData.IsBodyTracked) >0
 skeletonJoints = depthMetaData.DepthJointIndices (:,:,depthMetaData.IsBodyTracked);
% %hold on;
 for i = 1:24
 for body = 1:nBodies
 X1 = [skeletonJoints(SkeletonConnectionMap(i,1),1,body); skeletonJoints(SkeletonConnectionMap(i,2),1,body)];
 Y1 = [skeletonJoints(SkeletonConnectionMap(i,1),2,body), skeletonJoints(SkeletonConnectionMap(i,2),2,body)];
 %line(X1,Y1, 'LineWidth', 2, 'LineStyle', '-' , 'Marker', '+', 'Color', colors(body));
neckKoord=depthMetaData.JointPositions(3,1:2, trackedBodies);
spineBaseKoord=depthMetaData.JointPositions(1,1:2, trackedBodies);
hipKoord =depthMetaData.DepthJointIndices(6,1:2, trackedBodies);
rightKneeKoord=depthMetaData.JointPositions(14,1:2, trackedBodies);
rightShoulderKoord=depthMetaData.JointPositions(9,1:2, trackedBodies);
rightHand =depthMetaData.JointPositions(12,1:2, trackedBodies);
rightKneeKoord=depthMetaData.JointPositions(18,1:2, trackedBodies);
rightHipKoord =depthMetaData.JointPositions(17,1:2, trackedBodies);
%RhandKoord =depthMetaData.JointPositions(1, 1:2, trackedBodies);
%x = [(neckKoord(1) - spineBaseKoord(1)) (neckKoord(2) - spineBaseKoord(2))]
%y = neckKoord(2) - hipKoord(2)
xDiff = (neckKoord(1) - spineBaseKoord(1));
yDiff = (neckKoord(2) - spineBaseKoord(2));
xDiff2 = (rightKneeKoord(1) - spineBaseKoord(1));
yDiff2 = (rightKneeKoord(2) - spineBaseKoord(2));
xDiff3 = (rightShoulderKoord(1) - rightHand(1));
yDiff3 = (rightShoulderKoord(2) - rightHand(2));
xDiff4 = (rightKneeKoord(1) - rightHipKoord(1));
yDiff4 = (rightKneeKoord(2) - rightHipKoord(2));
bodyAngle = atan((yDiff)/(xDiff)) * 180/pi;
armAngle = atan((yDiff3)/(xDiff3)) * 180/pi;
kneeAngle = atan((yDiff4)/(xDiff4)) * 180/pi

end
end
%hold off;
%hold off;
end
end
stop(depthVid);

