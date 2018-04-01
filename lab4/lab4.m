%-------------------problem 1--------------------
% city=imread('City.jpg');
% %3*3 SE 
% b=strel('square',3);
% g_city=imsubtract(imdilate(city,b),imerode(city,b));
% figure;
% subplot(1,2,1),imshow(city),title('City.jpg');
% subplot(1,2,2),imshow(g_city),title('Result');
% %-----------------problem 2----------------------
% b1=[0,0,0;0,1,1;0,1,0];
% b2=[1,1,1;1,0,0;1,0,0];
% small_square=imread('SmallSquares.tif');
% eroded_small_square=bwhitmiss(small_square,b1,b2);
% eroded_small_square_num=sum(eroded_small_square(:));
% figure;
% subplot(1,2,1),imshow(small_square),title('Orginal');
% subplot(1,2,2),imshow(eroded_small_square),title('Result');
% fprintf('The number of foreground is %d',eroded_small_square_num);
% 
% %-----------------------problem 3-----------------------
% wirebond=imread('Wirebond.tif');
% b=strel('square',15);
% eroded_wirebond1=imerode(wirebond,b);
% b=strel('square',11);
% eroded_wirebond2=imerode(wirebond,b);
% b=strel('square',45);
% eroded_wirebond3=imerode(wirebond,b);
% figure;
% subplot(1,4,1),imshow(wirebond),title('Orginal Image');
% subplot(1,4,2),imshow(eroded_wirebond1),title('Desired Image 1');
% subplot(1,4,3),imshow(eroded_wirebond2),title('Desired Image 2');
% subplot(1,4,4),imshow(eroded_wirebond3),title('Desired Image 3');
% %------------------------problem 4----------------------
% shape=imread('Shapes.tif');
% b=strel('square',20);
% closed_shape1=imopen(shape,b);
% b=strel('square',20);
% closed_shape2=imclose(shape,b);
% b=strel('square',50);
% closed_shape3=imclose(shape,b);
% imshow(closed_shape3);
%------------------------problem 5-----------------------
%part 1
dowel=imread('Dowels.tif');
b=strel('disk',5,6);
dowel1=operate_img(dowel,b,'open_close');
dowel2=operate_img(dowel,b,'close_open');
%show images
figure;
subplot(1,2,1),imshow(dowel1),title('open and then close');
subplot(1,2,2),imshow(dowel2),title('close and then open');
%part 2



%----------------------function area
function [r]= operate_img(org_img,SE,operation)
    if operation=='open_close'
        %open and then close
        opened_img=imopen(org_img,SE);
        closed_img=imclose(opened_img,SE);
        r=closed_img;
    elseif operation=='close_open'
        %close and then open
        closed_img=imclose(org_img,SE);
        opened_img=imopen(closed_img,SE);
        r=opened_img;
    else
        error('Unsupported operation');
    end
end


