function [ output1 ] = sfm( X )
%this function calculates the sepctral flatness of a given spectrum X

N=length(X);
    
output1=exp((1/N)*sum(log(X)))/((1/N)*sum(X));

end

