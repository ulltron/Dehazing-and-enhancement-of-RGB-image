clear;
close all;
clc;
%%
addpath('E:\6 Sem\UGP-2\Dehazing paper implementation\L0smoothing\');
addpath('E:\6 Sem\UGP-2\Project_4_haze removal\Project_4_haze removal');
%%
InputHazyImage = imread('girls.jpg');
figure;imshow(InputHazyImage);
title('Input Image');
%%
% Gray Image...
GrayImage = rgb2gray(InputHazyImage);
% Accelerated LLF...
sigma = 0.001;alpha = 2.0; % these parameters need to be tuned.
LLFOutput = locallapfilt(GrayImage, sigma, alpha);
% LLFOutput = max(InputHazyImage,[],3);
figure;imshow(LLFOutput);
title('LLF Output');
%%
% Partial Visibility Restoration...
PartialVisOutput = hmf(InputHazyImage);
figure;imshow(PartialVisOutput);
title('Partial Visibility Restoration Output');
%% Blending....
BlendingOutput = imfuse(LLFOutput,PartialVisOutput,'blend','Scaling','joint');
figure;imshow(BlendingOutput);
title('Blending Output');
%% RGB to HSI Conversion...
% HSIImage = rgbtohsi(BlendingOutput);
% figure;imshow(HSIImage);
% title('HSI Output Image');
% HSIImage(:,:,3)
%%
% HSVImage = rgb2hsv(BlendingOutput);
% figure; imshow(HSVImage);
% title('HSV Output Image');
% HSVImage(:,:,3)
% %% L0 decomposition....
%  L0DecompositionInput = HSVImage(:,:,3);
%  L0DecompositionOutput = L0Smoothing(L0DecompositionInput,0.003);
%  figure;imshow(L0DecompositionOutput);
%  title('L0 Decomposition Output');
%% Final Image Formation....
% Replace I component...
%  HSVImage(:,:,3) = L0DecompositionOutput;
% HSI to RGB conversion....
%OutputImage = hsi2rgb(HSIImage);
%figure;imshow(OutputImage);
%title('Output Image');
%%
% RGBImage = hsv2rgb(HSVImage);
% figure; imshow(RGBImage);
% title('Output Image');
%%
beta = 1;
% depth = L0DecompositionInput;
depth = min(im2double(BlendingOutput),[],3);
transmission = exp(-(beta*depth));
%%
% atmospheric = 0.95;
atmospheric = atmLight(im2double(InputHazyImage), depth);
outimag = getRadiance(atmospheric,im2double(InputHazyImage),transmission);
figure;imshow(outimag)
