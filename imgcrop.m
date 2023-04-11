%  Author: Qiu,Zhouyan, University of Vigo
%  E-mail: zhouyan.qiu@uvigo.es
%  This MATLAB-Code was developed under MATLAB R2021a.
%  -------------------------------------------------------------------------------------------------------------------------------------
%% Mfile name: depthdenoisinginpainting.m
%  Revision history:
%  09/06/2021  QIU  Original code.
%  -------------------------------------------------------------------------------------------------------------------------------------
%  Description: image crop
%  -------------------------------------------------------------------------------------------------------------------------------------
%  Input:
%  open folder with image series
%  -------------------------------------------------------------------------------------------------------------------------------------
%  Output:
%  Cropped images
%  -------------------------------------------------------------------------------------------------------------------------------------
clc % clear command window
clear % clear workspace
close all % clear all graphics

% my_folder = uigetdir('D:/Vigo/Screipts/Test/');
% file_pattern = fullfile(my_folder, '*.jpg');
% file_name = dir(file_pattern);
file_name = dir('G:\Mesuem\1\RGB\Captures\1');
length = length(file_name);

%p=parpool(4); % parpool setting

tic;

%parfor
for k = 1:length
    base_fileName = file_name(k).name;
    full_fileName = fullfile(file_name(k).folder, base_fileName);
    fprintf(1, 'Now reading %s\n', full_fileName);
    I = imread(full_fileName);
    %targetSize = [1024 1024];
    %r = centerCropWindow2d(size(I), targetSize);
%     J = imcrop(I);
%     [J,rect] = imcrop(I);
    J = imcrop(I, [860 250 1050 1050]);
    imwrite(J, full_fileName);
end

toc;

%delete(gcp('nocreate'));