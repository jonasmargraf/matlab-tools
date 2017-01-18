function [ output ] = hfc( X )
%this function calculates the high frequency content of a given spectrum X

N=length(X);
b=zeros(1,N);
y=0;
x=0;

    for b = 2:N;
        
        y = y + b * (X(b)^2);
        x = x + (X(b)^2);
        
    end

    output = y/x;
    
    
end

