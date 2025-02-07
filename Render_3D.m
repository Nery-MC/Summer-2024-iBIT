% Title : 3D Render from Images
% Name : Avijit Paul, Nery A. Matias Calmo
% Date : 07/26/2024 
% Goal : to convert a series of images (about 180 frames) to be rendered
% in the 3D plane. 

% Initialize Directories 
folderPath = input('Enter the File Path: ', 's'); % Folder / directory containing image files
outputFolderPath = fullfile(folderPath, '3D_Render'); 
if ~exist(outputFolderPath, 'dir')
    mkdir(outputFolderPath); 
end 

% List of file types
bmpFiles = dir(fullfile(folderPath, '*.bmp')); % List of all .bmp files
jpgFiles = dir(fullfile(folderPath, '*.jpg')); % List of all .jpg files

% Combine the list of .bmp and .jpg files 
imageFiles = [bmpFiles, jpgFiles]; 

% Checks in there are any .bmp files 
if isempty(imageFiles)
    error('No .bmp or .jpg files found'); 
end 

% Initialize a cell array to store the images
imageArray = cell(1, length(imageFiles)); 

% Read each image and store in the array 
for i = 1:length(imageFiles)
    % Construct the full file name and read the image
    fileName = fullfile(folderPath, imageFiles(i).name);
    imageArray{i} = imread(fileName); 
end 

% Stack the images into a 3D array (Assuming all images are the same size
[height, width, ~] = size(imageArray{1}); 
numImages = length(imageArray);
imageStack = zeros(height, width, numImages); 

% Converts to grayscale 
for i = 1:numImages
    imageStack(:, :, i) = rgb2gray(imageArray{i}); 
end 

% Create 3D render 
figure; 
volumeViewer(imageStack); 

% Save the 3D render as a .mat file 
save(fullfile(outputFolderPath, '3D_Render.mat'), 'imageStack'); 
