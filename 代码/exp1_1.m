[filename,filepath]=uigetfile({'*.mp3';'*.wav';'*.*'},'File Selector');
[x,fs]=audioread([filepath,filename]);  %从电脑文件夹选择音频文件
x=x(:,1);
ts=length(x);
ts=(0:ts-1)/fs;%时间长度时间
Fre=7000;%噪声频率
no=0.2*sin(2*pi*Fre*ts)';%randn加入随机噪声
y=x+no;

wp=2*pi*5000/44100;
ws=2*pi*7000/44100;
Rp=1;
Rs=80;
Ts=1/fs;
wp1=2/Ts*tan(wp/2);                 %将模拟指标转换成数字指标
ws1=2/Ts*tan(ws/2); 
[N,Wn]=buttord(wp1,ws1,Rp,Rs,'s');  %选择滤波器的最小阶数
[B,A]=butter(N,Wn,'s') ;  
[bz,az]=bilinear(B,A,fs);      %用双线性变换法实现模拟滤波器到数字滤波器的转换
[H,W]=freqz(bz,az);                 %绘制频率响应曲线
figure(1)
plot(W*fs/(2*pi),abs(H))
grid
f1=filter(bz,az,y);
figure(2)
subplot(2,2,1)
plot(y)                          %画出滤波前的时域图
title('滤波前的时域波形');
subplot(2,2,2)
plot(f1);                         %画出滤波后的时域图
title('滤波后的时域波形');
% sound(f1);                    %播放滤波后的信号

Y=fft(y,1024);
f=fs*(0:511)/1024;
subplot(2,2,3);
plot(f,abs(Y(1:512)));             %画出滤波前的频谱图
title('滤波前的频谱')
xlabel('频率');
ylabel('幅值');
subplot(2,2,4)
F1=fft(f1,1024);
plot(f,abs(F1(1:512)));          %画出滤波后的频谱图
title('滤波后的频谱')
xlabel('频率');
ylabel('幅值');


% 
% subplot(2,2,4)
% Y2=fft(f1,1024);           %对信号做1024点FFT变换
% f=fs*(0:511)/1024;
% plot(f,abs(Y2(1:512)));
% title('加噪语音信号频谱');
% xlabel('频率');
% ylabel('幅度');