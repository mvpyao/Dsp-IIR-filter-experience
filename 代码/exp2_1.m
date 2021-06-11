[filename,filepath]=uigetfile({'*.mp3';'*.wav';'*.*'},'File Selector');
[x,fs]=wavread([filepath,filename]);  %从电脑文件夹选择音频文件
% [x,fs]=audioread('jay.mp3');
ts=1/fs;%信号取样周期
t=0:ts:(length(x)-1)*ts;%取得语音信号的时间
x=x(:,1);%取单声道
Au=0.1;Fre=6000;%单音噪声信号幅度和频率
d=[Au*sin(2*pi*Fre*t)]';
y=x+d;
w_no=2*pi*Fre/fs;%噪声数字角频率，辅助确定wp
wp=w_no*0.8;
ws=w_no*1;
wdelta=ws-wp;
N=ceil(8*pi/wdelta);              %取整
wn=(wp+ws)/2;
[b,a]=fir1(N,wn/pi,hamming(N+1));       %选择窗函数，并归一化截止频率
figure(21)
freqz(b,a,512);
title('FIR低通滤波器');

y1=filter(b,a,y);
figure(22)
subplot(2,1,1)
plot(y)
title('FIR低通滤波器滤波前的时域波形');
xlabel('时间（ms)'); 
ylabel('幅值'); 
subplot(2,1,2)
plot(y1);
title('FIR低通滤波器滤波后的时域波形');
xlabel('时间（ms)'); 
ylabel('幅值');    

Y=fft(y,1024);
f=fs*(0:511)/1024;
figure(23)
Y1=fft(y1,1024);
subplot(2,1,1);
plot(f,abs(Y(1:512)));
title('FIR带通滤波器滤波前的频谱')
xlabel('频率/Hz');
ylabel('幅值');
subplot(2,1,2)
plot(f,abs(Y1(1:512)));
title('FIR低通滤波器滤波后的频谱');
xlabel('频率/Hz');
ylabel('幅值');
