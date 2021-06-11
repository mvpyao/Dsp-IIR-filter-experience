[filename,filepath]=uigetfile({'*.mp3';'*.wav';'*.*'},'File Selector');
[x,fs]=wavread([filepath,filename]);  %�ӵ����ļ���ѡ����Ƶ�ļ�
% [x,fs]=audioread('jay.mp3');
ts=1/fs;%�ź�ȡ������
t=0:ts:(length(x)-1)*ts;%ȡ�������źŵ�ʱ��
x=x(:,1);%ȡ������
Au=0.1;Fre=6000;%���������źŷ��Ⱥ�Ƶ��
d=[Au*sin(2*pi*Fre*t)]';
y=x+d;
w_no=2*pi*Fre/fs;%�������ֽ�Ƶ�ʣ�����ȷ��wp
wp=w_no*0.8;
ws=w_no*1;
wdelta=ws-wp;
N=ceil(8*pi/wdelta);              %ȡ��
wn=(wp+ws)/2;
[b,a]=fir1(N,wn/pi,hamming(N+1));       %ѡ�񴰺���������һ����ֹƵ��
figure(21)
freqz(b,a,512);
title('FIR��ͨ�˲���');

y1=filter(b,a,y);
figure(22)
subplot(2,1,1)
plot(y)
title('FIR��ͨ�˲����˲�ǰ��ʱ����');
xlabel('ʱ�䣨ms)'); 
ylabel('��ֵ'); 
subplot(2,1,2)
plot(y1);
title('FIR��ͨ�˲����˲����ʱ����');
xlabel('ʱ�䣨ms)'); 
ylabel('��ֵ');    

Y=fft(y,1024);
f=fs*(0:511)/1024;
figure(23)
Y1=fft(y1,1024);
subplot(2,1,1);
plot(f,abs(Y(1:512)));
title('FIR��ͨ�˲����˲�ǰ��Ƶ��')
xlabel('Ƶ��/Hz');
ylabel('��ֵ');
subplot(2,1,2)
plot(f,abs(Y1(1:512)));
title('FIR��ͨ�˲����˲����Ƶ��');
xlabel('Ƶ��/Hz');
ylabel('��ֵ');
