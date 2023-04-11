%  Author: Qiu,Zhouyan, University of Vigo
%  E-mail: zhouyan.qiu@uvigo.es
%  This MATLAB-Code was developed under MATLAB R2021a.
%  -------------------------------------------------------------------------------------------------------------------------------------
%% Mfile name: depthdenoisinginpainting.m
%  Revision history:
%  05/09/2022  QIU  Original code.
%  -------------------------------------------------------------------------------------------------------------------------------------
%  Description: Azure Kinect depth map to DSLR RGB image, batch processing
%  -------------------------------------------------------------------------------------------------------------------------------------
%  Input:
%  
%  -------------------------------------------------------------------------------------------------------------------------------------
%  Output:
%  
%  -------------------------------------------------------------------------------------------------------------------------------------
clc % clear command window
clear % clear workspace
close all % clear all graphics

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

for j = 1:num
    fprintf(1, 'Now reading %s\n', my_dir_capture(j).name);
    capture_name = fullfile(my_folder, my_dir_capture(j).name);
    list = dir(capture_name);

    depth_img_name = fullfile(capture_name, "depth.png");
    depth_img = imread(depth_img_name);

    dslr_dir = dir(fullfile(capture_name, 'F10', '*.JPG'));
    dslr_name = fullfile(dslr_dir.folder,dslr_dir.name);
    dslr_img = imread(dslr_name);

    rgb_dir = dir(fullfile(capture_name, 'RGB', '*.PNG'));
    rgb_name = fullfile(rgb_dir(1).folder,rgb_dir(1).name);
    rgb_img = imread(rgb_name);

    MOVINGREG = registerImages(rgb_img, dslr_img, depth_img);
    depth_reg = MOVINGREG.RegisteredImage;

    name = strcat(my_dir_capture(j).name, '_depth_reg.png');
    depth_reg_name = fullfile(capture_name,name);
    imwrite(depth_reg, depth_reg_name);
end