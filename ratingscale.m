function [rating,alltime,x,mouse_start]=ratingscale(scenario, timelimit)
%% Chose if you want color or black and white
%% change font and size here
%%%%%%%%%%%%%%%%%%%%%%%%%%
fontName = 'Arial';             % font parameters
fontSize = 50;
fontSize2 = 35;                 % size "low risk" "high risk"
fontSize3 = 45 ;

escapekey=52;

waittime=0;
randstart = rand;

%parameters for the bar
bar_length=770;   %total size in pixels
bar_right=770/2;  %right limit
bar_left=-770/2; %left limit
bar_vect=linspace(bar_left,bar_right,bar_length+1);
bar_vect=transpose(bar_vect);  %to convert into a column
bar_gradient=linspace(0,1,bar_length+1);
bar_gradient=transpose(bar_gradient); %to convert into a column

% For color scale
bar_gradient(:,2)=linspace(1,0,bar_length+1);%bar_gradient(:,1)  % Cogent needs three parameters for a color, this repeats value in column 1 in column 2
bar_gradient(:,3)=linspace(1,0,bar_length+1);%bar_gradient(:,1) % Cogent needs three parameters for a color, this replicates value in column 1 in column 3


% For a black and white scale, comment the above and uncomment
%bar_gradient(:,2)=linspace(1,0,bar_length+1)
%bar_gradient(:,3)=linspace(1,0,bar_length+1)


y1=zeros(bar_length+1,1);
y1=y1-20;  %height of the bar, 20 pixels down
y2=y1+40;  %height of the bar, 20 pixels up


bp=0; 
tstart=time;
 
%No button down, yet
x=randi([-384,384],[1,1]);
cgmouse(x,0);
mouse_start=((x-bar_left)/(bar_right-bar_left)*10);

while (bp < 1) && time < tstart + timelimit;
   
   cgpencol(1,1,1); 
   cgtext(scenario,0,200);
   cgfont(fontName,fontSize2);
   cgtext('Low risk',-300,-60)
   cgtext('High risk',300,-60)
   cgfont(fontName,fontSize);
   cgdraw(bar_vect,y1,bar_vect,y2,bar_gradient) 
   [x,y,bs,bp]=cgmouse; 
   y=0;
      
   if x < bar_left, x = bar_left; end;  %to constrain the choice to the bar
   if x > bar_right, x = bar_right; end;  %to constrain the choice to the bar
   cgpencol(1,1,0);   %yellow color for the slider
   cgrect(x,y,10,50)  %slider
    
   cgflip(0,0,0);

end

if bp==0
    x=nan
end

%This calculates the reaction time in sec
tstart2=time;
alltime=(tstart2-tstart)/1000;
wait(2000);

rating=((x-bar_left)/(bar_right-bar_left)*10);   %This calculates the rating 
end
