% ----------------------------------------------------------------------------
% Mantas Neviera PS1, FI 1 uþd
% data from: http://www.finam.ru/profile/akcii-usa-bats/microsoft-corp/export/
% ----------------------------------------------------------------------------

%% load day level data
day_level_data = read_DTOHLCV('data/US1.MSFT_160701_160930_DAY.csv');
%% display day level data
figure(1);
plot(day_level_data.date, day_level_data.close);
datetick('x', 'mm/dd');
grid on;
xlabel('date');
ylabel('close price');
title('day level data close price');
%% load min level data
min_level_data = read_DTOHLCV('data/US1.MSFT_160901_160930_MIN.csv');
%% display min level data
figure(2);
plot(min_level_data.date, min_level_data.close);
datetick('x', 'mm/dd HH:MM:SS');
grid on;
xlabel('date');
ylabel('close price');
title('min level data close price');
%% load tick data
tick_level_data = read_DTLV('data/US1.MSFT_160930_160930_TICK.csv');
%% display tick level data
figure(3); 
hold on;
yyaxis left;
plot(tick_level_data.date, tick_level_data.last);
datetick('x', 'mm/dd HH:MM');
grid on;
xlabel('date');
ylabel('last price');
title('tick level data');
yyaxis right;
plot(tick_level_data.date, tick_level_data.volume);
ylabel('volume');
hold off;
%% display random data
figure(4);
points_n = ceil(100 * rand);
dates = (now - points_n + 1):now;
close_prices = cumsum(randn(1, points_n).*5);
plot(dates, close_prices);
datetick('x', 'mm/dd');
grid on;
xlabel('date');
ylabel('close price');
title('random data close price');
%% find top N gaps in min level data
N = 10;
all_dates = min_level_data.date;

all_differences = [];
for i=2:length(all_dates)
    difference = struct('diff', (all_dates(i) - all_dates(i-1))*1440, 'date1', all_dates(i-1), 'date2', all_dates(i));
    all_differences = [all_differences difference];
end

[values, index] = sort([all_differences.diff], 'descend');
sorted_differences = [];

if (N > length(all_differences))
    N = length(all_differences); 
end;

fprintf('TOP GAPS:\n');
for i=1:N
    fprintf('%d. gap = %.3f min. from %s to %s\n', i, all_differences(index(i)).diff, datestr(all_differences(index(i)).date1), datestr(all_differences(index(i)).date2));
    % sorted_differences = [sorted_differences; all_differences(index(i)).diff all_differences(index(i)).date1 all_differences(index(i)).date2];
end
%% accumulate hour bars from tick data
date_vectors = datevec(tick_level_data.date);
date_vectors(:, 5:6) = 0;
hour_level_dates = datenum(date_vectors);
hour_level_date_groups = unique(hour_level_dates);
accumulated_hour_bars = [];
for i=1:length(hour_level_date_groups)
    indexes = hour_level_dates == hour_level_date_groups(i);
    group_last = tick_level_data.last(indexes);
    group_volume = tick_level_data.volume(indexes);
    accumulated_hour_bars.date(i) = hour_level_date_groups(i);
    accumulated_hour_bars.open(i) = group_last(1);
    accumulated_hour_bars.high(i) = max(group_last);
    accumulated_hour_bars.low(i) = min(group_last);
    accumulated_hour_bars.close(i) = group_last(end);
    accumulated_hour_bars.volume(i) = sum(group_volume);
end
%% display accumulated hour bars  
figure(5);
plot(accumulated_hour_bars.date, accumulated_hour_bars.close);
datetick;
grid on;
xlabel('hour');
ylabel('close price');
title('accumulated hour bars close price');
%% load hour level data
hour_level_data = read_DTOHLCV('data/US1.MSFT_160930_160930_HOUR.csv');
%% display hour level data
figure(6); 
plot(hour_level_data.date, hour_level_data.close);
datetick;
grid on;
xlabel('hour');
ylabel('close price');
title('hour level data close price');
%% calculate diff count between real hour data and accumulated tick data
diff = [];
diff.date=sum(accumulated_hour_bars.date./hour_level_data.date ~= 1);
diff.open=sum(accumulated_hour_bars.open./hour_level_data.open ~= 1);
diff.high=sum(accumulated_hour_bars.high./hour_level_data.high ~= 1);
diff.low=sum(accumulated_hour_bars.low./hour_level_data.low ~= 1);
diff.close=sum(accumulated_hour_bars.close./hour_level_data.close ~= 1);
diff.volume=sum(accumulated_hour_bars.volume./hour_level_data.volume ~= 1);
fprintf('\nDIFF COUNT BETWEEN REAL HOUR DATA AND ACCUMULATED TICK DATA TO HOUR LEVEL:\n');
disp(diff);