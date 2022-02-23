function result = power_saving(stringa_o,stringa_t)
    power_o=calculate_power(stringa_o);
    power_t=calculate_power(stringa_t);
    %check for safety
    if(power_o==0)
        result=0;
    else
    result= 100*(1-power_t/power_o);
    end
end