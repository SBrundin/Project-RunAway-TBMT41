clear
clc
t=0:1:2000;
array2 = sin(t./30);
init = array2;


%serialPort = 'COMX'; %detta är input signal yo
danielGrafik = 'TEST:Logger Data Serial';
xxLabel = 'time(s)';
yyLabel = 'data(signal)';
plotGrid = 'on';
min = -1;
max = 2;
scrollwidth = 10;
delay = .01;

%initializerar variabler
time = 0;
data = 0;
count = 0;

%förbereder grafiken
plotGraph = plot(time,data,'-o',...
    'LineWidth',1,...
    'MarkerSize',3,...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor','r');

title(danielGrafik,'FontSize',15);
xlabel(xxLabel,'FontSize',12);
ylabel(yyLabel,'FontSize',12);
axis([0 10 min max]);
grid(plotGrid) %aktiverar grid

%öppna kommunikation via SENSOR
% s = serial(serialPort);
% disp('Stäng fönstret för att avsluta loggning');
% fopen(s)

tic     %aktiverar timesdetektering
while ishandle(plotGraph)   %loopar den aktiva plotten
    
  %inputvalue = fscanf(array2,'%f');  %läser data i floatformat
   inputvalue = array2; 
  
  %Ser till att mottagen data är korrekt
  if(~isempty(inputvalue)) %ej tom och ej float
      %disp('1.1 isamptyy')
      count=count+1;
      time(count) = toc;  %tar tiden
      data(count) = inputvalue(count); %tar datan
      
      %ange axrl enligt scrollwidth
      if(scrollwidth > 0)
          %disp('2.1 if scroll')
          set(plotGraph,'XData',time(time > time(count)-scrollwidth),...
              'YData',data(time > time(count)-scrollwidth));
          axis([time(count)-scrollwidth time(count) min max]);
      else
          %disp('2.2 ELSE LOL')
          set(plotGraph,'XData',time,'YData',data);
          axis([0 time(count) min max]);
      end
      
      %Tid för grafen att uppdatera sig
      pause(delay);
  end
end
%fclose(s);
clear all;
disp('THE END')

      
      
      
      
      
      
      
      
      
      
      
      
  
