%% Divide function
%��һ�����ֳַ�����
function [index, music,sig,envelope,seg] = DivideMusic(file)
    sig = audioread(file);
    music = sig;
    sig = sig/max(abs(sig));      
    %% envelope extraction
    envelope = sig;
    winWidth = 1000;  %���Գ����ģ��ȽϺ��ʵĴ����    
    for k = winWidth:length(sig)
        envelope(k) = max(sig(k - winWidth + 1:k));
    end    
    %% �ָ���seg
    seg = 0.5 * sign(diff(envelope));  %��/����ֵ��
    seg(seg<0) = 0;
    seg(1:winWidth) = 0;    
    index = find(seg>0);
    len = 200;
    for k = 1:length(index)
        if(index(k) + len < length(sig))
            m = max(envelope(index(k):index(k)+len));
        end
        if(m-envelope(index(k))<0.05)
            seg(index(k)) = 0;
        end
    end    
    index = find(seg>0);    
	for k = 1:length(index)
        if(seg(index(k))>0)
            seg(index(k)+1:index(k)+winWidth) = 0;
        end
    end    
    seg(1000) = 0.5;    %΢����һ������
    index = find(seg>0);
    
    
end

%%