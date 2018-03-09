%----------------------Lab 3.2    Xuejian Li
%-----------------------------problem 1--------------------------------
 rice=imread('Rice.jpg');
 double_rice=double(rice);
% scaled_rice=double_rice./max(double_rice(:));%min(scaled_rice(:))

 sobel_rice= edge(rice,'Sobel',0.1);
 figure;
 subplot(1,2,1),imshow(rice);
 subplot(1,2,2),imshow(sobel_rice);
 disp('All rice disappear if 0.2 picked, so 0.1 is an appropriate one')
disp('------Finish Solving Problem 1------');
pause;
%-------------------------------problem2--------------------------------
text=imread('Text.gif');
org_text=text;
[row,col]=size(text);
white=max(text(:));%highest indensity
black=min(text(:));%lowest indensity

for i=1:row
    median_val=median(text(i,:));
    for j=1:col%if (i,j)<0.5*median,set (i,j) to black, otherwise, set it to white
        if text(i,j)>(median_val/2)
            text(i,j)=white;
        else
            text(i,j)=black;
        end
    end
end 
figure;
subplot(1,2,1),imshow(org_text),title('Original image');
subplot(1,2,2),imshow(text),title('Result');
disp('Computing median value of each row, if the value of a pixel in this row greater than half of median, set this pixel to ');
disp('highest indensity value, otherwise, set it to lowest indensity value');
disp('------Finish Solving Problem 2------');
pause;


