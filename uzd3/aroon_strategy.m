function [buy_sell] = aroon_strategy(aroon_oscillator, day_level_data, buy_point, sell_point, take_profit, stop_loss, fees)

size = length(day_level_data.date);
buy_sell = zeros(1, size);

share_count = 0;
share_price = 0;

for i=1:size-1
    % if we have share
    if (share_count)
        % sell if oscillator is lower than sell point and it is decreasing
        if (aroon_oscillator(i) <= sell_point && aroon_oscillator(i) > aroon_oscillator(i+1))
            buy_sell(i) = 1;
            share_count = 0;
            share_price = 0;
            continue
        end
        
        % take profit
        if (take_profit > 0 && ((day_level_data.close(i) - fees)/share_price >= ((take_profit+100)/100)))
            buy_sell(i) = 1;
            share_count = 0;
            share_price = 0;
        end
        
        % stop loss
        if (stop_loss > 0 && ((day_level_data.close(i) - fees)/share_price <= (100-stop_loss)/100))
            buy_sell(i) = 1;
            share_count = 0;
            share_price = 0;
        end
    else
        % sell if oscillator is greater than buy point and it is increasing
        if (aroon_oscillator(i) >= buy_point && aroon_oscillator(i+1) > aroon_oscillator(i))
            buy_sell(i) = -1;
            share_count = 1;
            share_price = day_level_data.close(i) + fees;
        end
    end
end