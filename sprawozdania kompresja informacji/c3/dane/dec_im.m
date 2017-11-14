function [pwy,deltan]=dec_im(nump,delta)
% odtwarzanie wartosci sygnalu pwy na podstawie nump i delta
% wejscie:
% nump - probka sygnalu
% delta - wartosc przedzialu kwantyzacji w chwili n-1
% wyjscie:
% pwy - skwantowana wartosc na wyjsciu
% deltan - wartosc przedzialu kwantyzacji w chwili n 

M=[0.90 0.90 0.90 0.90 1.20 1.60 2.00 2.40];

% ustalenie numeru poziomu kwantowania
pomoc2=nump-8;

% ustalenie poziomu kwantyzera
pwy=(pomoc2+0.5)*delta;

% aktualizacja wartosci dla przedzialu kwantyzacji
if nump<8
  numt=8-nump;
else
  numt=nump-7;
end;  

Mp=M(numt);
deltan=delta*Mp;