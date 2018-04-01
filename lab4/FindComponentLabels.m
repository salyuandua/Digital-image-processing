% This FindComponentLabels function is to label connected objects in binary image 
%%% input: 
% im: original binary image
% se: structuring element

%%% output: 
% labelIm:  labeled image which contains the labeled connected objects (start labeling at 1)
% num: number of connected objects found in original binary image

% by JINGRU Zhang
function [labelIm, num] = FindComponentLabels(im, se)
im=double(im);
[row col]=size(im);
label=0;
%%%%%%%%% Note %%%%%%%%%%%%%%%%
% First j and then i is to keep consistant with matlab function bwlabel.
% Keep this sequence will generate the same result with matlab function
% bwlabel.
%%%%%%%%% Note %%%%%%%%%%%%%%%%
for j=1:col
    for i=1:row
       if im(i,j)==1
           OldIm=zeros(row,col);
           OldIm(i,j)=1;
           NewIm=double(imdilate(OldIm,se)&im);
           while(isequal(OldIm,NewIm)==0)
               OldIm=NewIm;
               NewIm=double(imdilate(OldIm,se)&im);
           end
           label=label-1;
           im(find(NewIm>0))=label;
       end
    end 
end
labelIm=abs(im);
num=abs(label);