%script pixer wise return a vector 
function [distortion,power] = pixel_wise(image,dist,ext)
    x=0;
    figure
    for k= 0.1:0.1:0.9
        %take the image
        tranf= image;
        %modify it
        tranf=uint8(tranf*k);
        %for each image calculate the distortion
        tmp=calculate_distortion(image,tranf);
        if(tmp<=dist)
            x=x+1;
            distortion(x)=tmp;
            % and the power saving
            power(x)=power_saving(image,tranf);
            y(x)=k;
            %display it if distortion(x) <distortion
            subplot(3,3,x);
            imshow(tranf);
            title("Pixel wise "+string(k));
        end
    end
    %check if there is some value
    if(x>0)
        figure
        %plot of the distortion and power saving for each y
        plot(y,distortion,'b-o',y,power,'r-*');
        title('Pixel wise');
        legend('distortion','power saving');
    end
end