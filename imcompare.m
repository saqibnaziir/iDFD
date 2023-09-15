%  Author: Saqib, nazir, Bucharest Polytechnic University
%  E-mail: saqib.nazir@upb.ro
%  This MATLAB-Code was developed under MATLAB R2021a.
%  -------------------------------------------------------------------------------------------------------------------------------------
%% Mfile name: dirshowallimages.m
%  Revision history:
%  24/06/2022  QIU  Original code
%  -------------------------------------------------------------------------------------------------------------------------------------
%  Description: Compare the registered IR image and the RGB image
%  -------------------------------------------------------------------------------------------------------------------------------------
% clc % clear command window
% clear % clear workspace
% close all % clear all graphics

my_folder1 = uigetdir('', 'Open image files 1');
file_pattern1 = fullfile(my_folder1, '*.jpg');
files1 = dir(file_pattern1);

my_folder2 = uigetdir(my_folder1, 'Open image files 2');
file_pattern2 = fullfile(my_folder2, '*.png');
files2 = dir(file_pattern2);

len1=length(files1);

for k=1:len1
    base_fileName1 = files1(k).name;
    full_fileName1 = fullfile(my_folder1, base_fileName1);
    img_array1 = imread(full_fileName1);
    
    base_fileName2 = files2(k).name;
    full_fileName2 = fullfile(my_folder2, base_fileName2);
    img_array2 = imread(full_fileName2);
    
    imshowpair(img_array1, img_array2, 'blend')
    drawnow;
end
