function [distortion,power] = brightness_scaling(image,dist,ext)
    %the result is the vector of distortion and power
    x=0;
    figure
    for k=0.1:0.1:0.9
        %image ib rgb to hsv
        if(length(image(1,1,:))==3) %if it is colored
            image_hsv=rgb2hsv(image);
            %decrease the brightness in order to have more element in the dark
            %side and less power consumption due to the impossible fact of
            %having white
            image_hsv(:,:,3)=image_hsv(:,:,3)-k;
            tranf=hsv2rgb(image_hsv);
            %save 
            name="tmp."+ext;
            imwrite(tranf,name);
            tranf=imread(name);
        else
            tranf=image;
            tranf=uint8(double(tranf)-k*255);
        end
        %calculate the distortion
        tmp=calculate_distortion(image,tranf);
        %check if the distortion reach the treshold
        if(tmp<=dist)
            x=x+1;
            distortion(x)=tmp;
            % and the power saving
            power(x)=power_saving(image,tranf);
            y(x)=k;
            %display it if distortion(x) <distortion
            subplot(3,3,x);
            imshow(tranf);
            title("Brightness scaling "+string(k));
        end
    end
    %check if there is some value
    if(x>0)
        figure
        %plot of the distortion and power saving for each y
        plot(y,distortion,'b-o',y,power,'r-*');
        title('Brightness scaling');
        legend('distortion','power saving');
    else
        distortion=0;
        power=0;
    end
end
