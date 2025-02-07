% Title : Edge Segmentation and Color Segmentation
% Name : Nery A. Matias Calmo 
% Date : 07/04/2024
% Goal : takes in an input image and performs both edge-based segmentation 
% and color-based segmentation. Edge Segmentation will be used via Canny
% Edge Detector and Color Segmentation will use the k-means clustering
% algorithm to segment the image based on color 

% Read the input image
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

% Perform edge detection using Canny method
edgeImage = edge(gray_img, 'Canny');

% Display the original image and edge detected image
figure;
subplot(1, 3, 1); 
imshow(img);
title('Original Image');

subplot(1, 3, 2); 
imshow(edgeImage);
title('Edge Detected Image');

% Perform color-based segmentation using k-means clustering
numColors = 3; % Number of clusters
pixelData = reshape(img, [], 3); % Reshape image into a list of RGB values

% Perform k-means clustering
[clusterIdx, clusterCenters] = kmeans(double(pixelData), numColors, 'distance', 'sqEuclidean', 'Replicates', 3);

% Reshape the clustered data back into the image size
segmentedImage = reshape(clusterIdx, size(img, 1), size(img, 2));

% Display the color segmented image
subplot(1, 3, 3)
imshow(label2rgb(segmentedImage));
title('Color Segmented Image');

% Create Title for Figure
sgtitle(sprintf('Combined Image Segmentation - %s', file_name));

% Display the figure
set(gcf, 'Position', get(0, 'Screensize')); % Maximize figure window
