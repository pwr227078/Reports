close all;
clear all;

% odczyt sygnalu mowy 
y=wavread('mowa_32.wav');

% dl - dlugosc sygnalu do przetwarzania
dl=90000;
y1=y(40000:40000+dl);

% yq - sygnal idealny, 16 bitowy; 
[yq]=convert(y1,16);

% Skalowanie sygnalu mowy, w systemach rzeczywistych 
% sygnaly sterujace dominuja pod wzgledem amplitudy nad
% sygnalem mowy

  yq=0.1*yq;

  delta1=0.01;
  
  k=[1.001 1.005 1.01 1.05 1.1 1.25 1.4 1.5 1.6 1.75 2.0];
  
  %k=[1.4:0.001:1.6];
  
  
licz2=length(k);

nmse=zeros(licz2,1);
sqnr=zeros(licz2,1);
u=yq'*yq;

for i=1:licz2
    
      k(i)
      [ewy,sd,delta]=admcwav(yq,delta1,k(i)); 
      ef=yq-sd';
      c=ef'*ef;      
      nmse(i)=c/u;
      sqnr(i)=10*log10(1/nmse(i));
      
      %soundsc(yq,32000);
      %pause;
      %soundsc(sd,32000);
      
      
 end; 
   
figure(1);
plot(k,sqnr);
hold;
plot(k,sqnr,'r.');
hold;
 
figure(2);
plot(yq);
hold;
plot(sd,'r');
hold;
