function current = calculate_current_DVS_pixel(DVS_pixel,Vdd)
    p1=4.251*10^(-5);
    p2 = -3.029*10^(-4);
    p3 = +3.024*10^(-5);
    current=((p1*Vdd*double(DVS_pixel))/255)+(p2*double(DVS_pixel)/255)+p3;
end