% Xuejian Li           Lab2
food=imread('Food.jpg');%range 90-138
%------------------problem 1-------------------
% 
[scaledFood,k,b]=Scaling(food,[0 255]);

disp('------Finish Solving Problem 1------');
pause();
% %------------------problem 2---------------------
  matScaledFood=imadjust(food,[double(min(food(:)))/255 double(max(food(:)))/255],[0 1]);
  figure;
  subplot(1,2,1),imshow(scaledFood),title('My result');
  subplot(1,2,2),imshow(matScaledFood),title('Matlab result');
  disp('------Finish Solving Problem 2------');
  pause();
% %------------problem 3-----------------
 [food_histogram,food_nor_histogram]=CalHist(scaledFood);
 [food_histogram_mat,food_nor_histogram_mat]=CalHist(matScaledFood);
 figure;
 subplot(1,2,1),bar(food_nor_histogram),title('My result');
 subplot(1,2,2),bar(food_nor_histogram_mat),title('Matlab result');
 disp('------Finish Solving Problem 3------');
 pause();
%--------------problem 4-----------------
[equalizedFood, transFunc]=HistEqualization(food,255);
disp('------Finish Solving Problem 4------');
pause();
%---------------problem 5------------------
[equalizedFood_mat,transFunc_mat]=histeq(food);
figure;
subplot(1,2,1),imshow(equalizedFood),title('My equalized image');
subplot(1,2,2),imshow(equalizedFood_mat),title('Matlab equalized image');
%plot transformation function
X=linspace(0,255,256);
figure;
subplot(1,3,1),plot(X,transFunc),title('Trans function');
subplot(1,3,2),plot(X,transFunc_mat),title('Trans function Matlab');
scaling_Y=X.*k+b;
subplot(1,3,3),plot(X,scaling_Y),title('Trans function rescaling');
disp('------Finish Solving Problem 5------');
pause();
%---------------------problem 6---------------------
tic;
[equalizedFood, transFunc]=HistEqualization(food,255);
end_time=toc;
fprintf('Time cost for my HistEqualiztion is %f\n',end_time);
[equalizedFood_mat,transFunc_mat]=histeq(food);
end_time_mat=toc;
fprintf('Time cost for histeq is %f\n',end_time_mat);
disp('------Finish Solving Problem 6------');
pause();
%-----------------------problem 7-------------------------
disp('Smple scaling is easy to implemnt and fast, but it does not consider ');
disp('the frequency of gray level.');
disp('The Histogram equalization is an effective approach for gray image, but it can ');
disp('not work for color images');
disp('------Finish Solving Problem 7------');
pause();
%-----------------------problem 8-----------------------------
food_hist=hist(food(:),0:1:255);
food_histc=histc(food(:),0:1:255);
figure;
subplot(1,2,1);bar(food_hist);title('Histogram with hist');
subplot(1,2,2);bar(food_histc);title('Histogram with histc');
disp('Hist specifies bin center but histc specifies bin edge');
disp('------Finish Solving Problem 8------');
pause();
close all;
clc;

%--------------------------------function area--------------------------
%function to equalize histogram
function[enhancedIm, transFunc] = HistEqualization(inputIm, level)
min_pix=double(min(inputIm(:)));
level=level+1;
transFunc=zeros(1,level);
[row,col]=size(inputIm);
n=row*col;
sum=0;
for i=min_pix:level
   pfk =size(inputIm(inputIm==i),1)./n;
   sum=sum+pfk; 
   gl=round((level-1)*sum);
   transFunc(i)=gl;
    
end
transFunc=uint8(transFunc);
%enhance image
enhancedIm=inputIm;
for i=1:row
 for j=1:col
 enhancedIm(i,j)=transFunc(inputIm(i,j));
 end
end
end


%function to compute histogram and normalized hisogram for an image
function [histogram,nor_histogram]=CalHist(org_image)
max_pixel=max(org_image(:));
histogram=zeros(max_pixel,1);
nor_histogram=zeros(max_pixel,1);
[row,col]=size(org_image);
%total elements number in orginial image
n=row.*col;
%compute hisogram and normalized hisgram
for i=0:max_pixel 
    n_k=sum(sum(org_image==i));
    histogram(i+1)=n_k;
    nor_histogram(i+1)=n_k./n;
end



end


% rescale function
function [scaledIm,k,b] = Scaling(inputIm, range)
%check grey image
[row,col,color_channel]=size(inputIm);
 if color_channel>1
     error('Input Image is not grey');
 end
if size(range)~=2
    error('The size of range should be 2');
end
old_min=min(inputIm(:));
old_max=max(inputIm(:));
new_min=range(1);
new_max=range(2);
%valid range
if new_min<0 || new_max>255 || new_max<new_min
error('Please enter valided range!');
end
%mapping with linear function scaledIm=k*inputIm+b where k is slope, b is
%distance from 0 to intersaction point.
%k=(new_max-new_min)/(old_max-old_min) and b=new_min-k*old_min
k=(new_max-new_min)./double(old_max-old_min);
%fprintf('k is %d',k);
b=new_min-k*double(old_min);
%fprintf('b is %d',b);
scaledIm=k.*double(inputIm)+b;
scaledIm=uint8(scaledIm);

end