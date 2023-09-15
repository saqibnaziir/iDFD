%  Author: Saqib, nazir, Bucharest Polytechnic University
%  E-mail: saqib.nazir@upb.ro
%  This MATLAB-Code was developed under MATLAB R2021a.
%  -------------------------------------------------------------------------------------------------------------------------------------
%% Mfile name: imageread.m
%  Revision history:
%  24/06/2021  QIU  Original code
%  -------------------------------------------------------------------------------------------------------------------------------------
%  Description: Dispaly the image
%  -------------------------------------------------------------------------------------------------------------------------------------
clc % clear command window
clear % clear workspace
close all % clear all graphics

[file, path] = uigetfile('*.png');
filePath = fullfile(path,file);
img = imread(filePath);
image(img,'CDataMapping','scaled');  % Display image.
colorbar;
impixelinfo;
