%%%% Jingru Zhang
%%%% This function is to median filter image.

function filteredIm = MedianFiltering(im, mask)

% check input image, it should be uint8
if ~isa(im, 'uint8')
   disp('Input image Error: input image should be uint8.');
   return;
end

% check the mask, it should be square
[row,col]=size(mask);
if row~=col
   disp('Input mask Error: input mask should be square.');
   return;
end
if mod(row,2)==0 || mod(col,2)==0 % mod=0 for even, mod=1 for odd
   disp('Input mask Error: mask dimension should be odd.');
   return;
end
if ~isequal(mask,mask') % symmetric around the center: mask==mask'
   disp('Input mask Error: mask should be symmetric around the center.');
   return;
end

%% median filtering
[row_im,col_im]=size(im);
ExtendIm=zeros(row_im+2*floor(row/2),col_im+2*floor(col/2)); % mask is square, so row==col
ExtendIm(floor(row/2+1):floor(row_im+row/2),floor(col/2+1):floor(col_im+col/2))=im;
filteredIm=ExtendIm;
for r=floor(row/2+1):floor(row_im+row/2)
    for c=floor(col/2+1):floor(col_im+col/2)
        Array=[];
        for r2= r-floor(row/2):r+floor(row/2)
            for c2= c-floor(col/2):c+floor(col/2)
               Array=[Array;ExtendIm(r2,c2)*ones(mask(r2-(r-floor(row/2))+1,c2-(c-floor(col/2))+1),1)];
            end
        end
        filteredIm(r,c)= median(Array);
    end
end
filteredIm=filteredIm(floor(row/2+1):floor(row_im+row/2),floor(col/2+1):floor(col_im+col/2));
filteredIm=uint8(filteredIm); % the output should be with data type uint8
