function [distortion,power] = histogram_equalization(img,ext)
%La tonalità H viene misurata da un angolo con il rosso a 0 gradi, il verde a 120 e il blu a 240. (360 è ancora rosso)
%La luminosità (V) con lo zero che rappresenta il nero e l'uno (colore brillante o bianco se saturazione =0)
% La saturazione (S) invece va da zero (bianco/nero dipende da V) a uno (colore brillante)
%per avere la scala di grigi devo prendere V
%if the image is colored it has 3 matri r g and b else if it is b&w only
%the matrix of grey
if(length(img(1,1,:))== 3)
    %transform from rgb to hsv
    hsv_im=rgb2hsv(img);
    %takes the brightness
    Bright= hsv_im(:,:,3);
    Corr_bright=histeq(Bright);
    %correct the brightness throw histogram equalization
    hsv_im(:,:,3)= Corr_bright;
    %save the correct brightness
    transformed=hsv2rgb(hsv_im);
    %save 
    name="tmp."+ext;
    imwrite(transformed,name);
    transformed=imread(name);
else
    %else it is gray
    transformed=histeq(img);
end
figure
subplot(1,2,1)
imshow(img);
title("real");
subplot(1,2,2)
imshow(transformed);
title("equalized");
%calculate distortion
distortion=calculate_distortion(img,transformed);
%e il power saving
power=power_saving(img,transformed);
end