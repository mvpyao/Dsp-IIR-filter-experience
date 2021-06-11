[filename,filepath]=uigetfile({'*.mp3';'*.wav';'*.*'},'File Selector');
[x,fs]=audioread([filepath,filename]);  %�ӵ����ļ���ѡ����Ƶ�ļ�
x=x(:,1);
ts=length(x);
ts=(0:ts-1)/fs;%ʱ�䳤��ʱ��
Fre=7000;%����Ƶ��
no=0.2*sin(2*pi*Fre*ts)';%randn�����������
y=x+no;

wp=2*pi*5000/44100;
ws=2*pi*7000/44100;
Rp=1;
Rs=80;
Ts=1/fs;
wp1=2/Ts*tan(wp/2);                 %��ģ��ָ��ת��������ָ��
ws1=2/Ts*tan(ws/2); 
[N,Wn]=buttord(wp1,ws1,Rp,Rs,'s');  %ѡ���˲�������С����
[B,A]=butter(N,Wn,'s') ;  
[bz,az]=bilinear(B,A,fs);      %��˫���Ա任��ʵ��ģ���˲����������˲�����ת��
[H,W]=freqz(bz,az);                 %����Ƶ����Ӧ����
figure(1)
plot(W*fs/(2*pi),abs(H))
grid
f1=filter(bz,az,y);
figure(2)
subplot(2,2,1)
plot(y)                          %�����˲�ǰ��ʱ��ͼ
title('�˲�ǰ��ʱ����');
subplot(2,2,2)
plot(f1);                         %�����˲����ʱ��ͼ
title('�˲����ʱ����');
% sound(f1);                    %�����˲�����ź�

Y=fft(y,1024);
f=fs*(0:511)/1024;
subplot(2,2,3);
plot(f,abs(Y(1:512)));             %�����˲�ǰ��Ƶ��ͼ
title('�˲�ǰ��Ƶ��')
xlabel('Ƶ��');
ylabel('��ֵ');
subplot(2,2,4)
F1=fft(f1,1024);
plot(f,abs(F1(1:512)));          %�����˲����Ƶ��ͼ
title('�˲����Ƶ��')
xlabel('Ƶ��');
ylabel('��ֵ');


% 
% subplot(2,2,4)
% Y2=fft(f1,1024);           %���ź���1024��FFT�任
% f=fs*(0:511)/1024;
% plot(f,abs(Y2(1:512)));
% title('���������ź�Ƶ��');
% xlabel('Ƶ��');
% ylabel('����');