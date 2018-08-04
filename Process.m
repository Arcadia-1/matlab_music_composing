function [basic_info] = Process(beat,k)
%% 傅里叶处理
N = length(beat);
f = 8000*linspace(0,1,N);
temp = abs(fft(beat));
amp = temp/max(temp);
bbb = amp;
%% 获得频率分量
%找出所有的极大值
local_max_index = find(diff(sign(diff(amp)))<0)+1;  
tmp = amp(local_max_index);
amp = 0;
amp(local_max_index) = tmp;
%筛选
max_index = find(amp>0.3);
tmp = amp(max_index);
amp = 0;
amp(max_index) = tmp;
max_index = find(amp>0);
record = zeros(2,length(max_index));
record(1,:) = f(max_index);
record(2,:) = amp(max_index);
%确定基频
N = length(record(1,:));
record = [record;zeros(N)];
unit = 2^(1/24);
basic_info = zeros(10,ceil(N/2));
for t = 1:10
    for it = 1:ceil(N/2)
        bound_a = record(1,it)*t/unit;
        bound_b = record(1,it)*t*unit;        
        ind = find((record(1,:)>=bound_a) & (record(1,:)<=bound_b));
        if(length(ind)>1)
            a = find(record(2,:)==max(record(2,ind)));
            ind = a(1);
        end
        if(ind~=0)
            basic_info(t,it) = record(1,ind);
            record(3,ind) = 1;
        end
    end
end

[~,ind] = max(record(2,:));
[~,c] = find(basic_info==record(1,ind));
tmp = basic_info(:,c); %存储各谐波分量的频率
E = zeros(1,length(c));
if(length(c)>1)
    for it = 1:length(c)
        for t = 1:10
            if(tmp(t,it)~=0)
                E(it) = E(it) + record(2,record(1,:) == tmp(t,it))^2;
            end
        end
    end
    [~,c] = max(E(it));
    tmp = tmp(:,c);
end
if tmp(1)<170 %手工调整
    tmp = [tmp(2:10);0];
end

strength = zeros(10,1); %存储每一个谐波分量的强度
N = length(bbb);
freq = @(i)tmp(i);
loc = find(tmp>0);
for i=1:length(loc) 
    appr = ceil(N*freq(loc(i))/8000.0);
    it = appr-5:appr+5+1;    
    [r,l] = max(bbb(it));
    if i == 1
        base_loc = it(l);
        base_str = r;
    end
    strength(loc(i)) = r;
end
basic_info = [tmp; strength]; %返回的basic_info同时含有频率信息和强度信息
%% plot
hold on;
plot(f(1:round((N+1)/2)),bbb(1:round((N+1)/2)),'b');
plot(f(base_loc),base_str,'r*');
xlabel(['f',num2str(k),'=',num2str(freq(1))]);
end




