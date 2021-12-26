function result = power_saving(stringa_o,stringa_t)
    power_o=calculate_power(stringa_o);
    power_t=calculate_power(stringa_t);
    result= 100*(1-power_t/power_o);
end