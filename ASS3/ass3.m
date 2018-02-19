%-----------------problem 1-----------------------
circuit=imread('Circuit.jpg');
%weighted 3*3 mask
weighted_mask=[1,2,1;2,4,2;1,2,1].*(1/16);
weighted_filteredIm=AverageFiltering(circuit,weighted_mask);
%standard 5*5 mask
standard_mask=ones(5,5).*(1/25);
standard_filteredIm=AverageFiltering(circuit,standard_mask);
%show images
figure;
subplot(1,3,1),imshow(circuit),title('original image');
subplot(1,3,2),imshow(weighted_filteredIm),title('3*3 average weighted filter');
subplot(1,3,3),imshow(standard_filteredIm),title('5*5 average standard filter');
disp('------Finish Solving Problem 1------');
pause();
%-----------------------------problem 2---------------------------
%weighted median mask 3*3
weighted_mask_med= [1 2 1 ; 2 4 2; 1 2 1].*(1/16);
weighted_filteredIm_med=MedianFiltering(circuit,weighted_mask_med);
%standard 5*5 median mask
standard_mask_med=ones(5,5).*(1/25);
standard_filteredIm_med=MedianFiltering(circuit,standard_mask_med);
%show images
figure;
subplot(1,3,1),imshow(circuit),title('original image');
subplot(1,3,2),imshow(weighted_filteredIm_med),title('3*3 median weighted filter');
subplot(1,3,3),imshow(standard_filteredIm_med),title('5*5 median standard filter');
disp('------Finish Solving Problem 2------');
pause();
%-------------------------------problem 3--------------------------------
moon=imread('Moon.jpg');


%--------------------------------functions area----------------------------

%------------function of average filter
function [filteredIm] = AverageFiltering (im, mask)
[mask_row,mask_col]=size(mask);
%mask must be a square
    if  mask_row~=mask_col
        error('The mask must be a square');
    end
%mask must be odd
if mod(mask_row,2)==0
    error('The dimension must be odd');
end
%mask must be sysmtric around the center 
% if mask~=mask'
%     error('Mask must be ');
% end
%implementing average filter
padding_im=double(im);
[im_row,im_col]=size(im);
%padding 0 to im
padding_row=floor(mask_row/2);
padding_zeros=zeros(padding_row,im_col);
%padding rows
padding_im=[padding_zeros;padding_im;padding_zeros];
%padding columns
padding_col=floor(mask_col/2);
padding_zeros=zeros(size(padding_im,1),padding_col);
padding_im=[padding_zeros,padding_im,padding_zeros];
%loop every pixel
filteredIm=padding_im;
for i=padding_row+1:padding_row+im_row
    for j=padding_col+1:padding_col+im_col
        sub_padding=padding_im(i-padding_row:i+padding_row,j-padding_col:j+padding_col);
        filteredIm(i,j)=sum(sum(sub_padding.*mask));
    
    end
end
filteredIm=uint8(filteredIm);
 
end
%-----------median filter function
function filteredIm = MedianFiltering(im, mask)
[mask_row,mask_col]=size(mask);
%mask must be a square
    if  mask_row~=mask_col
        error('The mask must be a square');
    end
%mask must be odd
if mod(mask_row,2)==0
    error('The dimension must be odd');
end

%implementing average filter
padding_im=double(im);
[im_row,im_col]=size(im);
%padding 0 to im
padding_row=floor(mask_row/2);
padding_zeros=zeros(padding_row,im_col);
%padding rows
padding_im=[padding_zeros;padding_im;padding_zeros];
%padding columns
padding_col=floor(mask_col/2);
padding_zeros=zeros(size(padding_im,1),padding_col);
padding_im=[padding_zeros,padding_im,padding_zeros];
%loop every pixel
filteredIm=padding_im;
for i=padding_row+1:padding_row+im_row
    for j=padding_col+1:padding_col+im_col
        sub_padding=padding_im(i-padding_row:i+padding_row,j-padding_col:j+padding_col);
        %sub_padding=sub_padding.*mask;
        %find median of sub-padding
        %fprintf('median is %d\n',median(sub_padding(:)));
        filteredIm(i,j)=median(sub_padding(:));
    end
end
filteredIm=uint8(filteredIm);
end


