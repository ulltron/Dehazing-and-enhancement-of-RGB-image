%% Abdul Wasim. Dated: 11-April-2019.
clear;
close all;
clc;

%%
addpath('E:\6 Sem\UGP-2\Dehazing paper implementation\L0smoothing\');
addpath('E:\6 Sem\UGP-2\Project_4_haze removal\Project_4_haze removal');

% %%
% ClearImage = imread('stadium.jpg');
% HazeAmount = 0.5;
% HazyImage = ClearImage*HazeAmount + (1-HazeAmount)*255;
% figure;
% imshow(ClearImage);
% title('Clear Image');
% % imwrite(Ha  zyImage, 'hazy.jpg');
%%
HazyImage = imread('canyon.png');
InputHazyImage = HazyImage;
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
imwrite(LLFOutput, 'LLF.jpg');
%%
% Partial Visibility Restoration...
PartialVisOutput = hmf(InputHazyImage);
figure;imshow(PartialVisOutput);
title('Partial Visibility Restoration Output');
imwrite(PartialVisOutput, 'PVR.jpg');
%% Blending....
BlendingOutput = imfuse(LLFOutput,PartialVisOutput,'blend','Scaling','joint');
figure;imshow(BlendingOutput);
title('Blending Output');
imwrite(BlendingOutput, 'Blending.jpg');

%%
beta = 1;
depth = min(im2double(BlendingOutput),[],3);
transmission = exp(-(beta*depth));
figure; imshow(transmission);
title('Transmission Map');
imwrite(transmission, 'T_Map.jpg');
%%
% atmospheric = 0.95;
atmospheric = atmLight(im2double(InputHazyImage), depth);
outimag = getRadiance(atmospheric,im2double(InputHazyImage),transmission);
figure;imshow(outimag);
title('Dehazed Image');
imwrite(outimag, 'DehazedImageAloe.jpg');
%% PSNR and SSIM....
PSNROutput = psnr(outimag,im2double(ClearImage));
SSIMOutput = ssim(outimag,im2double(ClearImage));
fprintf('PSNR = %f\n', PSNROutput);
fprintf('SSIM = %f\n', SSIMOutput);
