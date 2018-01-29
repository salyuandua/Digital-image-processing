%%%%% This is a Matlab tutorial by Jingru Zhang, 01/04/2018
%%%%% Department of Computer Science, Marshall University
%%%%% jingru.zhang@marshall.edu 
%%%%% ---------------------------------------------------------------------
%%%%% part 2: image related processing
%% 
clear all;      % clear all the current variables
close all;      % close all the opened figures 
clc;            % clear the command windows
%% read and show a RGB image 
I = imread('dog.png');
figure, subplot(2,2,1), imshow(I), title('RGB color image');
subplot(2,2,2), imshow(I(:,:,1)), title('R channel');
subplot(2,2,3), imshow(I(:,:,2)), title('G channel');
subplot(2,2,4), imshow(I(:,:,3)), title('B channel');
%% change some ROI to red color of [255,0,0]
I(207:207+50, 387:387+50, 1)=255;
I(207:207+50, 387:387+50, 2)=0;
I(207:207+50, 387:387+50, 3)=0;
figure, imshow(I,[]);
%% shrink an image and make it half size and store the shrinked image
[row,col,dim]=size(I)           
I2= imresize(I, [row/2,col/2]);
[row2,col2,dim2]=size(I2)       
imwrite(I2, 'dog_small.png');   
%% transfer the color image to gray image
I3 = rgb2gray(I);
[row3,col3,dim3]=size(I3)         
figure, imshow(I3,[]);            
imwrite(I3, 'dog_gray.png');      
I4 = I3(207:207+50, 387:387+50);
figure, imshow(I4,[]);             
I3(207:207+50, 387:387+50) = 0;   
figure, imshow(I3,[]);
I3(207:207+50, 387:387+50) = 255; 
figure, imshow(I3,[]);
%% see the class: uint8 or double
whos I
whos I3
% I5= double(I);
% whos I5;
%% do binary segmentation for the gray image
I_b = im2bw(I3, 0.7);   
figure, imshow(I_b,[]);
whos I_b                
imwrite(I_b, 'dog_binary.png');      
%% concatenate 3 single-channel images to one color image [255, 0, 200] 
I_R= uint8(255*ones(300,400));
I_G= uint8(zeros(300,400));
I_B= uint8(200*ones(300,400));
I_rgb = cat(3, I_R, I_G, I_B);
figure, imshow(I_rgb, []);