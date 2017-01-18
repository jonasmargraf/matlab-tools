function [C80_125, C80_250, C80_500, C80_1000] = get_C80(h, fs)
%function for calculating the C80
%input parameters:
%h: signal
%fs: sampling frequency
%
%output paramters:
%C80_125 C80_250, C80_500, C80_1000: C80 for certain frequency

[peakValues, peakPositions] = findpeaks(abs(h)); % extract local extrema
[globalPeakValue, globalPeakPosition] = max(peakValues); % extract global extrumum
soundOnsetPosition = peakPositions(globalPeakPosition-1); % find extremum before gobal extremum

h = h(soundOnsetPosition:end); % cut initial silence before impulse onset

%init vector for ouput parameter
C80i125 = zeros(1, 4);

for i = 1:4
    
     %create filter coefficient, butterworth 3rd order
    [b,a] = butter(3,[(2^(i-1))*125/sqrt(2) (2^(i-1))*125*sqrt(2)]/(fs/2));
    %filter signal
    h_filtered = filter(b,a,h);
    %calculate C80
    C80i125(1,i) = 10*log10(sum(h_filtered(1:floor(.08*fs)).^2)/sum(h_filtered(ceil(.08*fs):end).^2));
    
end

%assing outputparameter
C80_125 = C80i125(1,1);
C80_250 = C80i125(1,2);
C80_500 = C80i125(1,3);
C80_1000 = C80i125(1,4);
end


