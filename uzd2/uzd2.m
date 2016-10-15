% ----------------------------------------------------------------------------
% Mantas Neviera PS1, FI 2 uþd
% indicators: moving average, average true range, force index
% data: EURUSD
% info: http://stockcharts.com/school/doku.php?id=chart_school:technical_indicators
% ----------------------------------------------------------------------------

%% load day level data
day_level_data = read_data('data/EURUSD.csv');
%% calculate N days moving average
N = 14;
moving_avg = moving_average(day_level_data.close, N);

%% display N days moving average
figure(2);
hold on;
plot(day_level_data.date, day_level_data.close);
plot(day_level_data.date, moving_avg);
datetick('x', 'mm/dd');
grid on;
xlabel('date');
ylabel('close price');
title('close price and moving average');
legend('close price', strcat(num2str(N), ' days mavg'))
axis tight;
hold off;
%% calculate N days ATR
N = 14;

th_tl_range = day_level_data.high - day_level_data.low;
th_yc_range = abs(day_level_data.high - day_level_data.close([1 1:end-1]));
yc_tl_range = abs(day_level_data.close([1 1:end-1]) - day_level_data.low);
true_range = max([th_tl_range;th_yc_range;yc_tl_range],[],1);
avg_true_range = moving_average(true_range, N);

%% display N days ATR
figure(3);
ax(1) = subplot(4,1,[1 2 3]);
plot(day_level_data.date, day_level_data.close);
title('close price and average true range');
datetick('x', 'mm/dd');
xlabel('date');
ylabel('close price');

ax(2) = subplot(4,1,4);
plot(day_level_data.date, avg_true_range);
datetick('x', 'mm/dd');
xlabel('date');
ylabel('atr');

linkaxes([ax(1) ax(2)],'x'); 
axis tight;
%% calculate force index
force_indexes = (day_level_data.close - day_level_data.close([1 1:end-1])) .* day_level_data.volume;

%% display force index
figure(4);
ax(1) = subplot(4,1,[1 2 3]);
plot(day_level_data.date, day_level_data.close);
title('close price and force index');
datetick('x', 'mm/dd');
xlabel('date');
ylabel('close price');

ax(2) = subplot(4,1,4);
plot(day_level_data.date, force_indexes);
datetick('x', 'mm/dd');
xlabel('date');
ylabel('force index');

linkaxes([ax(1) ax(2)],'x'); 
axis tight;