% Title : Video to Images and Rotation
% Name : Avijit Paul, Nery A. Matias Calmo
% Date : 07/09/2024 
% Goal : to convert a video into individual frames (matrixes) that are
% saved into an array. These images as a collective are rotated in order to
% create a new array deck 

% Ask for directories by user
inputDir = input('Enter the File Path: ', 's'); % Folder / directory containing video files
outputDirName = input('New Array Folder Name: ', 's'); % New folder / directory for created arrays
outputDir = fullfile(inputDir, outputDirName);

if ~exist(outputDir, 'dir') % Checks if the directory exists
    mkdir(outputDir); % True(dir doesnt exist) it creates a new one
end 

% Create a path for the rotated output array images
rotatedOutputDir = fullfile(inputDir, [outputDirName '_Rotated']);
if ~exist(rotatedOutputDir, 'dir') % Create directory if it does not exist
    mkdir(rotatedOutputDir);
end

% Obtain video files 
videoFiles = dir(fullfile(inputDir, '*.mp4')); 

% Loop through each video file 
for vidIdx = 1:length(videoFiles)
    % Read video file 
    videoPath = fullfile(inputDir, videoFiles(vidIdx).name); 
    v = VideoReader(videoPath);

    ii = 1;
    td_frame = []; % Initialize the array to hold frames
    
    while hasFrame(v)
        nm = num2str(ii) + ".tiff";
        frame = readFrame(v);
        frame(113:151,929:981,:) = 0;
        frame = frame(100:624,175:972,:);
        frame = rgb2gray(frame);
        frame = imresize(frame,[128, 128]);
        td_frame(:,:,ii) = frame;
        imwrite(frame,nm);
         ii = ii + 1;
    end

    reqd = td_frame(:, :, 15:78);
    
% Save the processed frames to a .mat file in the output directory
    [~, name, ~] = fileparts(videoFiles(vidIdx).name);
    save(fullfile(outputDir, [name '_processed.mat']), 'reqd');
    
    % Rotate and save images in the rotated output directory
    angle = 45;
    img = imrotate(reqd, angle);
    img = imresize(img, [128, 128]);
    for jj = 1:size(img, 3)
        rotatedFrame = img(:, :, jj);
        imwrite(rotatedFrame, fullfile(rotatedOutputDir, [name '_frame' num2str(jj) '_rotated.tiff']));
    end
    
    % Save the rotated frames as a .mat file in the rotated output directory
    save(fullfile(rotatedOutputDir, [name '_rotated.mat']), 'img');
end
