% Title : Split and Save 3D Render Frames in Overlapping Batches
% Name : Nery A. Matias Calmo 
% Date : 08/01/2024
% Goal : to input a 3D render of 64 frames and split it up in batches of 5
% frames. An index for file naming (to avoid overiding data) and the frames
% from 1 - 64, are used for organization. New .mat files are saved in a new 
% folder

SaveDir = input('Enter Save Directory: ', 's'); % Folder / directory containing image files
outputFolderPath = fullfile(SaveDir, 'Render_SplitUp'); 
if ~exist(outputFolderPath, 'dir')
    mkdir(outputFolderPath); 
end 

matrix = rand(100, 100, 64); % Create a 3D file (size = 100x100x64)

newSize = 5; % number of frames in each new matrix
numFrames = size(matrix, 3); % total numbe of frames in original matrix (64)

% Initialize the first frame 
startFrame = 1; 

% Loop to create new renders 
fileIdx = 1; 

while startFrame + newSize - 1 <= numFrames % loop runs as long as the end frame does not exceed total number of frames
    endFrame = startFrame + newSize - 1; % last frame in the new matrix, indicating where to end
    newData = matrix(:, :, startFrame:endFrame); 
    newFileName = fullfile(outputFolderPath, sprintf('%02d[%02d_to_%02d].mat', fileIdx, startFrame, endFrame)); 
    
    save(newFileName, 'newData'); 

    % Move the start frame up by 2 to create overlapping frames
    startFrame = startFrame + 2; 
    % Increase index for counting 
    fileIdx = fileIdx + 1; 
end 
