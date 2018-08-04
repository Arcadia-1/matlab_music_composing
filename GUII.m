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
fs = 8000;  %������
Meter = 250;    %���������ƽ���
tMeter = 60 / Meter;    %һ�ĵ�ʱ��

% ����ʱֵ����
t = @(beat)(0:1/fs:2*beat*tMeter);

%% Switch case
A= get(handles.listbox1,'value');

switch A
    case 1
        %% Statement
        a = "(1) ����ݡ������졷Ƭ�ϵļ��׺͡�ʮ��ƽ���ɡ��������Ƭ���и���������Ƶ�ʣ�"+...
            "�� MATLAB �����ɷ���Ϊ 1 ������Ƶ��Ϊ 8kHz �������źű�ʾ��Щ���������� sound ��"+...
            "������ÿ����������һ�������Ƿ���ȷ���������һϵ�������ź�ƴ���������졷Ƭ�ϣ�ע"+...
            "�����ÿ������������ʱ��Ҫ���Ͻ��ģ��� sound ������ϳɵ����֣��������о���Σ�";
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
        m1 = "��Ƭ���и���������Ƶ��Ϊ��la_1: 296.66Hz, do: 349.23Hz, re: 392Hz, so: 523.25Hz, la: 587.33Hz. "+...
            "�����������档�����������Ե�""ž""������";
        set(handles.message, 'string',m1);
        handles.message.FontSize = 12;
        
        
        %% ������
        meter1 = [so(t(1)) so(t(0.5)) la(t(0.5)) re(t(2))];%������
        meter2 = [do(t(1)) do(t(0.5)) la_1(t(0.5)) re(t(2))];%̫����
        line = [meter1 meter2]';
        sound(line,fs);
        plot(handles.axes1,line);
        title({'$signal\ =\ sin(t)$'},'Interpreter','latex','FontSize',16,'FontWeight','bold');
        clear;
    case 2
        %% Statement
        a = "(2) ��һ��ע�⵽ (1) ����������������֮���С�ž��������������������λ��������"+...
            "���˸�Ƶ������������������Ӱ��ϳ����ֵ�������ɥʧ��ʵ�С�Ϊ�������������ǿ�����"+...
            "ͼ 1.5 ��ʾ��������ÿ���������Ա�֤���������ڽӴ��źŷ���Ϊ�㡣���⽨����ָ��˥"+...
            "���İ�������ʾ";
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
        m1 = "��(1)�Ļ��������ָ��˥����";
        set(handles.message, 'string',m1);
        %% ������
        meter1 = [so(t(1)) so(t(0.5)) la(t(0.5)) re(t(2))];%������
        meter2 = [do(t(1)) do(t(0.5)) la_1(t(0.5)) re(t(2))];%̫����
        line = [meter1 meter2]';
        sound(line,fs);
        plot(handles.axes1,line);
        title({'$signal\ =\ sin(t)\ *\ e^{-t}$'},'Interpreter','latex','FontSize',16,'FontWeight','bold');
        clear;
    case 3
        %% Statement
        a = "(3) ������򵥵ķ����� (2) �е����ֱַ����ߺͽ���һ���˶ȡ� ����ʾ�����ֲ��ŵ�"+...
            "ʱ����Ա仯������һЩ������ resample ������Ҳ������ interp �� decimate ������������"+...
            "�������߰������";
        set(handles.text, 'string', a);
        
        %% Note
        note = @(freq,t)(sin(freq*2*pi*t)).*exp(2*-t);
        
        la_1 = @(t)note(296.66,t);%la_1, f = 296.66Hz
        do = @(t)note(349.23,t);%do, f = 349.23Hz
        re = @(t)note(392,t);%do, f = 392Hz
        so = @(t)note(523.25,t);%so, f = 523.25Hz
        la = @(t)note(587.33,t);%la, f = 587.33Hz
        %% ����/����n��
        lift = @(n,t)resample(t,fs,round(2^(n/12))*fs);
        drop = @(n,t)resample(t,fs,fs/round(2^(n/12)));
        %% Message
        handles.message.Visible = 'on';
        handles.message.FontSize = 16;
        m = "����һ���˶� & ����һ���˶�.";
        set(handles.message, 'string',m);
        
        tt = @(beat)drop(6,t(beat));
        
        sig = do(tt(0.125));
        plot(sig);
        plot(handles.axes1,sig);
        title({'$one\ \ octave\ \ lower$'},'Interpreter','latex','FontSize',16,'FontWeight','bold');
        %% ������
        meter1 = [so(tt(0.5)) so(tt(0.25)) la(tt(0.25)) re(tt(1))];%������
        meter2 = [do(tt(0.5)) do(tt(0.25)) la_1(tt(0.25)) re(tt(1))];%̫����
        line = [meter1 meter2]';
        sound(line,0.5*fs);
        pause(4);
        %% Message
        tt = @(beat)lift(8,t(beat));
        
        sig = do(tt(0.25));
        plot(sig);
        plot(handles.axes1,sig);
        title({'$one\,\,octave\,\,higher$'},'Interpreter','latex','FontSize',16,'FontWeight','bold');
        %% ������
        meter1 = [so(tt(2)) so(tt(1)) la(tt(1)) re(tt(4))];%������
        meter2 = [do(tt(2)) do(tt(1)) la_1(tt(1)) re(tt(4))];%̫����
        line = [meter1 meter2]';
        sound(line,fs);
        clear;
    case 4
        %% Statement
        a = "(4) ������ (2) ������������һЩг����������һ�������Ƿ���С���ȡ��ˣ�ע��г"+...
            "������������ҪС�������ڸ�ס�������������������ˡ� �����ѡ���������Ϊ 1 ������г"+...
            "������ 0.2 ������г������ 0.3 ����������������٣���";
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
        m = "������ģ�ͽ����ʵ�����񶯵�г����������������Ϊ0.936 ������г������0.011 ������г������0.011.��������Ժ��أ�����������";
        set(handles.message, 'string',m);
        sig = do(t(2));
        plot(handles.axes1,sig);
        title({'$signal = 0.936*sin(t) + 0.110*sin(2t) + 0.011*sin(3t)$'},'Interpreter','latex','FontSize',16,'FontWeight','bold');
        %% ������
        meter1 = [so(t(1)) so(t(0.5)) la(t(0.5)) re(t(2))];%������
        meter2 = [do(t(1)) do(t(0.5)) la_1(t(0.5)) re(t(2))];%̫����
        line = [meter1 meter2]';
        sound(line,fs);
        clear;
    case 5
        %% Statement
        a = "(5) ��ѡ�������ֺϳ�";
        set(handles.text, 'string', a);
        
        %% ����Ƶ�ʺ���
        note = @(freq,t)(sin(freq*2*pi*t)...
            +0.4*sin(freq*2*2*pi*t)...
            +0.3*sin(freq*3*2*pi*t)...
            +0.1*sin(freq*5*2*pi*t))...
            .*exp(-2*t);     %ָ��˥�����ڴ˽��а��硢���Σ�
        %+0.4*sin(freq*4*2*pi*(t+0.01*pi))...
        %% ����
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
        m = "���簮�����⣨��ѡ�������.";
        set(handles.message, 'string',m);
        im = imread('���簮������.jpg');
        axes(handles.axes1);
        imshow(im);
        %% ���簮����������
        %����ʱ��
        t05 = t(0.5);t1 = t(1);t15 = t(1.5);t2 = t(2);t3 = t(3);
        
        %�ж��ٰ���ֻ��ңң���� �����¹������� ���ٵ���������Ϊ �మ���˾��ܵ���Զ
        meter7 = [mi(t05) so(t05) la(t2) la(t1) so(t2) mi(t05) re(t05) mi(t15) fa(t05) mi(t05) re(t05) do(t2)];
        meter8 = [la_1(t05) xi_1(t05) do(t2) re(t05) mi(t05) re(t15) xi_1(t05) so_1(t1) la_1(t3) zero(t3)];
        meter9 = [mi(t2) mi(t1) re(t15) do(t05) xi_1(t1) do(t2) re(t1) mi(t2)];
        meter10 = [mi(t05) so(t05) la(t2) la(t1) xi(t15) la(t05) so(t05) re(t05) mi(t3)];
        
        line = [meter7 meter8 meter9 meter10];
        
        sound(line,fs);
        clear;
    case 6
        %% Statement
        a = "(6) ���� wavread ������������е� fmt.wav �ļ������ų�������Ч����Σ��Ƿ�ȸ�"+...
            "�ŵĺϳ�������ʵ���ˣ�";
        set(handles.text, 'string', a);
        %% Message
        handles.message.Visible = 'on';
        m = "ʹ��audioread('fmt.wav')ֱ�Ӷ�ȡ���֡�";
        handles.message.FontSize = 16;
        set(handles.message, 'string',m);
        a = 3*audioread('fmt.wav');
        plot(handles.axes1,a);
        title({'$sound\ \ wave$'},'Interpreter','latex','FontSize',16,'FontWeight','bold');
        %% Sound
        sound(a);
        
    case 7
        %% Statement
        a = "(7) ��֪��������� wave2proc ����δ���ʵֵ realwave �еõ���ô�����Ԥ�����"+...
            "�̿���ȥ����ʵ�����еķ�����г����������������ȷ���������Ƿǳ���Ҫ�ġ���ʾ����"+...
            "ʱ���������Լ���ʹ�� resample ������";
        set(handles.text, 'string', a);
        %% Message
        handles.message.Visible = 'on';
        m = "��ʱ������10������ֵ��ϣ���ȡƽ��ֵ���õ��Ϻõ����ڲ��Ρ���ͼ�ȽϿ�֪����������õ��Ĳ����������wave2proc������ȫ��ͬ��";
        set(handles.message, 'string',m);
        handles.message.FontSize = 12;
        load 'Guitar.mat';
        plot(handles.axes1,realwave);
        title({'$original\ \ realwave$'},'Interpreter','latex','FontSize',16,'FontWeight','bold');
        %% preprocess
        % �ظ�10�Σ�ȡƽ��
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
        
        %% ��ͼ
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
        a = "(8) ������ֵĻ�Ƶ�Ƕ��٣����ĸ����������ø���Ҷ�������߱任�ķ�����������г"+...
            "�������ֱ���ʲô��";
        set(handles.text, 'string', a);
        load ('Guitar.MAT');
        sig = wave2proc;
        
        %% FFT with repetition
        sig = repmat(sig,100,1);      %�ظ�100��
        x = fftshift(fft(sig));     %��FFT�����ƶ���Ƶ�㵽Ƶ���м�
        f = 4000*linspace(-1,1,length(x));      %-4000��4000������24300����
        amp = 2*abs(x);
        
        %% Find the Base Frequency
        benchmark = 1200;
        [~,locs] = findpeaks(amp,'MinPeakHeight',benchmark);   %Ѱ�ҷ�ֵ
        loc1 = locs(round(length(locs)/2));
        for i = loc1-2:loc1+2     %�ڸ�����Ѱ
            if amp(i) > benchmark
                loc_base = i;
                benchmark = amp(i);
            end
        end
        loc_dis = abs(loc_base-length(x)/2);
        freq_base = loc_dis*8000/length(x);    %��Ƶ
        
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
        m = "��ʱ������������100������ֵ��ȡƽ���õ���ʾͼ�Ρ�"+...
            "�ҵ���ͼ����Ļ�Ƶ���������������e1��329.63Hz����������0.22%. "+...
            "���ж�������ֵĻ�Ƶ��328.9Hz��������e1.";
        set(handles.message,'string',m);
        handles.message.FontSize = 9.5;
        clear;
    case 9
        %% Statement
        a = "(9) �ٴ����� fmt.wav ������Ҫ����дһ�γ����Զ���������������������ͽ��ģ�";
        set(handles.text, 'string', a);
        %% Devide Music
        [index,music,sig,envelope,seg] = DivideMusic('fmt.wav');
        %% Message
        handles.message.Visible = 'on';
        m = "��ͼ�Ƕ�ԭ���ֵĽ��Ļ��֡�����ͼƬΪ�����н��ķֱ������Ƶ��ͼʾ��"+...
            "�������ݣ�Ƶ�ʷ�����������ǿ�ȵȣ������ɵ��ļ���";
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
        music_data = zeros(20,length(index));   %ÿ������������г��Ƶ��
        time = zeros(length(index),1);  %ÿ��������ռ��ʱ��
        %% Analyze each Beat
        figure('NumberTitle','off','Name','Base Frequency for each Beat');
        for k = 1:length(index)
            %��ѡ��beat
            if k < length(index)
                beat = music(index(k):index(k+1)-1);
            else
                beat = music(index(k):length(music));
            end
            %����ʱ�䣬�������������ȫ��16��
            time(k) = length(beat)*16/length(music);
            subplot(4,8,k);
            
            basic_info = Process(beat,k);
            music_data(:,k) = basic_info;   %�ѽ���������Ƶ�����ݴ���music_data
        end
        
        %% answer output
        music_data = [music_data;time']';
        xlswrite("music_data.xlsx",music_data);
        %% clear
        clear;
    case 10
        %% Statement
        a = "(10) �� (7) ��������ĸ���Ҷ�����ٴ���ɵ� (4) �⣬��һ���Ƿ������� fmt.wav �ļ�"+...
            "����������ģ�";
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
        %% ������
        meter1 = [so(t(1)) so(t(0.5)) la(t(0.5)) re(t(2))];%������
        meter2 = [do(t(1)) do(t(0.5)) la_1(t(0.5)) re(t(2))];%̫����
        line = [meter1 meter2]';
        sound(line,fs);
        plot(handles.axes1,line);
        %% Message
        handles.message.Visible = 'on';
        m = "�����桶�����졷";
        set(handles.message,'string',m);
        handles.message.FontSize = 12;
        clear;
    case 11
        %% Statement
        a = "(11) ����һ�ѷ����ḻ�ļ������ԣ�������ÿ��������Ӧ��"+...
            "���������ͷ��ȶ���ͬ������ͨ����ɵ� (8) �⣬���Ѿ���ȡ�� fmt.wav �еĺܶ���������"+...
            "��˵��������ÿ��������Ӧ�ĸ���Ҷ�����������˽�����Ѽ��������������ھ�������һ"+...
            "���������졷�ɡ�";
        set(handles.text, 'string', a);
        %% Message
        handles.message.Visible = 'on';
        m = "�����桶�����졷������˶��ط���";
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
        
        meter1 = [so(t(1)) so(t(0.5)) la(t(0.5)) re(t(2))];%������
        meter2 = [do(t(1)) do(t(0.5)) la_1(t(0.5)) re(t(2))];%̫����
        line = [meter1 meter2]';
        sound(line,fs);
        plot(handles.axes1,line);
        %% clear
        clear;
    case 12
        %% Statement
        a = "(12) ����ֻҪ��������ĳ�����㹻����������ϣ��Ϳ��Ժϳɳ�������������κ���"+...
            "�֣���ѧ�걾���������֮��������һ��ͼ�ν�����������ܷ�װ����";
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
    {'*.wav;*.mp3','audios (*.wav;*.mp3)'},'��ѡ��Ҫ����������');
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
    music_data = zeros(20,length(index));   %ÿ������������г��Ƶ��
    time = zeros(length(index),1);  %ÿ��������ռ��ʱ��
    %% Analyze each Beat
    for k = 1:length(index)
        %��ѡ��beat
        if k < length(index)
            beat = music(index(k):index(k+1)-1);
        else
            beat = music(index(k):length(music));
        end
        %����ʱ�䣬�������������ȫ��16��
        time(k) = length(beat)*16/length(music);
        
        basic_info = Process_12(beat);
        music_data(:,k) = basic_info;   %�ѽ���������Ƶ�����ݴ���music_data
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
fs = 8000;  %������
Meter = 250;    %���������ƽ���
tMeter = 60 / Meter;    %һ�ĵ�ʱ��

% ����ʱֵ����
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
    
    meter1 = [so(t(1)) so(t(0.5)) la(t(0.5)) re(t(2))];%������
    meter2 = [do(t(1)) do(t(0.5)) la_1(t(0.5)) re(t(2))];%̫����
    line = [meter1 meter2]';
    sound(line,fs);
    hold off;
    axes(handles.axes1);
    plot(line);
    
end
sound(song,fs);
