close all;
clear all;

% odczyt sygnalu mowy 
y=wavread('mw1.wav');

% dl - dlugosc sygnalu do przetwarzania
%dl=30000;
dl=30000
y1=y(40000:40000+dl);

% yq - sygnal idealny, 16 bitowy; 
[yq]=convert(y1,16);

% Skalowanie sygnalu mowy, w systemach rzeczywistych 
% sygnaly sterujace dominuja pod wzgledem amplitudy nad
% sygnalem mowy
yq=0.1*yq;

% tablica dlugosci filtru 
p=[0 3 5 8 10 15 20];


licz1=length(p);

% alp1 - wzmocnienie
alp1=10;
gam1=0.00001;

% u - energia sygnalu wejsciowego
u=yq'*yq;

for i=1:licz1
    
  p(i) 
  [sd,ewy,ep]=adpcm_4b(yq,p(i),alp1,gam1);
  ef=yq-sd';
  c=ef'*ef;      
  nmse(i)=c/u;
  sqnr(i)=10*log10(1/nmse(i));
 
  %figure(i);
  %plot(yq,'g');
  %hold;
  %plot(sd,'r');
  %hold;
  
  %soundsc(yq);
  %pause;
  %soundsc(sd);
  
end;

figure(1);
plot(p,sqnr);
hold;
plot(p,sqnr,'r.');
hold;

