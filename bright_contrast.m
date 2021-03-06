function [distortion,power] = bright_contrast(image,dist,ext)
    if(length(image(1,1,:))==3)%if it is colored we can apply modification 
        x=0;
        img_display={};
        for k=0.1:0.1:0.4 %bright
            hsv_transf=rgb2hsv(image);
            bright=hsv_transf(:,:,3);
            power_max=-1;
            for g=0.1:0.1:0.9 %contrast
                bright_g=bright*g+k;
                hsv_transf(:,:,3)=bright_g;
                %calculate distortion if ok with constrain save it
                %otherwise go on
                transformed=hsv2rgb(hsv_transf);
                %save 
                name="tmp."+ext;
                imwrite(transformed,name);
                tranf=imread(name);
                tmp_d=calculate_distortion(image,tranf);
                tmp_p=power_saving(image,tranf);
                %check if the distortion reach the treshold and if the
                %power saving is bigger
                if(tmp_d<=dist)&&(tmp_p>power_max)
                    value_distortion=tmp_d;
                    power_max=tmp_p;
                    tmp_y=k;
                    img_tmp=tranf;
                end
            end
            if(power_max>-1)
                x=x+1;
                distortion(x)=value_distortion;
                power(x)=power_max;
                y(x)=tmp_y;
                img_display{end+1}=img_tmp;
            end
        end
        if(x>0)
            figure
            plot(y,distortion,'b-o',y,power,'r-*');
            title('Bright contrast');
            legend('distortion','power saving');
            figure
            montage(img_display);
        else
            distortion=0;
            power=0;
        end
    else %b&W
        x=0;
        img_display={};
        for k=0.1:0.1:0.4 %bright
            bright=image;
            bright=uint8(double(bright)+k*255);
            power_max=-1;
            for g=0.1:0.1:0.9 %contrast
                tranf=bright*g;
                %calculate distortion if ok with constrain save it
                %otherwise go on
                tmp_d=calculate_distortion(image,tranf);
                tmp_p=power_saving(image,tranf);
                %check if the distortion reach the treshold and if the
                %power saving is bigger
                if(tmp_d<=dist)&&(tmp_p>power_max)
                    value_distortion=tmp_d;
                    power_max=tmp_p;
                    tmp_y=k;
                    img_tmp=tranf;
                end
            end
            if(power_max>-1)
                x=x+1;
                distortion(x)=value_distortion;
                power(x)=power_max;
                y(x)=tmp_y;
                img_display{end+1}=img_tmp;
            end
        end
        if(x>0)
            figure
            plot(y,distortion,'b-o',y,power,'r-*');
            title('Bright contrast');
            legend('distortion','power saving');
            figure
            montage(img_display);
        else
            distortion=0;
            power=0;
        end
    end
end