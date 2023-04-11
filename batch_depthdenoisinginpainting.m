%  Author: Qiu,Zhouyan, University of Vigo
%  E-mail: zhouyan.qiu@uvigo.es
%  This MATLAB-Code was developed under MATLAB R2021a.
%  -------------------------------------------------------------------------------------------------------------------------------------
%% Mfile name: depthdenoisinginpainting.m
%  Revision history:
%  19/06/2022  QIU  Original code.
%  -------------------------------------------------------------------------------------------------------------------------------------
%  Description: Generate a denoised depth map from a set of depth maps
%  -------------------------------------------------------------------------------------------------------------------------------------
%  Input:
%  open folder with depth series
%  -------------------------------------------------------------------------------------------------------------------------------------
%  Output:
%  denoised-depth-inpainting map
%  -------------------------------------------------------------------------------------------------------------------------------------
clc % clear command window
clear % clear workspace
close all % clear all graphics

%my_folder = uigetdir('F:\VigoDataset\Lab_2', 'MATLAB Root Folder');
my_folder = 'G:\Vigo_RAW\Lab\Lab_8\CCAP\';
my_dir = dir(my_folder);

for k = 1:size(my_dir)
    pat = ["1","2","3","4","5","6","7","8","9","0"];
    TF = contains(my_dir(k).name, pat, 'IgnoreCase', true);

    if TF
        my_dir(k).capture = 1;
    end

end

my_dir_capture = my_dir(~cellfun('isempty', {my_dir.capture}));

num = length(my_dir_capture);

p=parpool(8); % parpool setting

tic;

parfor j = 1:num
    
    fprintf(1, 'Now reading %s\n', my_dir_capture(j).name);
    file_pattern = fullfile(my_folder, my_dir_capture(j).name, 'Trans_depth', '*.PNG');
    depth_files = dir(file_pattern);
    % length = length(depth_files); The temporary variable 'length' must be set before it is used. 
    length = 40;
    depth_series = zeros(1536, 2048, length);

    for k = 1:length
        base_fileName = depth_files(k).name;
        full_fileName = fullfile(my_folder, my_dir_capture(j).name, 'Trans_depth',base_fileName);
        depth_array = imread(full_fileName);
        depth_series (:, :, k) = depth_array;
    end

    % Original results
    mean_depth = mean(depth_series, 3);
    std_depth = std(depth_series, 0, 3);

    % denoised results
    size_array = size(depth_array);
    non_zero_mode_depth = zeros(size_array);
    non_zero_std_depth = zeros(size_array);
    non_zero_depth_series = depth_series;

    for m = 1:size_array(1)

        for n = 1:size_array(2)
            % delete noise
            array = non_zero_depth_series(m, n, :);

            if sum(sum(array ~= 0)) <= length / 2
                non_zero_depth_series(m, n, :) = zeros(1, 1, length);
                non_zero_mode_depth(m, n) = 0;
            else
                non_zero_Array = array(find(array));
                non_zero_mode_depth(m, n) = mode(non_zero_Array);
            end

        end

    end

    % Restore specific image regions using coherence transport based image inpainting
    mask = imbinarize(non_zero_mode_depth, 0);
    depth_result = inpaintCoherent(non_zero_mode_depth, ~mask);

    depth_uint16 = uint16(non_zero_mode_depth);
    depth_uint16_IP = uint16(depth_result);
    save_fileName = fullfile(my_folder, my_dir_capture(j).name, "depth.png");
    imwrite(depth_uint16, save_fileName, "png");
    save_fileName1 = fullfile(my_folder, my_dir_capture(j).name, "depth_inpainting.png");
    imwrite(depth_uint16_IP, save_fileName1, "png");
end

toc;
% Elapsed time is 1156.332201 seconds.

delete(gcp('nocreate'));