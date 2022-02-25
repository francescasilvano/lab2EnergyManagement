clear all

SATURATED = 1;
DISTORTED = 2;

%load('Sample_cell_current.mat');
image_read=imread("im1.bmp");
Vdd = 12;
I_cell_sample=double(image_read);

%transform the image in current
for i=1:length(I_cell_sample(:,1,1))
        for j=1:length(I_cell_sample(1,:,1))
            I_cell_sample(i,j,:)=calculate_current_DVS_pixel(image_read(i,j,:));
        end
end
%get displayed RGB image with cell current and supply voltage with two mode
image_RGB_saturated = displayed_image(I_cell_sample, Vdd, SATURATED); 
image_RGB_distorted = displayed_image(I_cell_sample, Vdd, DISTORTED); 
subplot(2,1,1)
image(image_RGB_saturated/255);       % display saturated RGB image
subplot(2,1,2)
image(image_read);       % display image real