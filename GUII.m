function varargout = GUII(varargin)
% GUII MATLAB code for GUII.fig
%      GUII, by itself, creates a new GUII or raises the existing
%      singleton*.
%
%      H = GUII returns the handle to a new GUII or the handle to
%      the existing singleton*.
%
%      GUII('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUII.M with the given input arguments.
%
%      GUII('Property','Value',...) creates a new GUII or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUII_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUII_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUII

% Last Modified by GUIDE v2.5 29-Jul-2018 20:29:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @GUII_OpeningFcn, ...
    'gui_OutputFcn',  @GUII_OutputFcn, ...
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


% --- Executes just before GUII is made visible.
function GUII_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUII (see VARARGIN)

% Choose default command line output for GUII
handles.output = hObject;
%% Background Picture
ha=axes('units','normalized','position',[0 0 1 1]);
uistack(ha,'down')
II=imread('bg.jpg');
image(II)
colormap gray
set(ha,'handlevisibility','off','visible','off');
%% Window Picture
im = imread('bg(2).jpg');
axes(handles.axes1);
imshow(im);
%% Invisible
handles.pushbutton1.Visible = 'off';
handles.pushbutton2.Visible = 'off';
handles.message.Visible = 'off';
handles.text4.Visible = 'off';
handles.text.Visible = 'off';
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUII wait for user response (see UIRESUME)
% uiwait(handles.figure1);
%%
% --- Outputs from this function are returned to the command line.
function varargout = GUII_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1
%% Initialization
handles.pushbutton1.Visible = 'off';
handles.pushbutton2.Visible = 'off';

handles.namecard.Visible = 'off';
handles.text4.Visible = 'on';
handles.text.Visible = 'on';
% tempo
fs = 8000;  %采样率
Meter = 250;    %拍数，控制节奏
tMeter = 60 / Meter;    %一拍的时间

% 音符时值函数
t = @(beat)(0:1/fs:2*beat*tMeter);

%% Switch case
A= get(handles.listbox1,'value');

switch A
    case 1
        %% Statement
        a = "(1) 请根据《东方红》片断的简谱和“十二平均律”计算出该片断中各个乐音的频率，"+...
            "在 MATLAB 中生成幅度为 1 、抽样频率为 8kHz 的正弦信号表示这些乐音。请用 sound 函"+...
            "数播放每个乐音，听一听音调是否正确。最后用这一系列乐音信号拼出《东方红》片断，注"+...
            "意控制每个乐音持续的时间要符合节拍，用 sound 播放你合成的音乐，听起来感觉如何？";
        set(handles.text, 'string', a);
        handles.text.FontSize = 10;
        
        %% Note
        note = @(freq,t)(sin(freq*2*pi*t));
        
        la_1 = @(t)note(296.66,t);%la_1, f = 296.66Hz
        do = @(t)note(349.23,t);%do, f = 349.23Hz
        re = @(t)note(392,t);%do, f = 392Hz
        so = @(t)note(523.25,t);%so, f = 523.25Hz
        la = @(t)note(587.33,t);%la, f = 587.33Hz
        
        %% Message
        handles.message.Visible = 'on';
        m1 = "该片断中各个乐音的频率为：la_1: 296.66Hz, do: 349.23Hz, re: 392Hz, so: 523.25Hz, la: 587.33Hz. "+...
            "听起来像音叉。音符间有明显的""啪""杂音。";
        set(handles.message, 'string',m1);
        handles.message.FontSize = 12;
        
        
        %% 东方红
        meter1 = [so(t(1)) so(t(0.5)) la(t(0.5)) re(t(2))];%东方红
        meter2 = [do(t(1)) do(t(0.5)) la_1(t(0.5)) re(t(2))];%太阳升
        line = [meter1 meter2]';
        sound(line,fs);
        plot(handles.axes1,line);
        title({'$signal\ =\ sin(t)$'},'Interpreter','latex','FontSize',16,'FontWeight','bold');
        clear;
    case 2
        %% Statement
        a = "(2) 你一定注意到 (1) 的乐曲中相邻乐音之间有“啪”的杂声，这是由于相位不连续产"+...
            "生了高频分量。这种噪声严重影响合成音乐的质量，丧失真实感。为了消除它，我们可以用"+...
            "图 1.5 所示包络修正每个乐音，以保证在乐音的邻接处信号幅度为零。此外建议用指数衰"+...
            "减的包络来表示";
        set(handles.text, 'string', a);
        
        %% Note
        note = @(freq,t)(sin(freq*2*pi*t)).*exp(4*-t);
        
        la_1 = @(t)note(296.66,t);%la_1, f = 296.66Hz
        do = @(t)note(349.23,t);%do, f = 349.23Hz
        re = @(t)note(392,t);%do, f = 392Hz
        so = @(t)note(523.25,t);%so, f = 523.25Hz
        la = @(t)note(587.33,t);%la, f = 587.33Hz
        
        %% Message
        handles.message.Visible = 'on';
        m1 = "在(1)的基础上添加指数衰减。";
        set(handles.message, 'string',m1);
        %% 东方红
        meter1 = [so(t(1)) so(t(0.5)) la(t(0.5)) re(t(2))];%东方红
        meter2 = [do(t(1)) do(t(0.5)) la_1(t(0.5)) re(t(2))];%太阳升
        line = [meter1 meter2]';
        sound(line,fs);
        plot(handles.axes1,line);
        title({'$signal\ =\ sin(t)\ *\ e^{-t}$'},'Interpreter','latex','FontSize',16,'FontWeight','bold');
        clear;
    case 3
        %% Statement
        a = "(3) 请用最简单的方法将 (2) 中的音乐分别升高和降低一个八度。 （提示：音乐播放的"+...
            "时间可以变化）再难一些，请用 resample 函数（也可以用 interp 和 decimate 函数）将上述"+...
            "音乐升高半个音阶";
        set(handles.text, 'string', a);
        
        %% Note
        note = @(freq,t)(sin(freq*2*pi*t)).*exp(2*-t);
        
        la_1 = @(t)note(296.66,t);%la_1, f = 296.66Hz
        do = @(t)note(349.23,t);%do, f = 349.23Hz
        re = @(t)note(392,t);%do, f = 392Hz
        so = @(t)note(523.25,t);%so, f = 523.25Hz
        la = @(t)note(587.33,t);%la, f = 587.33Hz
        %% 升高/降低n阶
        lift = @(n,t)resample(t,fs,round(2^(n/12))*fs);
        drop = @(n,t)resample(t,fs,fs/round(2^(n/12)));
        %% Message
        handles.message.Visible = 'on';
        handles.message.FontSize = 16;
        m = "降低一个八度 & 升高一个八度.";
        set(handles.message, 'string',m);
        
        tt = @(beat)drop(6,t(beat));
        
        sig = do(tt(0.125));
        plot(sig);
        plot(handles.axes1,sig);
        title({'$one\ \ octave\ \ lower$'},'Interpreter','latex','FontSize',16,'FontWeight','bold');
        %% 东方红
        meter1 = [so(tt(0.5)) so(tt(0.25)) la(tt(0.25)) re(tt(1))];%东方红
        meter2 = [do(tt(0.5)) do(tt(0.25)) la_1(tt(0.25)) re(tt(1))];%太阳升
        line = [meter1 meter2]';
        sound(line,0.5*fs);
        pause(4);
        %% Message
        tt = @(beat)lift(8,t(beat));
        
        sig = do(tt(0.25));
        plot(sig);
        plot(handles.axes1,sig);
        title({'$one\,\,octave\,\,higher$'},'Interpreter','latex','FontSize',16,'FontWeight','bold');
        %% 东方红
        meter1 = [so(tt(2)) so(tt(1)) la(tt(1)) re(tt(4))];%东方红
        meter2 = [do(tt(2)) do(tt(1)) la_1(tt(1)) re(tt(4))];%太阳升
        line = [meter1 meter2]';
        sound(line,fs);
        clear;
    case 4
        %% Statement
        a = "(4) 试着在 (2) 的音乐中增加一些谐波分量，听一听音乐是否更有“厚度”了？注意谐"+...
            "波分量的能量要小，否则掩盖住基音反而听不清音调了。 （如果选择基波幅度为 1 ，二次谐"+...
            "波幅度 0.2 ，三次谐波幅度 0.3 ，听起来像不像象风琴？）";
        set(handles.text, 'string', a);
        
        %% Note
        note = @(freq,t)(sin(0.936*freq*2*pi*t)...
            +0.110*sin(2*freq*2*pi*t)...
            +0.011*sin(3*freq*2*pi*t))...
            .*exp(1*-t);
        
        la_1 = @(t)note(296.66,t);%la_1, f = 296.66Hz
        do = @(t)note(349.23,t);%do, f = 349.23Hz
        re = @(t)note(392,t);%do, f = 392Hz
        so = @(t)note(523.25,t);%so, f = 523.25Hz
        la = @(t)note(587.33,t);%la, f = 587.33Hz
        
        %% Message
        handles.message.Visible = 'on';
        handles.message.FontSize = 12;
        m = "由弦振动模型解得真实琴弦振动的谐波含量，基波幅度为0.936 ，二次谐波幅度0.011 ，三次谐波幅度0.011.听起来相对厚重，有琴弦声。";
        set(handles.message, 'string',m);
        sig = do(t(2));
        plot(handles.axes1,sig);
        title({'$signal = 0.936*sin(t) + 0.110*sin(2t) + 0.011*sin(3t)$'},'Interpreter','latex','FontSize',16,'FontWeight','bold');
        %% 东方红
        meter1 = [so(t(1)) so(t(0.5)) la(t(0.5)) re(t(2))];%东方红
        meter2 = [do(t(1)) do(t(0.5)) la_1(t(0.5)) re(t(2))];%太阳升
        line = [meter1 meter2]';
        sound(line,fs);
        clear;
    case 5
        %% Statement
        a = "(5) 自选其它音乐合成";
        set(handles.text, 'string', a);
        
        %% 音符频率函数
        note = @(freq,t)(sin(freq*2*pi*t)...
            +0.4*sin(freq*2*2*pi*t)...
            +0.3*sin(freq*3*2*pi*t)...
            +0.1*sin(freq*5*2*pi*t))...
            .*exp(-2*t);     %指数衰减（在此进行包络、修饰）
        %+0.4*sin(freq*4*2*pi*(t+0.01*pi))...
        %% 音符
        zero = @(t)zeros(1,length(t));
        
        so_1 = @(t)note(280.01,t);%so_1, f = 280.01Hz
        la_1 = @(t)note(296.66,t);%la_1, f = 296.66Hz
        xi_1 = @(t)note(329.63,t);%xi_1, f = 329.63Hz
        
        do = @(t)note(349.23,t);%do, f = 349.23Hz
        re = @(t)note(392,t);%do, f = 392Hz
        mi = @(t)note(440.00,t);%mi, f = 440Hz
        fa = @(t)note(493.88,t);%fa, f = 493.88Hz
        so = @(t)note(523.25,t);%so, f = 523.25Hz
        la = @(t)note(587.33,t);%la, f = 587.33Hz
        xi = @(t)note(659.26,t);%xi, f = 659.26Hz
        
        %% Message
        handles.message.Visible = 'on';
        m = "假如爱有天意（节选）——李健.";
        set(handles.message, 'string',m);
        im = imread('假如爱有天意.jpg');
        axes(handles.axes1);
        imshow(im);
        %% 假如爱有天意乐谱
        %定义时间
        t05 = t(0.5);t1 = t(1);t15 = t(1.5);t2 = t(2);t3 = t(3);
        
        %有多少爱恋只能遥遥相望 就像月光洒向海面 年少的我们曾以为 相爱的人就能到永远
        meter7 = [mi(t05) so(t05) la(t2) la(t1) so(t2) mi(t05) re(t05) mi(t15) fa(t05) mi(t05) re(t05) do(t2)];
        meter8 = [la_1(t05) xi_1(t05) do(t2) re(t05) mi(t05) re(t15) xi_1(t05) so_1(t1) la_1(t3) zero(t3)];
        meter9 = [mi(t2) mi(t1) re(t15) do(t05) xi_1(t1) do(t2) re(t1) mi(t2)];
        meter10 = [mi(t05) so(t05) la(t2) la(t1) xi(t15) la(t05) so(t05) re(t05) mi(t3)];
        
        line = [meter7 meter8 meter9 meter10];
        
        sound(line,fs);
        clear;
    case 6
        %% Statement
        a = "(6) 先用 wavread 函数载入光盘中的 fmt.wav 文件，播放出来听听效果如何？是否比刚"+...
            "才的合成音乐真实多了？";
        set(handles.text, 'string', a);
        %% Message
        handles.message.Visible = 'on';
        m = "使用audioread('fmt.wav')直接读取音乐。";
        handles.message.FontSize = 16;
        set(handles.message, 'string',m);
        a = 3*audioread('fmt.wav');
        plot(handles.axes1,a);
        title({'$sound\ \ wave$'},'Interpreter','latex','FontSize',16,'FontWeight','bold');
        %% Sound
        sound(a);
        
    case 7
        %% Statement
        a = "(7) 你知道待处理的 wave2proc 是如何从真实值 realwave 中得到的么？这个预处理过"+...
            "程可以去除真实乐曲中的非线性谐波和噪声，对于正确分析音调是非常重要的。提示：从"+...
            "时域做，可以继续使用 resample 函数。";
        set(handles.text, 'string', a);
        %% Message
        handles.message.Visible = 'on';
        m = "把时域扩充10倍，插值拟合，再取平均值，得到较好的周期波形。由图比较可知，这样处理得到的波形与给定的wave2proc几乎完全相同。";
        set(handles.message, 'string',m);
        handles.message.FontSize = 12;
        load 'Guitar.mat';
        plot(handles.axes1,realwave);
        title({'$original\ \ realwave$'},'Interpreter','latex','FontSize',16,'FontWeight','bold');
        %% preprocess
        % 重复10次，取平均
        rep_time = 10;
        len = length(realwave);
        temp = resample(realwave,rep_time,1);
        waverepeat = repmat(temp,rep_time,1);
        for i = 1:rep_time-1
            waverepeat(1:len) = waverepeat(1:len) + waverepeat(i*len+1:i*len+len);
        end
        temp = waverepeat(1:len)/rep_time;
        waverepeat = repmat(temp,rep_time,1);
        mywave = resample(waverepeat,1,rep_time);
        
        %% 绘图
        figure('NumberTitle','off','Name','my wave vs. wave2proc','Position',[100,100,800,600]);
        subplot(1,2,1);hold on;
        plot(mywave);
        set(gca,'YLim',[-0.15, 0.25],'XLim',[0, 250],'FontSize',16);
        xlabel({'$realwave\ after\ my\ process $'},'Interpreter','latex','FontSize',16,'FontWeight','bold');
        subplot(1,2,2);hold on;
        plot(wave2proc);
        set(gca,'YLim',[-0.15, 0.25],'XLim',[0, 250],'FontSize',16);
        xlabel({'$given\ wave2proc$'},'Interpreter','latex','FontSize',16,'FontWeight','bold');
        hold off;
        clear;
    case 8
        %% Statement
        a = "(8) 这段音乐的基频是多少？是哪个音调？请用傅里叶级数或者变换的方法分析它的谐"+...
            "波分量分别是什么。";
        set(handles.text, 'string', a);
        load ('Guitar.MAT');
        sig = wave2proc;
        
        %% FFT with repetition
        sig = repmat(sig,100,1);      %重复100遍
        x = fftshift(fft(sig));     %作FFT，并移动零频点到频谱中间
        f = 4000*linspace(-1,1,length(x));      %-4000到4000，共有24300个点
        amp = 2*abs(x);
        
        %% Find the Base Frequency
        benchmark = 1200;
        [~,locs] = findpeaks(amp,'MinPeakHeight',benchmark);   %寻找峰值
        loc1 = locs(round(length(locs)/2));
        for i = loc1-2:loc1+2     %在附近搜寻
            if amp(i) > benchmark
                loc_base = i;
                benchmark = amp(i);
            end
        end
        loc_dis = abs(loc_base-length(x)/2);
        freq_base = loc_dis*8000/length(x);    %基频
        
        %% Plot
        axes(handles.axes1);
        hold on;
        plot(f,amp);
        plot(freq_base,amp(loc_base),'rs');
        text(freq_base,amp(loc_base),['freq = ' num2str(freq_base) ])
        set(gca,'XLim',[-4000,4000],'YLim',[0,2000],'FontSize',10);
        title({'$base\ frequency$'},'Interpreter','latex','FontSize',16,'FontWeight','bold');
        hold off;
        %% Message
        handles.message.Visible = 'on';
        m = "把时域数据量扩充100倍，插值、取平均得到所示图形。"+...
            "找到如图标出的基频。与其最相近的是e1（329.63Hz），相对误差0.22%. "+...
            "可判断这段音乐的基频是328.9Hz，音名是e1.";
        set(handles.message,'string',m);
        handles.message.FontSize = 9.5;
        clear;
    case 9
        %% Statement
        a = "(9) 再次载入 fmt.wav ，现在要求你写一段程序，自动分析出这段乐曲的音调和节拍！";
        set(handles.text, 'string', a);
        %% Devide Music
        [index,music,sig,envelope,seg] = DivideMusic('fmt.wav');
        %% Message
        handles.message.Visible = 'on';
        m = "下图是对原音乐的节拍划分。弹出图片为对所有节拍分别分析基频的图示。"+...
            "具体数据（频率分量、各分量强度等）见生成的文件。";
        set(handles.message,'string',m);
        handles.message.FontSize = 12;
        %% plot
        axes(handles.axes1);
        plot(sig,'b');
        set(gca,'YLim',[-1, 1],'XLim',[0, 131072],'FontSize',16);
        hold on;
        plot(envelope,'m');
        plot(seg,'k');
        title({'$beat\ \ split$'},'Interpreter','latex','FontSize',14,'FontWeight','bold');
        legend('original signal','envelope','beat split line',...
            'Location','south','Orientation','horizontal');
        hold off;
        %% answer storage
        music_data = zeros(20,length(index));   %每个音符所含的谐波频率
        time = zeros(length(index),1);  %每个音符所占的时长
        %% Analyze each Beat
        figure('NumberTitle','off','Name','Base Frequency for each Beat');
        for k = 1:length(index)
            %节选出beat
            if k < length(index)
                beat = music(index(k):index(k+1)-1);
            else
                beat = music(index(k):length(music));
            end
            %计算时间，依据是这段音乐全长16秒
            time(k) = length(beat)*16/length(music);
            subplot(4,8,k);
            
            basic_info = Process(beat,k);
            music_data(:,k) = basic_info;   %把解析出来的频率数据存入music_data
        end
        
        %% answer output
        music_data = [music_data;time']';
        xlswrite("music_data.xlsx",music_data);
        %% clear
        clear;
    case 10
        %% Statement
        a = "(10) 用 (7) 计算出来的傅里叶级数再次完成第 (4) 题，听一听是否像演奏 fmt.wav 的吉"+...
            "他演奏出来的？";
        set(handles.text, 'string', a);
        %% Note
        note = @(freq,t)(sin(freq*2*pi*t)...
            +0.958*sin(3*freq*2*pi*t))...
            .*exp(5*-t);
        
        la_1 = @(t)note(296.66,t);%la_1, f = 296.66Hz
        do = @(t)note(349.23,t);%do, f = 349.23Hz
        re = @(t)note(392,t);%do, f = 392Hz
        so = @(t)note(523.25,t);%so, f = 523.25Hz
        la = @(t)note(587.33,t);%la, f = 587.33Hz
        %% 东方红
        meter1 = [so(t(1)) so(t(0.5)) la(t(0.5)) re(t(2))];%东方红
        meter2 = [do(t(1)) do(t(0.5)) la_1(t(0.5)) re(t(2))];%太阳升
        line = [meter1 meter2]';
        sound(line,fs);
        plot(handles.axes1,line);
        %% Message
        handles.message.Visible = 'on';
        m = "吉他版《东方红》";
        set(handles.message,'string',m);
        handles.message.FontSize = 12;
        clear;
    case 11
        %% Statement
        a = "(11) 对于一把泛音丰富的吉他而言，不可能每个音调对应的"+...
            "泛音数量和幅度都相同。但是通过完成第 (8) 题，你已经提取出 fmt.wav 中的很多音调，或"+...
            "者说，掌握了每个音调对应的傅里叶级数，大致了解了这把吉他的特征。现在就来演奏一"+...
            "曲《东方红》吧。";
        set(handles.text, 'string', a);
        %% Message
        handles.message.Visible = 'on';
        m = "吉他版《东方红》，添加了多重分量";
        set(handles.message,'string',m);
        handles.message.FontSize = 12;
        %% play music
        music_data = xlsread('music_data.xlsx','sheet1','a1:u31');
        ampl = music_data(17,11:20);
        
        note = @(freq,t)(...
            ampl(1) * sin(freq*2*pi*t)+...
            ampl(2) * sin(2*freq*2*pi*t)+...
            ampl(3) * sin(3*freq*2*pi*t)+...
            ampl(4) * sin(4*freq*2*pi*t)+...
            ampl(6) * sin(6*freq*2*pi*t))...
            .*exp(3*-t);
        
        la_1 = @(t)note(296.66,t);%la_1, f = 296.66Hz
        do = @(t)note(349.23,t);%do, f = 349.23Hz
        re = @(t)note(392,t);%do, f = 392Hz
        so = @(t)note(523.25,t);%so, f = 523.25Hz
        la = @(t)note(587.33,t);%la, f = 587.33Hz
        
        meter1 = [so(t(1)) so(t(0.5)) la(t(0.5)) re(t(2))];%东方红
        meter2 = [do(t(1)) do(t(0.5)) la_1(t(0.5)) re(t(2))];%太阳升
        line = [meter1 meter2]';
        sound(line,fs);
        plot(handles.axes1,line);
        %% clear
        clear;
    case 12
        %% Statement
        a = "(12) 现在只要你掌握了某乐器足够多的演奏资料，就可以合成出该乐器演奏的任何音"+...
            "乐，在学完本书后面内容之后，试着做一个图形界面把上述功能封装起来";
        set(handles.text, 'string', a);
        %% Message
        handles.pushbutton1.Visible = 'on';
        handles.pushbutton2.Visible = 'on';
        im = imread('bg(2).jpg');
        handles.message.Visible = 'off';
        handles.namecard.Visible = 'on';
        axes(handles.axes1);
        imshow(im);
        %
        %
end


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile(...
    {'*.wav;*.mp3','audios (*.wav;*.mp3)'},'请选择要解析的音乐');
audio = audioread([pathname '\' filename]);
handles.audio = audio;
guidata(hObject, handles);
axes(handles.axes1);
plot(audio);
if (~isempty(audio))
    %% Devide Music
    [index,music,sig,envelope,seg] = DivideMusic(filename);
    %% plot
    axes(handles.axes1);
    plot(sig,'b');
    set(gca,'YLim',[-1, 1],'FontSize',14);
    hold on;
    plot(envelope,'m');
    plot(seg,'k');
    title(filename,'FontSize',16,'FontWeight','bold');
    hold off;
    %% answer storage
    music_data = zeros(20,length(index));   %每个音符所含的谐波频率
    time = zeros(length(index),1);  %每个音符所占的时长
    %% Analyze each Beat
    for k = 1:length(index)
        %节选出beat
        if k < length(index)
            beat = music(index(k):index(k+1)-1);
        else
            beat = music(index(k):length(music));
        end
        %计算时间，依据是这段音乐全长16秒
        time(k) = length(beat)*16/length(music);
        
        basic_info = Process_12(beat);
        music_data(:,k) = basic_info;   %把解析出来的频率数据存入music_data
    end
    
    %% answer output
    music_data = [music_data;time']';
    xlswrite("music_data_12.xlsx",music_data);
    %% clear
    clear;
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% tempo
fs = 8000;  %采样率
Meter = 250;    %拍数，控制节奏
tMeter = 60 / Meter;    %一拍的时间

% 音符时值函数
t = @(beat)(0:1/fs:2*beat*tMeter);
%% play music
music_data = xlsread('music_data_12.xlsx','sheet1','a1:u31');
song = [];
for i = 1:8
    ampl = music_data(i,11:20);
    note = @(freq,t)(...
            ampl(1) * sin(freq*2*pi*t)+...
            ampl(2) * sin(2*freq*2*pi*t)+...
            ampl(3) * sin(3*freq*2*pi*t)+...
            ampl(4) * sin(4*freq*2*pi*t)+...
            ampl(6) * sin(6*freq*2*pi*t))...
            .*exp(3*-t);
    
    la_1 = @(t)note(296.66,t);%la_1, f = 296.66Hz
    do = @(t)note(349.23,t);%do, f = 349.23Hz
    re = @(t)note(392,t);%do, f = 392Hz
    so = @(t)note(523.25,t);%so, f = 523.25Hz
    la = @(t)note(587.33,t);%la, f = 587.33Hz
    
    meter1 = [so(t(1)) so(t(0.5)) la(t(0.5)) re(t(2))];%东方红
    meter2 = [do(t(1)) do(t(0.5)) la_1(t(0.5)) re(t(2))];%太阳升
    line = [meter1 meter2]';
    sound(line,fs);
    hold off;
    axes(handles.axes1);
    plot(line);
    
end
sound(song,fs);
