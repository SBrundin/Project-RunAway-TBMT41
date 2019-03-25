% obj=videoinput('kinect',1);
% obj.ReturnedColorspace = 'rgb';
% colorDevice = imaq.VideoDevice('kinect',1)
% colorDevice.ReturnedDataType = 'uint8';


myKinect = imaq.VideoDevice('kinect', 1);
vidInfo = imaqhwinfo(myKinect)
%framesAcquired = 0;
while (true==true)%(framesAcquired <= 100) 
    
      data = step(colorDevice) ;
     % framesAcquired = framesAcquired + 1;    
      
      diff_im = imsubtract(data(:,:,1), rgb2gray(data)); %tar ut färgskillnader mellan de verkliga och en gråskala
      diff_im = medfilt2(diff_im, [3 3]);             
      diff_im = im2bw(diff_im,0.18);                   
      %stats = regionprops(diff_im, 'BoundingBox', 'Centroid'); 
      
  
      % Remove all those pixels less than 300px
      diff_im2 = bwareaopen(diff_im,300);
    
    tic% Label all the connected components in the image.
     bw = bwlabel(diff_im2, 8);
    
    % Here we do the image blob analysis.
    % We get a set of properties for each labeled region.
    stats = regionprops(bw, 'BoundingBox', 'Centroid')
   % xy = stats(1).Centroid
    % Display the image
    %imshow(data)
    preview(colorDevice)
end
