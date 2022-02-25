function result = contrast_enhancement(image,decreasing)
    %the result is the image modified
    %image ib rgb to hsv
    image_hsv=rgb2hsv(image);
    %decreasing is a number >1
    image_hsv(:,:,3)=image_hsv(:,:,3)*decreasing;
    result=hsv2rgb(image_hsv);
end