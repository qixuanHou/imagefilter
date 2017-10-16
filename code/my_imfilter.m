function output = my_imfilter(image, filter)
% This function is intended to behave like the built in function imfilter()
% See 'help imfilter' or 'help conv2'. While terms like "filtering" and
% "convolution" might be used interchangeably, and they are indeed nearly
% the same thing, there is a difference:
% from 'help filter2'
%    2-D correlation is related to 2-D convolution by a 180 degree rotation
%    of the filter matrix.

% Your function should work for color images. Simply filter each color
% channel independently.

% Your function should work for filters of any width and height
% combination, as long as the width and height are odd (e.g. 1, 7, 9). This
% restriction makes it unambigious which pixel in the filter is the center
% pixel.

% Boundary handling can be tricky. The filter can't be centered on pixels
% at the image boundary without parts of the filter being out of bounds. If
% you look at 'help conv2' and 'help imfilter' you see that they have
% several options to deal with boundaries. You should simply recreate the
% default behavior of imfilter -- pad the input image with zeros, and
% return a filtered image which matches the input resolution. A better
% approach is to mirror the image content over the boundaries for padding.

% % Uncomment if you want to simply call imfilter so you can see the desired
% % behavior. When you write your actual solution, you can't use imfilter,
% % filter2, conv2, etc. Simply loop over all the pixels and do the actual
% % computation. It might be slow.
% output = imfilter(image, filter);


%%%%%%%%%%%%%%%%
% Your code here
%%%%%%%%%%%%%%%%
% 
% 
% get size of image and filter
[rImage, cImage, x] = size(image);
[rFilter, cFilter] = size(filter);

% separate colors
aO = image(:,:,1);
bO = image(:,:,2);
cO = image(:,:,3);



% # of colums and rows I need to insert 
nRow = (rFilter - 1)/2;
row = zeros(nRow, cImage);
nCol = (cFilter - 1)/2;
col = zeros(rImage + 2 * nRow, nCol);

% padding for three colors
a = [row;aO;row];
a = [col a col];
b = [row;bO;row];
b = [col b col];
c = [row;cO;row];
c = [col c col];


% remove paddings

a = getSum(a, filter, cFilter,rFilter, cImage, rImage, aO);
b = getSum(b, filter, cFilter,rFilter, cImage, rImage, bO);
c = getSum(c, filter, cFilter,rFilter, cImage, rImage, cO);


image(:,:,1) = a;
image(:,:,2) = b;
image(:,:,3) = c;


output = image;


end


function final = getSum(matrix, filter, cFilter,rFilter, cImage, rImage, image)
% loop over matrix to do calculation

for i = 1: cImage
    for j = 1 : rImage
        sum = 0;
        for m = 1: cFilter
            for n = 1 : rFilter
                sum = sum + filter(n, m) * matrix(j + n - 1, i + m - 1);

            end
        end

        image(j, i) = sum;
    end
end

% final = matrix(nRow + 1: rImage + nRow, nCol + 1 : cImage + nCol);
final = image;
end


