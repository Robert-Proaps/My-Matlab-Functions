function [img] = svdCompression(img, comp)
%Usage: Takes in a png, and an integer representing the quality of
%compression.
%Returns: The compressed image.

%Split the image into its component colors.
imRed = double(img(:,:,1));
imGrn = double(img(:,:,2));
imBlu = double(img(:,:,3));

%Decompose each matrix.
[Ur, Sr, Vr] = svd(imRed, 'econ');
[Ug, Sg, Vg] = svd(imGrn, 'econ');
[Ub, Sb, Vb] = svd(imBlu, 'econ');

%Reconstruct the image at a lower quality.
imRed = uint8(Ur(:, 1:comp) * Sr(1:comp, 1:comp) * Vr(:, 1:comp)');
imGrn = uint8(Ug(:, 1:comp) * Sg(1:comp, 1:comp) * Vg(:, 1:comp)');
imBlu = uint8(Ub(:, 1:comp) * Sb(1:comp, 1:comp) * Vb(:, 1:comp)');

%Concatonate the color channels back into one image.
img = cat(3, imRed, imGrn, imBlu);
end
