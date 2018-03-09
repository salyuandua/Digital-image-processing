%-------------problem 1---------------
mid1=imread('mid1.JPG');
%------------(1)------------------
if size(mid1,3)==3
    mid1=rgb2gray(mid1);
end
figure,histogram(mid1),title('Histogram for mid1');
pause;
%----------(2)----------------------
hist_eq_mid1=histeq(mid1);
figure;
subplot(1,2,1),imshow(mid1),title('Orginal image')
subplot(1,2,2),imshow(hist_eq_mid1),title('Enhanced image');
pause;
%-----------------problem 2---------------------
mid2=imread('mid2.jpg');
%------------------(1)-----------------------
A=imread('mid2_RC.png');
%C=edge(A,'Sobel',0.1);
C=A;
[A_row,A_col]=size(A);
for i=1:A_row
    for j=1:A_col
    if A(i,j)<=200
        C(i,j)=0;
    else
        C(i,j)=1;
    end
    end
end
C=logical(C);
figure;
imshow(C),title('Object is white and background is black');
pause;
%--------------------------------(2)------------------------------
B=rgb2gray(mid2);
[B_row,B_col]=size(B);
D=B;
E=B;
for i=1:B_row
    for j=1:B_col
        if ~C(i,j)
            D(i,j)=0;
        else
            E(i,j)=0;
        end
        
    end
end
figure;
subplot(1,2,1),imshow(D),title('Image D');
subplot(1,2,2),imshow(E),title('Image E');
pause;
%----------------------------(3)--------------------------
hist_eq_mid2=histeq(B);
for i=1:B_row
    for j=1:B_col
        if ~C(i,j)
            hist_eq_mid2(i,j)=B(i,j);
        end
    end
end
figure,imshow(hist_eq_mid2),title('Only sharpen object');
pause;
%----------------------------(4)----------------------------
average_h=fspecial('Average',3);
smooth_B=imfilter(B,average_h);

for i=1:B_row
    for j=1:B_col
        if C(i,j)
            smooth_B(i,j)=B(i,j);
        end
    end
end
figure;
imshow(smooth_B),title('Only smooth background');
pause;
%---------------------------(5)---------------------------
final_B=B;
for i=1:B_row
    for j=1:B_col
        if C(i,j)%object
            final_B(i,j)=hist_eq_mid2(i,j);
        else
            final_B(i,j)=smooth_B(i,j);
        end
    end
end
figure;
imshow(final_B),title('put togerther');
pause;
%---------------------------problem 3---------------------------
mid4=imread('mid4.png');
% mid4_2=mid4;
% edge_mid4=edge(mid4,'Sobel',0.05);
[mid4_row,mid4_col]=size(mid4);
% h = fspecial('laplacian',0);
% edge_mid4=imfilter(mid4,h);
% logical_mid4=logical(edge_mid4);
mid4_hist_eq=imadjust(mid4);
mask = zeros(size(mid4));
mask(25:end-25,25:end-25) = 1;
bw = activecontour(mid4,mask,500);
mid4_object=mid4;
mid4_background=mid4;
  for i=1:mid4_row
     
      for j=1:mid4_col
         if bw(i,j)%object
             mid4_background(i,j)=255;
         else
             mid4_object(i,j)=255;
          end
      
      end
  end
figure;
subplot(1,2,1),imshow(mid4_object),title('object'); 
subplot(1,2,2),imshow(mid4_background),title('background'); 





















