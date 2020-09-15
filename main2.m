clear;
close all;
clc;
%%
addpath('E:\6 Sem\UGP-2\Dehazing paper implementation\L0smoothing\');
addpath('E:\6 Sem\UGP-2\Project_4_haze removal\Project_4_haze removal');
%%
InputHazyImage = imread('hazyreindeer.jpg');
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

%%
beta = 1;
% depth = L0DecompositionInput;
depth = min(im2double(BlendingOutput),[],3);
transmission = exp(-(beta*depth));
%%
% atmospheric = 0.95;
atmospheric = atmLight(im2double(InputHazyImage), depth);
outimag = getRadiance(atmospheric,im2double(InputHazyImage),transmission);
figure;imshow(outimag);
title('Output Image');
%%
