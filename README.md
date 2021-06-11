# Dsp_IIR 数字信号处理IIR滤波器实验<br>

## 项目简介<br>
>>数字信号处理iir滤波器设计实验，利用音乐信号作为分析对象，考察音乐信号受单音信号或者随机噪声污染以后，利用所学知识设计数字滤波器实验滤波功能。<br>
实验用到的音乐信号一般为wav、MP3格式，采样率一般是44100 Hz。当然，任意信号都可以作为本实验的分析对象。<br>

## 项目结构<br>
>>本项目包含以下几个文件夹，其中`代码`文件夹里面是实验代码；`实验文档`文件夹是实验指导书；`音乐文件`内部是实验音乐数据。<br>

## 实现细节<br>
```Matlab
[filename,filepath]=uigetfile({'*.mp3';'*.wav';'*.*'},'File Selector');
[x,fs]=audioread([filepath,filename]);  %从电脑文件夹选择音频文件
```
>其中，uigetfile函数进行文件选取，具体格式可参考[uigetfile](https://ww2.mathworks.cn/help/matlab/ref/uigetfile.html)官方教程。<br>

```matlab
x=x(:,1);
ts=length(x);
ts=(0:ts-1)/fs;%时间长度时间
Fre=7000;%噪声频率
no=0.2*sin(2*pi*Fre*ts)';%randn加入随机噪声
y=x+no;
```
>对信号首先取单声道，这是为了方便分析，随后加入噪声。<br>
## 运行结果<br>


