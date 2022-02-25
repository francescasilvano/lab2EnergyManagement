function result = calculate_power_DVS(image)
    Vdd=15;
    result=0;
    for i=1:length(image(:,1,1))
        for j=1:length(image(1,:,1))
            for z=1:length(image(1,1,:))
                result=result+calculate_current_DVS_pixel(image(i,j,z));
            end
        end
    end
    result=result*Vdd;
end



