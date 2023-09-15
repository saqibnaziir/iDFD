%  Author: Saqib, nazir, Bucharest Polytechnic University
%  E-mail: saqib.nazir@upb.ro
%  This MATLAB-Code was developed under MATLAB R2021a.
%  -------------------------------------------------------------------------------------------------------------------------------------
%% Mfile name: dirshowallimages.m
%  Revision history:
%  24/06/2021  QIU  Original code
%  -------------------------------------------------------------------------------------------------------------------------------------
%  Description: Dispaly all the images in the selected dir
%  -------------------------------------------------------------------------------------------------------------------------------------
clc % clear command window
clear % clear workspace
close all % clear all graphics

my_folder = uigetdir('', 'Open image files');
file_pattern = fullfile(my_folder, '*.png');
depth_files = dir(file_pattern);
length = length(depth_files);

for k = 1:length
    base_fileName = depth_files(k).name;
    full_fileName = fullfile(my_folder, base_fileName);
    fprintf(1, 'Now reading %s\n', full_fileName);
    depth_array = imread(full_fileName);
    image(depth_array,'CDataMapping','scaled');  % Display image.
    colorbar;
    drawnow; % Force display to update immediately.
    impixelinfo;
end
