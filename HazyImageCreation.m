clear;
close all;
clc;
%%
ClearImage = imread('Aloe.png');
HazeAmount = 0.6;
HazyImage = ClearImage*HazeAmount + (1-HazeAmount)*255;
figure;
imshow(HazyImage);
