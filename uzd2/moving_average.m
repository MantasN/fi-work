function [moving_average] = moving_average(values, period)

size = length(values);
moving_average = zeros(1, size);
moving_average(1:period) = NaN;
moving_average(period) = sum(values(1:period))/period;

for i=period+1:size
    moving_average(i) = moving_average(i-1) - values(i-period)/period + values(i)/period;
end