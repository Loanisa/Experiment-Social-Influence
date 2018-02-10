%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   SOCIAL INFLUENCE ON RISK PERCEPTION 2014
%   VERSION: WITHOUT AUDIO SOCIAL INFLUENCE GROUPS )
%   PUBLISHED: Knoll et al (2017) and Knoll et al (2015)
%   install COGENT GRAPHICS and COGENT 2000
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   coded by LISA J. K. and LUCIA M.-W.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;              %This clears the workspace
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% change what you need to change to run the experiment
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% change yout matlab path to folder that includes all downloaded experiment scripts, pictures..
% set directories
task_directory=cd;      %This sets up our directory%

%Identifiers for volunteer
subjectnum=input('Subject number? ');
age=input('Age? ');


% your experiment settings:
load stimuli              % stimuli contains stimuli SCIENCE MUSEUM (79) 
dir_stimuli = '/Users/MATLAB/experiment/stimuli';
totaltrials=2;          % choose number of trials for each block, you can test a short run 
nrtrials = 18;          % each run shows 18 scenarios
cue = [1,2,3];           % we have three cues/conditions
nrcue = [6 6 6];         % how often each cue?
nrscenarios = 79;        % number of total scenarios in the stimuli list
% timing in ms
time_cue = 2000;         %duration presenting the condition cue (SM 2000)
time_rateagain = 2000;   %duration "please rate again" (SM 2000)
time_cross = 2000;       %duration ITI (SM 2000)
time_prov_rating = 4000; %duration provided rating(change in fixedrating.m)(SM 4000)
timelimit=inf;           %time limit for rating(change in ratingscale.m)

% visual stimuli
cue_adult='/Users/MATLAB/experiment/stimuli/condition/Slide1.bmp';
cue_teen=('/Users/MATLAB/experiment/stimuli/condition/Slide2.bmp');
cue_control=('/Users/MATLAB/experiment/stimuli/condition/Slide3.bmp');

% config_display parameters for your computer!
screenMode = 1;                 %0 for small window, 1 for full screen, 2 for second screen if attached
screenRes = 3;                  % 1=640x480; 2=800x600; 3=1024x768 - use 3 for projector
foreground = [1 1 1];           % foreground colour 111 is white
background = [0 0 0];           % background colour
fontName = 'Arial';             % font parameters
fontSize = 50;
nbits = 0;                      % 0 selects the maximum possible bits per pixel
screenparam1 = 1024;             % Should be adjusted for every computer. here: 1024x768
screenparam2 = 768;
config_display(screenMode, screenRes, background, foreground, fontName, fontSize, 5, nbits);

% configure devices
config_keyboard(100, 1, 'nonexclusive');
config_mouse;                   % we use a mouse 

%name your output files: 
results_file = sprintf('%0.2d_risk.res', subjectnum);

%Prevents from overwriting the output file.
if exist(results_file)~=0                          
    results_file = sprintf('%0.2d_risk_version2.res', subjectnum);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (hopefully) no changes needed below this line
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
config_results(results_file);                     %This needs to be here
%config_log(log_file);                            %This needs to be here

%color provided rating
col1=0.5;
col2=1;
col3=0.4;

%some variables
deltarating=0; 
b=0; 
y=0;
%key=1;     

%Random start
rand('seed',sum(100*clock));    % Changes the random start 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cogent starts here )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
start_cogent;
clearkeys;

cd(task_directory);
cgloadlib;
cgopen(screenparam1,screenparam2,0,0,1); 

cgpencol(1,1,1);
cgfont(fontName,fontSize);

cgflip(0,0,0);
age_text=num2str(age);
cgtext('Start',0,0);
cgflip(0,0,0);
wait(2000);
cgtext('You are',0,50);
cgpencol(1,0,0);
cgtext(age_text,0,0);
cgpencol(1,1,1);
cgtext('years old',0,-50);
cgflip(0,0,0);
wait(2000);

% Calculating the age group
cgflip(0,0,0);
cgtext('Calculating your age group',0,0);
cgflip(0,0,0);
wait(500);
cgtext('Calculating your age group.',0,0);
cgflip(0,0,0);
wait(500);
cgtext('Calculating your age group..',0,0);
cgflip(0,0,0);
wait(500);
cgtext('Calculating your age group...',0,0);
cgflip(0,0,0);
wait(2000);

cgpencol(1,1,1);
cgflip(0,0,0);
    cgtext('If there are no more questions',0,50);
    cgtext('the experiment will start shortly.',0,0);
    cgpencol(0.5,0.5,1);
    cgtext('Press any key to start',0,-90);
cgflip (0,0,0);
waitkeydown(inf);              %This waits for a keypress to continue

cgflip(0,0,0);
wait(2000);                    

addresults('#subjid #age #scenario #mouse_start1 #rating1 #RT1 #provided_rating #mouse_start2 #rating2 #RT2');

y = randperm(nrscenarios);                    %% We like this randomization better, no repeated numbers
for a=1:totaltrials
   i(a) = y(a)
end


% Determine the order of the condition
age_group=cell2mat(arrayfun(@(a,r)repmat(a,1,r),cue,nrcue,'uni',0))
ntotal=length(age_group);                         %All of these lines garantee that we have the same number of conditions in a random order
n_nopractice=ntotal;
nb_nopractice=age_group(1:n_nopractice);
randomize_age_group=randperm(n_nopractice);
matrix_list=nb_nopractice(randomize_age_group);

% task coding starts here
for counter=1:totaltrials;
  
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    %%Show first scenario
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    cgpencol(1,1,1)
    scenario=(stimuli_text{i(counter),1});
    cgtext(scenario,0,300);
    counter=1;
    cd(dir_stimuli)
    file_name=sprintf('Slide%d.bmp',i(counter));
    cgloadbmp(1,file_name);
    cgdrawsprite(1,0,0);
%    loadsound(sprintf('stimuli/%s',stimuli_text{i(counter),2}),1);
%    playsound(1);
    cgflip(0,0,0);

    [x,y,bs,bp]=cgmouse; 
    bp=0;
    delay=ceil(500*rand);
    wait(3000+delay); 
   
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Rating1
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    [rating1,rt1,x,mouse_start1]=ratingscale(scenario,timelimit);     
    cgflip (0,0,0);
  
    %%%%%%%%%%%%%%%%%%%%%%%%%%  
    %% provided rating
    %%%%%%%%%%%%%%%%%%%%%%%%%%   
    condition=matrix_list(counter);
      
    if condition==1
        text_condition=num2str('Adults rated');
        col1=0.5;
        col2=1;
        col3=0.4;
        imageoption=1;
        image_condition= cue_adult; 
        xmouse=randi([-384,384],[1,1]);
       
    elseif condition==2
        text_condition=num2str('Adolescents rated');
        col1=0.55;
        col2=0;
        col3=0.75;
        image_condition=cue_teen;
        control=2;
        xmouse=randi([-384,384],[1,1]);
    elseif condition==3
        text_condition=num2str('You rated');
        col1=0;
        col2=0;
        col3=1;
        image_condition=cue_control;
        xmouse=x;
    end
    
    cgloadbmp(1,image_condition);
    cgdrawsprite(1,0,0);
    cgflip(0,0,0);
    wait(time_cue);
    provided_rating=fixedrating(scenario,text_condition,col1,col2,col3,xmouse);
   
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    %%Rating 2
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    cgpencol(1,1,1);
    cgfont(fontName,fontSize);
    cgflip(0,0,0);
    cgtext('Please rate again ',0,0);
    cgflip(0,0,0);
    wait(time_rateagain);
    [x,y,bs,bp]=cgmouse; bp=0; 
    [rating2,rt2,x,mouse_start2]=ratingscale(scenario);
    
    whichone=i(counter); 
    addresults(subjectnum, age, whichone, mouse_start1, rating1,rt1, provided_rating, mouse_start2, rating2, rt2);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    %%Fixation Cross
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    cgpencol(1,1,1);
    cgfont(fontName,fontSize);
    cgflip(0,0,0);
    cgtext('+',0,0);
    cgflip(0,0,0);
    wait(time_cross);
end
cgshut;
stop_cogent;
   %%%%%%%%%%%%%%%%%%%%%%%%%%end%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
