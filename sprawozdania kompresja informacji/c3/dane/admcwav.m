function [ewy,sd,delta]=admcwav(s,delta1,k)
% Adaptacyjna modulacja delta - wersja 1
% WE:  s    - sygnal do kwantyzacji (w probkach)
%      delta1 - wartosc poczatkowa parametru delta
%      k     - stala procesu adaptacji
%
% WY:  sd - sygnal na wyjsciu koder (MODULATORA)
%      ewy  - dyskretny blad kwantyzacji
%      delta - wartosci chwilowe parametru delta

ds=length(s);

% inicjalizacja tablic 
  ewy = zeros(1,ds); %zawiera sygnal skwantowany
  sd  = zeros(1,ds);
  e = zeros(1,ds);
  ef  = zeros(1,ds);
  delta=zeros(1,ds);

% inicjalizacja zmiennych  
  delta(1)=delta1;
 
  e(1)=s(1);
  sd(1)=0;

  if e(1) > 0
     ewy(1)=1;
  else
     ewy(1)=-1;
  end;

  ef(1)=delta(1)*ewy(1); 

for i=2:ds
   
   % aktualizacja sygna³u modelowanego 
   sd(i)=sd(i-1)+ef(i-1);
   
   % wyznaczenie bledu rekonstrukcji
   e(i)=s(i)-sd(i);
   
   % wyznaczenie wartosci wyjsciowej z kwantyzera jednobitowego
     if e(i) > 0
        ewy(i)=1;
     else
        ewy(i)=-1;
     end;
   
    % wyznaczenie nowej wartosci delta 
      if ewy(i)==ewy(i-1)
          M=k;
      else
          M=1/k;
      end;    
      
      delta(i)=delta(i-1)*M;
    
    % okreslenie poprawki 
      ef(i)=delta(i)*ewy(i);
   
   % if (mod(i,5000)==0)
       
   %  i
     
   % end;

   
end;


