function [balance, profit] = calculate_balance_profit(day_level_data, buy_sell, fees)

size = length(day_level_data.date);

balance = day_level_data.close .* buy_sell;
balance(balance ~= 0) = balance(balance ~= 0) - fees;

profit = zeros(1, size);

last_buy = 0;
for i=1:size
    if(buy_sell(i) == -1) 
        last_buy = day_level_data.close(i);
        profit(i) = profit(i) - fees;
    end
    
    if(buy_sell(i) == 1)
        profit(i) = day_level_data.close(i) - last_buy - fees;
    end
end