
obj=videoinput('kinect',1);
obj.ReturnedColorspace = 'rgb';
B=getsnapshot(obj);
framesPerTrig = 1;
depthVid.FramesPerTrigger=framesPerTrig;
depthVid.TriggerRepeat=inf;

framesAcquired = 0;
while (true==true)%(framesAcquired <= 100) 
    
      data = getsnapshot(obj) ;
      framesAcquired = framesAcquired + 1;    
      
      diff_im = imsubtract(data(:,:,1), rgb2gray(data)); %tar ut färgskillnader mellan de verkliga och en gråskala
      diff_im = medfilt2(diff_im, [3 3]);             
      diff_im = im2bw(diff_im,0.18);                   
      %stats = regionprops(diff_im, 'BoundingBox', 'Centroid'); 
      
  
      % Remove all those pixels less than 300px
      diff_im = bwareaopen(diff_im,300);
    
    % Label all the connected components in the image.
     bw = bwlabel(diff_im, 8);
    
    % Here we do the image blob analysis.
    % We get a set of properties for each labeled region.
    stats = regionprops(bw, 'BoundingBox', 'Centroid');
    % Display the image
    imshow(data)
    
    hold on
    
    %This is a loop to bound the red objects in a rectangular box.
    for object = 1:length(stats)
        bb = stats(object).BoundingBox;
        bc = stats(object).Centroid;
        rectangle('Position',bb,'EdgeColor','r','LineWidth',2)
        plot(bc(1),bc(2), '-m+')
        a=text(bc(1)+15,bc(2), strcat('X: ', num2str(round(bc(1))), '    Y: ', num2str(round(bc(2))), '    Color: Red'));
        set(a, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12, 'Color', 'red');
    end  
 
    hold off
    
end

clear all