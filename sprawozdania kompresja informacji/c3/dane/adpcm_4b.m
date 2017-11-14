function [sq,ewy,ep]=adpcm_4b(s,p,alp,gam)
% adaptacyjny DPCM - koder z kwantyzatorem czterobitowym
% WE:  s - sygnal do kwantyzacji (w probkach)
%      p - rzad filtru predykcyjnego
%      alp - wzmocnienie procesu predykcji
%      gam - stala adaptacji  
% WY:  sq - sygnal odtwarzany w dekoderze
%      ewy - sygnal wyjsciowy z kodera 

% Ustalenie warunkow poczatkowych 
ds=length(s);

bufp=zeros(1,p);
a=zeros(1,p);

% warunki poczatkowe dla procesu adaptacji 
e(1)=s(1);

delta1=0.1;
delta2=0.1;

% kwantyzer dynamiczny
[ewy(1),delta1,nump(1)]=kwant_eq(e(1),delta1);   

% dekwantyzer dynamiczny
[ep(1),delta2]=dec_im(nump(1),delta2);

sd(1)=0;
sq(1)=0;

ngam=1-(alp*gam);

for i=2:ds
            
   % blok predykcji
   
   if (p>0)
     
       sd(i)=a*bufp';
       
   else
       
       sd(i)=0;
   
   end;  
     
   % blad kwantyzacji
   e(i)=s(i)-sd(i);
   
   % blok kwantyzera
   % kwantyzer dynamiczny
   [ewy(i),delta1,nump(i)]=kwant_eq(e(i),delta1);   
   
   % blok dekwantyzera
   % dekwantyzer dynamiczny
   [ep(i),delta2]=dec_im(nump(i),delta2);

   % wezel sumacyjny - wyznaczanie sygnalu sq
   sq(i)=sd(i)+ep(i);
   
   % aktualizacja bufora
   bufp=[sq(i) bufp(1:p-1)];
  
   % blok adaptacji wag
   
   if (p>0)
       
       a=(a*ngam)+(bufp*ep(i)*alp);
       
   end;    
   
   % aktualizacja bufora
   %bufp=[ep(i) bufp(1:p-1)];
   
   if (mod(i,5000)==0)
     i
   end;
    
end;



