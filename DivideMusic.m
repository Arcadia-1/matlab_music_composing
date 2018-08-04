%% Divide function
%把一段音乐分出音节
function [index, music,sig,envelope,seg] = DivideMusic(file)
    sig = audioread(file);
    music = sig;
    sig = sig/max(abs(sig));      
    %% envelope extraction
    envelope = sig;
    winWidth = 1000;  %尝试出来的，比较合适的窗宽度    
    for k = winWidth:length(sig)
        envelope(k) = max(sig(k - winWidth + 1:k));
    end    
    %% 分割线seg
    seg = 0.5 * sign(diff(envelope));  %升/降二值化
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
    seg(1000) = 0.5;    %微调第一个音符
    index = find(seg>0);
    
    
end

%%