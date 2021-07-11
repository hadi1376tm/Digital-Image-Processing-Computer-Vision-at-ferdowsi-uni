lena = imread('Images\4\Lena.bmp');
barbara = imread('Images\4\Barbara.bmp');
f16 = imread('Images\4\F16.bmp');
baboon = imread('Images\4\Baboon.bmp');

imgs = {lena ,barbara, f16, baboon};
names=["lena","barbara", "f16", "baboon" ];
for i=1:4
 img = rgb2gray(imgs{i});  
figure
imshow(img);
title(names(i)+" orginal image")

img = double(img);
[M,N] = size(img);

fimg = fft2(img,M,N);

%with shifting with log
img = fftshift(fimg);
img = abs(img);
img = log(img);
Max = max(max(img ));
img = (img )*(255/Max);
img = uint8(img);
figure
imshow(img);
title(names(i)+" with shifting with log");

%without shifting with log
img = abs(fimg);
img = log(img);
Max = max(max(img ));
img = (img )*(255/Max);
img = uint8(img);
figure
imshow(img);
title(names(i)+" without shifting with log")

%with shifting without log
img = fftshift(fimg);
img = abs(img);
Max = max(max(img ));
img = (img )*(255/Max);
img = uint8(img);
figure
imshow(img);
title(names(i)+" with shifting without log")

%without shifting without log
img = abs(fimg);
Max = max(max(img ));
img = (img )*(255/Max);
img = uint8(img);
figure
imshow(img);
title(names(i)+" without shifting without log")
end

