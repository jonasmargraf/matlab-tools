function [L_total] = get_SoundPressureLevel(alpha_average, x, y)
%function for calculating sound pressure level for different positions in the
%room with plotting it
%input parameters:
%alpha_average: averaged absorption coefficient of the 4 bands
%x: position of sound source in x-dimension
%y: position of sound source in y-dimension
%
%output paramters:
%L_total: overall sound pressure level for different positions in the
%x-y-plane

width = linspace(0, 7, 700); % create vector for x-dimension
length = linspace(0, 4, 400); % create vector for y-dimension
distance = zeros(700, 400); % create matrix for distances from sound source

for i = 1:700 % iterate over x-dim
    
    for j = 1:400 % iterate over y-dim
        
       distance(i, j) = sqrt((x - width(i))^2 + (y - length(j))^2); %compute euclidian distance
       
    end
end

L_w = 85; % init. level of sound source

L_direkt = L_w - 20.*log10(distance) - 8; % compute direct sound level in x-y-plane
L_diffus = L_w - 10*log10(alpha_average) + 6; % compute diffuse sound level in x-y-plane
L_total = 10 * log10(10.^(L_direkt ./ 10) + 10^(L_diffus / 10)); % sound pressure level addition of both 

figure(2) %plot
surf(L_total, 'EdgeColor', 'none');
xlabel('y in meters');
ylabel('x in meters');
zlabel('L_{total}');