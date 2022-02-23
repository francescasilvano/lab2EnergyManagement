function evaluation(immagini)
%for each image do the 5 transformation
    for i=1:length(immagini)
        [distortion_pw,power_pw]=pixel_wise(string(immagini(i))); %return a vector for power saving and distortion is equal for rgb or grey
        [distortion_hb,power_hb]=hungry_blue(string(immagini(i))); %return vector for rgb and 0 for grey
        [distortion_he,power_he]=histogram_equalization(string(immagini(i))); %return a number for each
        [distortion_bcm,power_bcm]=bright_contrast_mul(string(immagini(i))); %return a vector for grey and a matrix for rgb
        [distortion_bcs,power_bcs]=bright_contrast_sub(string(immagini(i)));%return a vector for grey and a matrix for rgb
        if(length(power_hb)>1)%if it is colored make the average for the bright contrast
            %with the same bright make the average of the saturation
            %take all the row and make the average
            distortion_bcs_avg=zeros(length(distortion_bcs(:,1)),1);
            power_bcs_avg=zeros(length(distortion_bcs(:,1)),1);
            for x=1:length(distortion_bcs(:,1))%number of row
                avg_d=0;
                avg_p=0;
                for y=1:length(distortion_bcs(1,:))%number of column
                    %make the avg
                    avg_d=avg_d+distortion_bcs(x,y);
                    avg_p=avg_p+power_bcs(x,y);
                end
                avg_p=avg_p/length(distortion_bcs(1,:));
                avg_d=avg_d/length(distortion_bcs(1,:));
                %save the value
                distortion_bcs_avg(x)=avg_d;
                power_bcs_avg(x)=avg_p;
            end
            distortion_bcm_avg=zeros(length(distortion_bcm(:,1)),1);
            power_bcm_avg=zeros(length(distortion_bcm(:,1)),1);
            for x=1:length(distortion_bcm(:,1))%number of row
                avg_d=0;
                avg_p=0;
                for y=1:length(distortion_bcm(1,:))%number of column
                    %make the avg
                    avg_d=avg_d+distortion_bcm(x,y);
                    avg_p=avg_p+power_bcm(x,y);
                end
                avg_p=avg_p/length(distortion_bcm(1,:));
                avg_d=avg_d/length(distortion_bcm(1,:));
                %save the value
                distortion_bcm_avg(x)=avg_d;
                power_bcm_avg(x)=avg_p;
            end
        else
            %if they are b&w take the value without average
            power_bcs_avg=power_bcs;
            distortion_bcs_avg=distortion_bcs;
            power_bcm_avg=power_bcm;
            distortion_bcm_avg=distortion_bcm;
        end
        %plot with the avg
        plot(power_pw,distortion_pw,"r-o",power_hb,distortion_hb,"g-.",power_he,distortion_he,"b-*",power_bcs_avg,distortion_bcs_avg,"c-s",power_bcm_avg,distortion_bcm_avg,"m-d");
        title('Pareto curve avg power, average distortion');
        legend('pixel wise',"hungry blue","histogram equalization","bright contrast sub","bright contrast mul");
        if(length(power_hb)>1)%if it is colored take the maximum for the bright contrast
            distortion_bcs_max=zeros(length(distortion_bcs(:,1)),1);
            power_bcs_max=zeros(length(distortion_bcs(:,1)),1);
            for x=1:length(distortion_bcs(:,1))%number of row
                max_d=0;
                max_p=0;
                for y=1:length(distortion_bcs(1,:))%number of column
                    %take the maximum
                    if(distortion_bcs(x,y)>max_d)
                        max_d=distortion_bcs(x,y);
                        max_p=power_bcs(x,y);
                    end
                end
                %save the value
                distortion_bcs_max(x)=max_d;
                power_bcs_max(x)=max_p;
            end
            distortion_bcm_max=zeros(length(distortion_bcm(:,1)),1);
            power_bcm_max=zeros(length(distortion_bcm(:,1)),1);
            for x=1:length(distortion_bcm(:,1))%number of row
                max_d=0;
                max_p=0;
                for y=1:length(distortion_bcm(1,:))%number of column
                    %take the max value
                    if(distortion_bcm(x,y)>max_d)
                        max_d=distortion_bcm(x,y);
                        max_p=power_bcm(x,y);
                    end
                end
                %save the value
                distortion_bcm_max(x)=max_d;
                power_bcm_max(x)=max_p;
            end
        else
            %if they are b&w take the value without average
            power_bcs_max=power_bcs;
            distortion_bcs_max=distortion_bcs;
            power_bcm_max=power_bcm;
            distortion_bcm_max=distortion_bcm;
        end
        %plot with the maximum
        plot(power_pw,distortion_pw,"r-o",power_hb,distortion_hb,"g-.",power_he,distortion_he,"b-*",power_bcs_max,distortion_bcs_max,"c-s",power_bcm_max,distortion_bcm_max,"m-d");
        title('Pareto curve avg power, maximum distortion');
        legend('pixel wise',"hungry blue","histogram equalization","bright contrast sub","bright contrast mul");
    end
end