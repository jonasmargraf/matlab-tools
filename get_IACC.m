function [IACC_i125_early, IACC_i125_late] = get_IACC(h_bin, fs_bin)
%function for calculating interaural cross-correlation coefficients for frequencies T125Hz,
%T250Hz, T500Hz, T1000Hz
%input parameters:
%h_bin: binaural signal
%fs_bin: sampling frequency
%
%output paramters:
%IACC_i125_early: IACC_early for 4 bands 
%IACC_i125_late : IACC_late for 4 bands

p_L = h_bin(:,1); % left channel
p_R = h_bin(:,2); % right channel

[peakValues, peakPositions] = findpeaks(abs(p_L)); % extract local extrema
[globalPeakValue, globalPeakPosition] = max(peakValues); % extract global extremum
soundOnsetPosition = peakPositions(globalPeakPosition-1); % find extremum before gobal extremum


tau = linspace(-.001, .001, round(fs_bin/500)); % create time shifting vector tau

IACF_i125_early = zeros(length(tau), 4); % create matrices for IACF for 4 bands 
IACF_i125_late = zeros(length(tau), 4);

IACC_i125_early = zeros(1, 4); % create vectors for IACC for 4 bands
IACC_i125_late = zeros(1, 4);

IACC_early_start = soundOnsetPosition; % define position t_1 for IACC_early in samples
IACC_early_end = soundOnsetPosition + round(.08*fs_bin); % define position t_2 for IACC_early in samples
IACC_late_start = IACC_early_end; % t_2 of IACC_early equals t_1 of IACC_late
IACC_late_end = soundOnsetPosition + fs_bin; % define position t_2 for IACC_late in samples


for i = 1:4
    
    %filtering of both channels
    [b,a] = butter(3,[(2^(i-1))*125/sqrt(2) (2^(i-1))*125*sqrt(2)]/(fs_bin/2));
    p_L_filtered = filter(b,a,p_L);
    p_R_filtered = filter(b,a,p_R);
    
    %compute IACF(tau) for band
    for j = 1:length(tau)
        
        IACF_i125_early(j,i) = sum(p_L_filtered(IACC_early_start : IACC_early_end) ...
            .* p_R_filtered(IACC_early_start + round(tau(j)*fs_bin) : IACC_early_end + round(tau(j)*fs_bin))) ...
          / sqrt(sum(p_L_filtered(IACC_early_start : IACC_early_end).^2) ...
           * sum(p_R_filtered(IACC_early_start : IACC_early_end).^2));
        
        IACF_i125_late(j,i) = sum(p_L_filtered(IACC_late_start : IACC_late_end) ...
            .* p_R_filtered(IACC_late_start + round(tau(j)*fs_bin) : IACC_late_end + round(tau(j)*fs_bin))) ...
          / sqrt(sum(p_L_filtered(IACC_late_start : IACC_late_end).^2) ...
           * sum(p_R_filtered(IACC_late_start : IACC_late_end).^2));
        
    end
    
    %from IACF(tau), compute IACC for band
    IACC_i125_early(1, i) = max(abs(IACF_i125_early(:,i)));
    IACC_i125_late(1, i) = max(abs(IACF_i125_late(:,i)));
    
end

IACC_125_early = IACC_i125_early(1, 1);
IACC_250_early = IACC_i125_early(1, 2);
IACC_500_early = IACC_i125_early(1, 3);
IACC_1000_early = IACC_i125_early(1, 4);

IACC_125_late = IACC_i125_late(1, 1);
IACC_250_late = IACC_i125_late(1, 2);
IACC_500_late = IACC_i125_late(1, 3);
IACC_1000_late = IACC_i125_late(1, 4);


