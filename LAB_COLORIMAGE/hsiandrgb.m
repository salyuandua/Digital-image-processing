function rgb = hsi2rgb(hsi) 
%HSI2RGB Converts an HSI image to RGB. 
%   RGB = HSI2RGB(HSI) converts an HSI image to RGB, where HSI is 
%   assumed to be of class double with:   
%     hsi(:, :, 1) = hue image, assumed to be in the range 
%                    [0, 1] by having been divided by 2*pi. 
%     hsi(:, :, 2) = saturation image, in the range [0, 1]. 
%     hsi(:, :, 3) = intensity image, in the range [0, 1]. 
% 
%   The components of the output image are: 
%     rgb(:, :, 1) = red. 
%     rgb(:, :, 2) = green. 
%     rgb(:, :, 3) = blue. 

% Extract the individual HSI component images. 
H = hsi(:, :, 1) * 2 * pi; 
S = hsi(:, :, 2); 
I = hsi(:, :, 3); 

% Implement the conversion equations. 
R = zeros(size(hsi, 1), size(hsi, 2)); 
G = zeros(size(hsi, 1), size(hsi, 2)); 
B = zeros(size(hsi, 1), size(hsi, 2)); 

% RG sector (0 <= H < 2*pi/3). 
idx = find( (0 <= H) & (H < 2*pi/3)); 
B(idx) = I(idx) .* (1 - S(idx)); 
R(idx) = I(idx) .* (1 + S(idx) .* cos(H(idx)) ./ cos(pi/3 - H(idx))); 
G(idx) = 3*I(idx) - (R(idx) + B(idx)); 

% BG sector (2*pi/3 <= H < 4*pi/3). 
idx = find( (2*pi/3 <= H) & (H < 4*pi/3) ); 
R(idx) = I(idx) .* (1 - S(idx)); 
G(idx) = I(idx) .* (1 + S(idx) .* cos(H(idx) - 2*pi/3) ./ cos(pi - H(idx))); 
B(idx) = 3*I(idx) - (R(idx) + G(idx)); 

% BR sector. 
idx = find( (4*pi/3 <= H) & (H <= 2*pi)); 
G(idx) = I(idx) .* (1 - S(idx)); 
B(idx) = I(idx) .* (1 + S(idx) .* cos(H(idx) - 4*pi/3) ./ cos(5*pi/3 - H(idx))); 
R(idx) = 3*I(idx) - (G(idx) + B(idx)); 

% Combine all three results into an RGB image.  Clip to [0, 1] to 
% compensate for floating-point arithmetic rounding effects. 
rgb = cat(3, R, G, B); 
rgb = max(min(rgb, 1), 0); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function hsi = rgb2hsi(rgb) 
%RGB2HSI Converts an RGB image to HSI. 
%   HSI = RGB2HSI(RGB) converts an RGB image to HSI. The input image 
%   is assumed to be of size M-by-N-by-3, where the third dimension 
%   accounts for three image planes: red, green, and blue, in that 
%   order. If all RGB component images are equal, the HSI conversion 
%   is undefined. The input image can be of class double (with values 
%   in the range [0, 1]), uint8, or uint16.  
% 
%   The output image, HSI, is of class double, where: 
%     hsi(:, :, 1) = hue image normalized to the range [0, 1] by 
%                    dividing all angle values by 2*pi.  
%     hsi(:, :, 2) = saturation image, in the range [0, 1]. 
%     hsi(:, :, 3) = intensity image, in the range [0, 1]. 

% Extract the individual component immages. 
rgb = im2double(rgb); 
r = rgb(:, :, 1); 
g = rgb(:, :, 2); 
b = rgb(:, :, 3); 

% Implement the conversion equations. 
num = 0.5*((r - g) + (r - b)); 
den = sqrt((r - g).^2 + (r - b).*(g - b)); 
theta = acos(num./(den + eps)); 

H = theta; 
H(b > g) = 2*pi - H(b > g); 
H = H/(2*pi); 

num = min(min(r, g), b); 
den = r + g + b; 
den(den == 0) = eps; 
S = 1 - 3.* num./den; 

H(S == 0) = 0; 

I = (r + g + b)/3; 

% Combine all three results into an hsi image. 
hsi = cat(3, H, S, I);

