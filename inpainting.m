%  Author: Saqib, nazir, Bucharest Polytechnic University
%  E-mail: saqib.nazir@upb.ro
clc % clear command window
clear % clear workspace
close all % clear all graphics

my_folder = uigetdir('', 'Open image files');
file_pattern = fullfile(my_folder, '*.png');
file_name = dir(file_pattern);
length = length(file_name);

p=parpool(4); % parpool setting

tic;

parfor k = 1:length
    base_fileName = file_name(k).name;
    full_fileName = fullfile(file_name(k).folder, base_fileName);
    fprintf(1, 'Now reading %s\n', full_fileName);
    I = imread(full_fileName);
    mask = imbinarize(I, 0);
    J = inpaintCoherent(I, ~mask);
    imwrite(J, full_fileName);
end

toc;

delete(gcp('nocreate'));
