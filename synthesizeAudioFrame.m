% This function takes two frames of amplitude and frequency data for twenty
% partials, interpolates linearly between them and synthesizes an audio signal.
function [audioFrame] = synthesizeAudioFrame(   frequenciesStart, ... 
                                                frequenciesEnd, ...
                                                amplitudesStart, ...
                                                amplitudesEnd, ...
                                                frameSize, ...
                                                tStart, f0, fs)
                                                   
% Calculate number of partials                                                        
nPartials = length(frequenciesStart);

% Initialize local time vector, starting at end of previous frame
t = tStart:tStart+frameSize-1;

% Initialize audio frame vector
audioFrame = zeros(nPartials, length(t));

% Interpolate between amplitude and frequency frames, 
% then calculate sine signals for each partial
for i = 1:nPartials
    
    % Frequency interpolation
    frequency = linspace(frequenciesStart(i), frequenciesEnd(i), frameSize);
    
    % Amplitude interpolation
    amplitude = linspace(amplitudesStart(i), amplitudesEnd(i), frameSize);
    
    % Calculate sine signal for this partial
    audioFrame(i, :) = amplitude .* (sin((2 * pi * f0*i / fs) * ...
                                        (t + (frequency-f0*i))));
                                    
end

% We sum all partials together and output the compound signal
audioFrame = sum(audioFrame, 1);

end