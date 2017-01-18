function [BR, RTi125] = get_BR(h, fs)
%function for calculating the Bassratio based on RT for frequencies T125Hz,
%T250Hz, T500Hz, T1000Hz
%input parameters:
%h: signal
%fs: sampling frequency
%
%output paramters:
%BR :Bassratio
%RTi125 : RT60 per frequency

%init vector for ouput parameter
RTi125 = zeros(1,4);

for i = 1:4
    
    %create filter coefficient, butterworth 3rd order
    [b,a] = butter(3,[(2^(i-1))*125/sqrt(2) (2^(i-1))*125*sqrt(2)]/(fs/2));
    %filter signal
    h_filtered = filter(b,a,h);
%     fvtool(b,a, 'Fs', fs);
%     thisSpectrum = abs(fft(filter(b,a,ones(length(h_filtered), 1)))); % compute spectrum of current frame
%     oneSideThisSpectrum = thisSpectrum(1:round(length(thisSpectrum)/2)); % consider only half of spectrum
%     semilogx(oneSideThisSpectrum);
%     hold on

    %call RT60 and write to vector
    RTi125(1,i) = get_RT60(h_filtered, fs);

end

%calculate BR
BR = ((RTi125(1,1) + RTi125(1,2)) / (RTi125(1,3) + RTi125(1,4)));

end