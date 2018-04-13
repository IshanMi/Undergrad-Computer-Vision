function HappyBirthday(name,age,message)
%HAPPYBIRTHDAY   This program generates a Birthday Cake for Dalton Sweeney.
% Example:
%    HappyBirthday({'Dalton'},20,{'Don''t drink and derive, Dalton!'})
%
 
 
%% Birthday Message
switch nargin %nargin = number of input arguments for the function.
    case 3        
        switch length(message)
            case 1
                if strncmpi(message{1},'hsdaz',5)
                    message{1} = message{1};
                    message{2} = ['Placeholder Text']; 
                else % This way it shouldn't matter what you enter, so long as it is of the correct type.
                    message{2} = message{1};
                    message{1} = ['Happy Birthday, ' [name{:}] '!'];
                end
                 
            otherwise
                message = {message{1},[message{2:end}]};
        end
end
 
R = 10; % radius of cake
r = 0.25; % radius of candle
l = 3; % length of candle
 
tg_flg = false;
 
h_f = figure('name','Happy Birthday','numbertitle','off','menubar','none','color',[1,1,1],'position',[145 75 1100 640],'resize','off');
h_a = axes('parent',h_f);
set(h_a,'color',[1 1 1],'box','off','xlim',[-R R],'ylim',[-R R],'zlim',[-R R],'dataaspectratio',[1 1 1],'projection','perspective','xcolor',[1 1 1],'ycolor',[1 1 1],'zcolor',[1 1 1])
 
h_rot = rotate3d(h_f);
set(h_rot,'enable','off');
view(h_a,[-1 -2.5 1])
 
h_tg = uicontrol(h_f,'style','pushbutton','string','NEXT','position',[490 20 120 50],'fontsize',20,'callback',@make_cake_fcn);
h_tg_candle = uicontrol(h_f,'style','pushbutton','string','Candle','position',[10 400 100 50],'fontsize',18,'callback',@make_candle_fcn,'enable','off','visible','off');
h_tg_light = uicontrol(h_f,'style','pushbutton','string','Light','position',[10 340 100 50],'fontsize',18,'callback',@light_candle_fcn,'enable','off','visible','off');
h_tg_blow = uicontrol(h_f,'style','pushbutton','string','Blow off','position',[10 280 100 50],'fontsize',18,'callback',@blow_candle_fcn,'enable','off','visible','off');
 
%% GENERATE CAKE
t = (0:0.01:1)*2*pi; 
x = R*cos(t); 
y = R*sin(t); 
z = ones(size(t));
 
[x_cake,y_cake,z_cake] = cylinder(R,25); % radius R, 25 points
 
h_cake = zeros(1,6);
h_cake(1) = patch(x,y,-5*z,'w','parent',h_a,'facecolor',[.4 .4 .1],'linestyle','none','visible','off'); % .4 .4 .1
h_cake(2) = patch(x,y,0*z,'w','parent',h_a,'facecolor',[0.98 0.70 0.94],'linestyle','none','visible','off');  % .9 .9 .1
h_cake(3) = surface(x_cake,y_cake,z_cake*2.5-5,'parent',h_a,'facecolor',[.35 .24 0],'linestyle','none','visible','off');  % .35 .24 0
h_cake(4) = surface(x_cake,y_cake,z_cake*2.5-2.5,'parent',h_a,'facecolor',[.98 .70 .94],'linestyle','none','visible','off'); % .9  .9  .1
h_cake(5) = line(x,y,0*z,'parent',h_a,'color',[.85 .35 .15],'linestyle','-','linewidth',5,'marker','o','markerfacecolor',[0.80 0.25 0.50],'markeredgecolor','none','markersize',8.5,'visible','off');
h_cake(6) = line(x*.8,y*.8,0*z,'parent',h_a,'color',[0.78 0.35 0.40],'linestyle','-','linewidth',7.5,'visible','off');
h_cake(7) = surface(x_cake,y_cake,z_cake*2.5-7.5,'parent',h_a,'facecolor',[.98 .70 .94],'linestyle','none','visible','off'); % .9  .9  .1
 
w_width = 2;
w_height = 3;
 
[name_line,len] = LatinAlphabet([name{:}]);
name_len = length([name{:}]);
h_name = zeros(1,name_len);
 
% name = {'Sweeneyboy';
len_k1 = length(name);
len_old = 0;
 
for k1 = 1:len_k1
    len_k2 = length(name{k1});
    for k2 = 1:len_k2
        h_name(len_old+k2) = line(name_line{len_old+k2}(1,:)*w_width+(k2-len_k2/2-1)*w_width,name_line{len_old+k2}(2,:)*w_height+(len_k1/2-k1)*w_height,zeros(1,len(len_old+k2)),'parent',h_a,'color',[.95 .25 .15],'linewidth',5,'visible','off');
    end
    len_old = len_old+len_k2;
end
 
t_layout = linspace(0,2*pi,age);
x_layout = (R-.5)*cos(t_layout);
y_layout = (R-.5)*sin(t_layout);
 
 
 
 
% Place Candles, set them on fire
 
% Fire
t_fire = (0:.1:.7)*pi;
[x_fire,y_fire,z_fire] = cylinder(cos(t_fire-.64));
h_fire = zeros(1,age);
 
% Candles
[x_candle,y_candle,z_candle] = cylinder(r,15);
h_candle = zeros(1,age);
 
% Specify Locations
for k = 1:age
    h_candle(k) = surface(x_candle+x_layout(k),y_candle+y_layout(k),z_candle*l,'parent',h_a,'facecolor',rand(1,3),'linestyle','none','visible','off');
    h_fire(k) = surface(r*x_fire+x_layout(k),r*y_fire+y_layout(k),l+z_fire*.7,'parent',h_a,'facecolor',[1 .08 .01],'facealpha',.8,'linestyle','none','visible','off');
end
 
%% TEXT
 
h_msg1 = uicontrol('style','text','backgroundcolor',[1 1 1],'position',[150,400,800,150],'string',message{1},'fontsize',50,'HorizontalAlignment','center','fontweight','bold','foregroundcolor',[1 .1 .1]);
 
h_msg2 = uicontrol('style','text','backgroundcolor',[1 1 1],'position',[150,200,800,150],'string',message{2},'fontsize',30,'HorizontalAlignment','center','fontweight','bold','foregroundcolor',[.1 .25 1]);
 
h_msg3 = uicontrol('style','text','backgroundcolor',[1 1 1],'position',[150,100,800,150],'string','Brought to you by your buddies at K.I.M.S.','fontsize',10,'HorizontalAlignment','center','fontweight','bold','foregroundcolor',[.5 0.05 .87]);
 
h_msg4 = uicontrol('style','text','backgroundcolor',[1 1 1],'position',[150,50,800,150],'string','One Dalton = 1.660 539 040(20) x 10^-27 kg','fontsize',10,'HorizontalAlignment','center','fontweight','bold','foregroundcolor',[.5 0.05 .87]);
 
 
%
%% FUNCTIONS
     
    function make_cake_fcn(varargin)
        if ~tg_flg
            set(h_msg1,'visible','off')
            set(h_msg2,'visible','off')
            set(h_msg3,'visible','off')
            set(h_msg4,'visible','off')
            set(h_tg,'string','BACK')
            set(h_cake,'visible','on')
            set(h_name,'visible','on')
            set(h_rot,'enable','on')
            set(h_tg_candle,'visible','on','enable','on')
            set(h_tg_light,'visible','on')
            set(h_tg_blow,'visible','on')
        else
            set(h_msg1,'visible','on')
            set(h_msg2,'visible','on')
            set(h_msg3,'visible','on')
            set(h_msg4,'visible','on')
            set(h_tg,'string','NEXT')
            set(h_cake,'visible','off')
            set(h_name,'visible','off')
            set(h_candle,'visible','off')
            set(h_fire,'visible','off')
            set(h_rot,'enable','off')
            set(h_tg_candle,'visible','off','enable','off')
            set(h_tg_light,'visible','off','enable','off')
            set(h_tg_blow,'visible','off','enable','off')
        end
        tg_flg = ~tg_flg;
    end
 
    function make_candle_fcn(varargin)
        set(h_tg_candle,'enable','off')
        set(h_tg_light,'enable','on')
        set(h_candle,'visible','on')
    end
 
    function light_candle_fcn(varargin)
        set(h_fire,'visible','off')
        for kf = 1:age
            set(h_fire(kf),'visible','on')
            for kkf = 1:name_len
                set(h_name(kkf),'color',rand(1,3))
            end
            set(h_cake(5),'markerfacecolor',rand(1,3))
            set(h_cake(6),'color',rand(1,3))
            pause(.1)
        end
        set(h_tg_blow,'enable','on')
        set(h_name,'color',[.95 .25 .15])
        set(h_cake(5),'markerfacecolor',[0.80 0.25 0.50])
        set(h_cake(6),'color',[0.78 0.35 0.40])
    end
 
    function blow_candle_fcn(varargin)
        set(h_fire,'visible','off')
        set(h_tg_blow,'enable','off')
    end
%
end
