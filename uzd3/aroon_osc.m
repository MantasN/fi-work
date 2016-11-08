function [aroon_oscillator] = aroon_osc(day_level_data, period)

size = length(day_level_data.date);
aroon_oscillator = zeros(1, size);

for i=period:size
    max_arr = day_level_data.high((i-period)+1: i);
    [~, max_high_pos] = max(max_arr);
    [~, min_low_pos] = min(day_level_data.low((i-period)+1: i));
    
    aroon_up = ((period - (period - max_high_pos))/period) * 100;
    aroon_down = ((period - (period - min_low_pos))/period) * 100;
    
    aroon_oscillator(i) = aroon_up - aroon_down;
end