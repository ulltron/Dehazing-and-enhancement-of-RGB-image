A = imread('cameraman.tif');
B = imrotate(A,5,'bicubic','crop');
C = imfuse(A,B,'blend','Scaling','joint');
imshow(C)
imwrite(C,'my_blend_overlay.png');