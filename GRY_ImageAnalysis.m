% Title : GRY Image Analysis
% Name : Nery A. Matias Calmo 
% Date : 07/03/2024
% Goal : image analysis through inputting a greyscale image, binarizing 
% images, plotting histogram for gray scale, and computing 1D and 2D 
% Fourier Transforms 

% Binarize Image 
file_name = input('Enter the file name: ', 's'); %% Prompt user
img = imread(file_name); % Read the image 

figure; 
subplot(1, 2, 1); 
imshow(img); % Display original image
title ('Original Image'); 

gray_img = im2gray(img); % Convert to grayscale
binary_img = imbinarize(gray_img); 
subplot(1, 2, 2); 
imshow(binary_img); % Dispay binary image 
title('Binarized Image'); 

% Plot the Histogram 
figure; 
imhist(gray_img); % greyscale histogram
title('Grayscale Histogram'); 

% Fourier Transforms 

fft_1d = fft(double(gray_img(:))); % 1D FT 
figure; 
subplot(1, 2, 1); 
plot(abs(fftshift(fft_1d))); 
title('1D Fourier Transform'); 

fft_2d = fft2(double(gray_img)); % 2D FT
subplot(1, 2, 2); 
imagesc(log(abs(fftshift(fft_2d))+ 1)); 
colorbar; 
title('2D Fourier Transform'); 