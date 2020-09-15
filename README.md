# Dehazing-and-enhancement-of-RGB-image
Converted a hazy RGB image into grey scale image and passed it through an accelerated Local Laplacian Filter to restore the edges of the hazy image and separately applied hybrid median filter algorithm on the hazy image to restore the visibility
Used multiply mode for blending the LLF and HMF output and taking the blending output as depth map of image,developed a transmission map for the hazy input and hence enhanced the image using atmospheric light and transmission map
