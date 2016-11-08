% ----------------------------------------------------------------------------
% Mantas Neviera PS1, FI 3 uþd
% data: AAPL
% AROON: http://www.investopedia.com/articles/trading/06/aroon.asp
%        http://stockcharts.com/school/doku.php?id=chart_school:technical_indicators:aroon_oscillator
% ----------------------------------------------------------------------------

%% load day level data
day_level_data = read_data('data/AAPL.csv');
size = length(day_level_data.date);
%% strategy parameters
aroon_periods = 16; % aroon periods
buy_point = 35; % aroon greater than
sell_point = 50; % aroon lower than

take_profit = 0; % profit in percentage
stop_loss = 10; % loss in percentage

commision = 0.01; % commision price
slippage = 0.01; % slippage price
fees = commision + slippage;
%% calculate aroon oscillator
aroon_oscillator = aroon_osc(day_level_data, aroon_periods);
%% calculate buy & sell strategy
buy_sell = aroon_strategy(aroon_oscillator, day_level_data, buy_point, sell_point, take_profit, stop_loss, fees);
%% display day level close price, aroon with strategy and buy & sell
figure(1);
ax(1) = subplot(4,1,[1 2 3]);
plot(day_level_data.date, day_level_data.close);
title('day level data close price and aroon');
datetick('x', 'mm/dd');
xlabel('date');
ylabel('close price');

ax(2) = subplot(4,1,4);
BP(1:size) = buy_point; % buy_points to plot
SP(1:size) = sell_point; % sell_points to plot
plot(day_level_data.date, aroon_oscillator, day_level_data.date, BP, 'g', day_level_data.date, SP, 'r');
datetick('x', 'mm/dd');
xlabel('date');
ylabel(strcat('aroon(', num2str(aroon_periods), ')'));

linkaxes([ax(1) ax(2)],'x');
axis tight;

for i=1:size
    if(buy_sell(i) == -1) 
        text(ax(1), datenum(day_level_data.date(i)), day_level_data.close(i), '\leftarrow buy')
    end
    
    if(buy_sell(i) == 1)
        text(ax(1), datenum(day_level_data.date(i)), day_level_data.close(i), '\leftarrow sell')
    end
end
%% calculate balance & profit
[balance, profit] = calculate_balance_profit(day_level_data, buy_sell, fees);
%% display balance & profit
figure(2);
ax(1) = subplot(4,1,[1 2]);
plot(day_level_data.date, cumsum(balance));
title('overall balance & profit');
datetick('x', 'mm/dd');
xlabel('date');
ylabel('balance');

ax(2) = subplot(4,1,[3 4]);
plot(day_level_data.date, cumsum(profit));
datetick('x', 'mm/dd');
xlabel('date');
ylabel('profit');

linkaxes([ax(1) ax(2)],'x');
%% optimize strategy parameters
sharpe_ratio = @(values) (mean(values)*252) ./ (std(values) * sqrt(252));

best_sharpe_ratio = -inf;
best_total_profit = -inf;
best_buy_point = 0;
best_sell_point = 0;
best_aroon_oscillator = [];
best_buy_sell = [];
best_balance = [];
best_profit = [];
heat_map = [];

for buy_point = 1:100
    for sell_point = 1:100
        aroon_oscillator = aroon_osc(day_level_data, aroon_periods);
        buy_sell = aroon_strategy(aroon_oscillator, day_level_data, buy_point, sell_point, take_profit, stop_loss, fees);
        [balance, profit] = calculate_balance_profit(day_level_data, buy_sell, fees);

        current_profit = sum(profit);
        current_sharpe_ratio = sharpe_ratio(profit);
        
        if current_sharpe_ratio > best_sharpe_ratio
            best_sharpe_ratio = current_sharpe_ratio;
            best_total_profit = current_profit;
            best_buy_point = buy_point;
            best_sell_point = sell_point;
            best_aroon_oscillator = aroon_oscillator;
            best_buy_sell = buy_sell;
            best_balance = balance;
            best_profit = profit;
        end
        
        heat_map(buy_point, sell_point) = current_sharpe_ratio;
    end
end
%% print optimized strategy parameters and profit
fprintf('The best profit was %.2f, when buy_point=%d and sell_point=%d\n', best_total_profit, best_buy_point, best_sell_point);
%% display optimized strategy
figure(3);
ax(1) = subplot(4,1,[1 2 3]);
plot(day_level_data.date, day_level_data.close);
title('optimized strategy day level data close price and aroon');
datetick('x', 'mm/dd');
xlabel('date');
ylabel('close price');

ax(2) = subplot(4,1,4);
BP(1:size) = best_buy_point;
SP(1:size) = best_sell_point;
plot(day_level_data.date, best_aroon_oscillator, day_level_data.date, BP, 'g', day_level_data.date, SP, 'r');
datetick('x', 'mm/dd');
xlabel('date');
ylabel(strcat('aroon(', num2str(aroon_periods), ')'));

linkaxes([ax(1) ax(2)],'x');
axis tight;

for i=1:size
    if(best_buy_sell(i) == -1) 
        text(ax(1), datenum(day_level_data.date(i)), day_level_data.close(i), '\leftarrow buy')
    end
    
    if(best_buy_sell(i) == 1)
        text(ax(1), datenum(day_level_data.date(i)), day_level_data.close(i), '\leftarrow sell')
    end
end
%% display optimized balance & profit
figure(2);
ax(1) = subplot(4,1,[1 2]);
plot(day_level_data.date, cumsum(best_balance));
title('optimized overall balance & profit');
datetick('x', 'mm/dd');
xlabel('date');
ylabel('balance');

ax(2) = subplot(4,1,[3 4]);
plot(day_level_data.date, cumsum(best_profit));
datetick('x', 'mm/dd');
xlabel('date');
ylabel('profit');

linkaxes([ax(1) ax(2)],'x');

figure(8);
datetick('x', 'mm/dd');
plot(day_level_data.date, day_level_data.close - day_level_data.close([1 1:end-1]));
%% display sharpe ratio heat map
figure(4);
imagesc(heat_map);
colorbar;
colormap('hot');