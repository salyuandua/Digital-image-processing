%author Xuejian Li
%---------------------------problem 1---------------------------
A=imread('peppers.bmp');
figure,imshow(A),title('RGB Original Image');
%---------------------------problem 2---------------------------
B=rgb2gray(A);
%transponse B to TB
TB=B';
%flip left-right
VB=fliplr(B);
%flip up-down 
FB=flipud(B);
%show images
figure;
subplot(2,2,1),imshow(B);
subplot(2,2,2),imshow(TB);
subplot(2,2,3),imshow(VB);
subplot(2,2,4),imshow(FB);
%---------------------------problem 3---------------------------
B_double=double(B);
C=norm_im(B_double,0,1);
figure;
imshow(C);
n=size(C);%size of C
D=C;
D(1:0.25*n,:)=D(1:0.25*n,:).^0.5;
D(0.75*n:end,:)=D(0.75*n:end,:).^1.5;
figure,imshow(D),title('Processed Grayscale Image');
%write image
imwrite(D,'Xuejian_D.jpg');
%---------------------------problem 4---------------------------
%bw1
[row,col]=size(C);
bw1=zeros(row,col);
k=find(C>=0.3);
bw1(k)=1;
%bw2
bw2=C;
bw2(bw2>=0.3)=1;
bw2(bw2<0.3)=0;
%bw3
bw3=im2bw(C,0.3);%matlab reminds me use 'imbinarize' is better
if isequal(bw1,bw3) && isequal(bw2,bw3)
    fprintf('My two methods worked');
else   
    fprintf('One of my two methods or both did not work');
end
%show images
figure;
subplot(1,3,1),imshow(bw1),title('my first method');
subplot(1,3,2),imshow(bw2),title('my second method');
subplot(1,3,3),imshow(bw3),title('Matlab method');
%---------------------------------problem 5-----------------------------
%blur A
BA=BlurImage(A);
%blur B
BB=BlurImage(B);
%show images
figure;
subplot(2,2,1),imshow(A);
subplot(2,2,2),imshow(B);
subplot(2,2,3),imshow(BA);
subplot(2,2,4),imshow(BB);
%CLEAR
clear all;
close all;
%Bluring image function with average filter
function [blurredIm] = BlurImage(oriIm)
    h=fspecial('average',[4 4]);
    blurredIm=imfilter(oriIm,h);
end
%%Define a function for normalizing image
function C=norm_im(B,new_min,new_max)
    C=(new_max-new_min)/(max(B(:))-min(B(:)))*(B-min(B(:)))+new_min;
end

















