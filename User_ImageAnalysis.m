% Title : User-Input Image Analysis 
% Name : Nery A. Matias Calmo 
% Date : 07/03/2024
% Goal : Image analysis where the image is determined to being either RBG
% or in greyscale through conditional statements. Depending on this the 
% code binarizes the image, plotting histograms for gray scale and RGB 
% channels (if image has color),  computes 1D and 2D Fourier Transforms

% Binarize Image 
file_name = input('Enter the file name: ', 's'); %% Prompt user
img = imread(file_name); % Read the image 

% Check if image is RGB or grayscale
if ndims(img) == 3 && size(img, 3) == 3
    % Convert RGB to grayscale
    gray_img = rgb2gray(img);
elseif ismatrix(img)
    % Image is already grayscale
    gray_img = img;
else
    % Handle other image types if needed
    error('Unsupported image type');
end

% Binarize the grayscale image
binary_img = imbinarize(gray_img);

% Create a new figure to combine all plots
figure;

% Plot original image
subplot(3, 3, 1);
imshow(img);
title('Original Image');

% Plot binary image
subplot(3, 3, 2);
imshow(binary_img);
title('Binarized Image');

% Plot grayscale histogram
subplot(3, 3, 3);
imhist(gray_img);
title('Grayscale Histogram');

% Check if the image is RGB for color channel histograms
if ndims(img) == 3 && size(img, 3) == 3
    % Plot red channel histogram
    subplot(3, 3, 4);
    imhist(img(:, :, 1));
    title('Red Channel Histogram');

    % Plot green channel histogram
    subplot(3, 3, 5);
    imhist(img(:, :, 2));
    title('Green Channel Histogram');

    % Plot blue channel histogram
    subplot(3, 3, 6);
    imhist(img(:, :, 3));
    title('Blue Channel Histogram');
else
    % Fill remaining subplots with placeholders if image is not RGB
    subplot(3, 3, 4);
    axis off;
    subplot(3, 3, 5);
    axis off;
    subplot(3, 3, 6);
    axis off;
end

% Perform 1D Fourier Transform
fft_1d = fft(double(gray_img(:)));
subplot(3, 3, 7);
plot(abs(fftshift(fft_1d)));
title('1D Fourier Transform');

% Perform 2D Fourier Transform
fft_2d = fft2(double(gray_img));
subplot(3, 3, 8);
imagesc(log(abs(fftshift(fft_2d)) + 1));
colorbar;
title('2D Fourier Transform');

% Create Title for Figure
sgtitle(sprintf('Combined Image Analysis - %s', file_name));

% Display the figure
set(gcf, 'Position', get(0, 'Screensize')); % Maximize figure window
