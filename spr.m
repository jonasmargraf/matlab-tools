function [ output ] = spr( X, Y )
%this function calculates the spectral spread of a given spectrum X

N=length(X);
c=zeros(1,N);
y=0;
x=0;

cor = xcorr(Y,Y);           % compute spectral density with autocorrelation 
lds = abs(fft(cor));        % and spectrum of autocorrelation of given signal
z=sum(lds);                 % compute mean value of spectral density

mid=z/N;
 

    for c = 1:N;
        
        y = y + (((c-mid)^2) * (X(c)^2));
        x = x + (X(c)^2);
        
    end

    output = sqrt(y/x);

end

