close all;
clear all;

% odczyt sygnalu mowy 
y=wavread('mowa_32.wav');

% dl - dlugosc sygnalu do przetwarzania
dl=32000;
y1=y(40000:40000+dl);

% yq - sygnal idealny, 16 bitowy; 
[yq]=convert(y1,16);

% Skalowanie sygnalu mowy, w systemach rzeczywistych 
% sygnaly sterujace dominuja pod wzgledem amplitudy nad
% sygnalem mowy
yq=0.1*yq;

delta1=[0.01 0.1 0.5];
k=[1.01  1.1 1.5 2.0];
 
licz1=length(delta1);
licz2=length(k);

for i=1:licz2
   k(i)
   figure(i);
   for j=1:licz1
      
      [ewy,sd,delta]=admcwav(yq,delta1(j),k(i)); 
    
      if j==1
         plot(delta);     
         hold;
      end;
      
      if j==2
          
         plot(delta,'r');    
          
      end;    
      
      if j==3
          
         plot(delta,'g');    
          
      end;   
      
      if j==4
          
         plot(delta,'m');    
          
      end;  
   
    end;
    
   hold;
   
end;   

 
   