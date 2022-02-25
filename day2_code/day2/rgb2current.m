function result = rgb2current(image_read)
    result=double(image_read);
    for i=1:length(image_read(:,1,1))
            for j=1:length(image_read(1,:,1))
                result(i,j,:)=calculate_current_DVS_pixel(image_read(i,j,:),15);
            end
    end
end