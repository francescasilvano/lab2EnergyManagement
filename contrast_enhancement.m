function [distortion,power]= contrast_enhancement(image,dist,ext)
    x=0;
    figure
    if(length(image(1,1,:))==3) %if it is colored
            for k=0.1:0.1:0.9
                %image rgb to hsv
                image_hsv=rgb2hsv(image);
                %decrease the brightness in order to have more element in the dark
                %side and less power consumption due to the impossible fact of
                %having white
                image_hsv(:,:,3)=image_hsv(:,:,3)*k;
                tranf=hsv2rgb(image_hsv);
                %save 
                name="tmp."+ext;
                imwrite(tranf,name);
                tranf=imread(name);
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
                    title("Contrast enhancement "+string(k));
                end
            end
            %check if there is some value
            if(x>0)
                figure
                %plot of the distortion and power saving for each y
                plot(y,distortion,'b-o',y,power,'r-*');
                title('Contrast enhancement');
                legend('distortion','power saving');
            end
     else
        %same of the pixel wise su usefull
        distortion=0;
        power=0;
     end
end