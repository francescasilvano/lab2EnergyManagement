function [distortion,power] = hungry_blue(immagine,dist)
        x=0;
        img_display={};
        %create the vector for the saving
        for k= 20:20:255
            %0 20 40 60..
            tranf= immagine;
            %1 red 2 green 3 blue, subtract each time more blue
            if(length(immagine(1,1,:))== 3)%if it is colored go on otherwise it is usefull
                tranf(:,:,3)=tranf(:,:,3) - k;
            else
                tranf=uint8(double(tranf)-k/3);
            end
            tmp=calculate_distortion(immagine,tranf);
            if(tmp<=dist)
                x=x+1;
                %save the distortion
                distortion(x)=tmp;
                % and the power saving
                power(x)=power_saving(immagine,tranf);
                %and the k for the plot
                y(x)=k;
                %display it if distortion(x) <distortion
                img_display{end+1}=tranf;
            else
                break;
            end

        end
        if(x>0)
            plot(y,distortion,'b-o',y,power,'r-*');
            title('Hungry blue');
            legend('distortion','power saved');
            figure
            montage(img_display);
        end
end