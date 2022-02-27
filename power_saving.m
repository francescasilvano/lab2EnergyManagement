function result = power_saving(original,transformed)
    power_o=calculate_power(original);
    power_t=calculate_power(transformed);
    %check for safety
    if(power_o==0)
        result=0;
    else
    result= 100*(1-power_t/power_o);
    end
end