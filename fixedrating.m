function [provided_rating]=fixedrating(scenario,time_prov_rating,text_condition,col1,col2,col3)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% change font and size
 fontName = 'Arial';             % font parameters
 fontSize = 50;
 fontSize2 = 35;                 % size "low risk" "high risk"
 fontSize3 = 45 ;


%%%%%%%%%%%%%%
waittime=0;
xmouse=randi([-384,384],[1,1]);

%parameters for the bar
bar_length=768;   %total size in pixels
bar_right=768/2;  %right limit
bar_left=-768/2; %left limit
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


%text='This should be part of the input of the function'

y1=zeros(bar_length+1,1);
y1=y1-20;  %height of the bar, 20 pixels down
y2=y1+40;  %height of the bar, 20 pixels up



y=0;
cgpencol(1,1,1); 
cgfont(fontName,fontSize2);
cgtext('Low risk',-300,-60)
cgtext('High risk',300,-60)
cgfont(fontName',fontSize);
cgtext(scenario,0,200);

cgtext(fontName,fontSize3);
%cgpencol(col1,col2,col3);
   
     cgpencol(0.55,0,0.75);
%  cgpencol(0.5,0.5,1);
cgtext(text_condition,0,-150);
cgdraw(bar_vect,y1,bar_vect,y2,bar_gradient) 
cgrect(xmouse,y,10,50)  %slider
cgflip(0,0,0);
wait(time_prov_rating);


provided_rating=((xmouse-bar_left)/(bar_right-bar_left)*10); 



end
