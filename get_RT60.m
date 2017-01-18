function [RT60_30, RT60_20, RT60] = get_RT60(h, fs)
%function for calculating RT 60, based on 60db, 20dB and 30db decrease
%input parameters:
%h: signal
%fs: sampling frequency
%
%output paramters:
%RT60 : based on 60db decrease, in s
%RT60_20 : based on 20dB decrease times 3, in s
%RT60_30 : based on  30db decrease times 2, in s


[peakValues, peakPositions] = findpeaks(abs(h)); % extract local extrema
[globalPeakValue, globalPeakPosition] = max(peakValues); % extract global extremum
soundOnsetPosition = peakPositions(globalPeakPosition-1); % find extremum before gobal extremum

h = h(soundOnsetPosition:end); % cut initial silence before impulse onset
EDC = 10*log10(cumsum(h.^2,'reverse')./sum(h.^2)); % calculate EDCnorm

%PLOT
figure(1);
plot(linspace(0, length(EDC)-1, length(EDC))/fs,EDC);
title('EDC_{norm} plotted over time');
xlabel('time in s');
ylabel('EDC_{norm} in dBFS');

 
RT60 = find(EDC < -60, 1)/fs; % calculate RT60


% alternative calculation of RT60
RT_start = find(EDC < -5, 1)/fs; % consider RT20, RT30 ranging up from -5dB
RT20_end = find(EDC < -25, 1)/fs;
RT30_end = find(EDC < -35, 1)/fs;
RT20 = RT20_end - RT_start;
RT30 = RT30_end - RT_start;
RT60_20 = RT20 * 3; % RT60 as triple RT20
RT30 = find(EDC < -30, 1)/fs;
RT60_30 = RT30 * 2; % RT60 as double RT30

end


