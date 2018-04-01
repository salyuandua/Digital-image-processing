%% problem 1
% Rice = imread('Rice.jpg');
% sobel_edge = edge(Rice,'sobel',0.1);
% figure;
% subplot(2,2,1),imshow(Rice),title('original image');
% 
% subplot(2,2,2),imshow(sobel_edge),title('process image');
% disp('The reason I choose 0.1 as the threashhold is that I try many different values like 0.2, 0.3 and 0.5, and I found 0.1 is the best of them. ');
% disp('%-----Finish Solving Problem 1-----');
% pause;

%% problem 2
Text = imread('Text.gif');
processText = Text;
[row_text,col_text] = size(Text);
averageImage = zeros(row_text,1);
for i = 1:row_text
    averageImage(i,1) = median(processText(i,:));
    for j = 1:col_text
        if processText(i,j)>averageImage(i,1)/2
            processText(i,j)=255;
        end
    end
end

figure;
%subplot(2,2,1),imshow(Text),title('original image');
%subplot(2,2,2),bar(1:row_text,averageImage(:,1)),title('average value of every row');
imshow(processText), title('process image');
disp('At first, I calculate the average value of every row, and I will put the value of point which is higher than half of average value into white because the text in image have the lowest value and the value of streaks is higher than than of text');
disp('when I use average value as the dividing line, some of streaks cannot change to white, so I choose the half of average value and also half of average value is higher than that of the text');
disp('%-----Finish Solving Problem 2-----');