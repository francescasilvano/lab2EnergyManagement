%script pixer wise restituisce la distorsione e la power_saving for k 0.5
%to 0.9
function [distortion,power] = pixel_wise(immagine)
    distortion=zeros(5,1);
    power=zeros(5,1);
    x=0;
    for k= 0.5:0.1:0.9
        x=x+1;
        %0.5 0.6 0.7 0.8 0.9
        %read the image
        tranf= imread(immagine);
        %modify it
        tranf=uint8(tranf*k);
        %calculate the name of the image transformed in order to save it
        tmp=immagine;
        array=strsplit(tmp,'.');
        name=strcat(array(1),"_pw",sprintf('%.1f',k),".",array(2));
        imwrite(tranf,name);
        %for each image calculate the distortion
        distortion(x)=calculate_distortion(immagine,name);
        % and the power saving
        power(x)=power_saving(immagine,name);
    end
    x=0.5:0.1:0.9;
    %plot of the distortion and power saving for each k
    plot(x,distortion,'b-o',x,power,'r-*');
    title('Pixel wise');
    legend('distortion','power');
end