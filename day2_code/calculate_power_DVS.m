function result = calculate_power_DVS(stringa)
    A=imread(stringa);
    Vdd=15;
    result=0;
    for i=1:length(A(:,1,1))
        for j=1:length(A(1,:,1))
            result=result+calculate_current_DVS_pixel(A(i,j,:));
        end
    end
    result=result*Vdd;
end



