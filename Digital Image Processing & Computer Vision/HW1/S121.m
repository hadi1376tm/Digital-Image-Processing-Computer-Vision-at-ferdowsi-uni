
image = imread("Images/1/Barbara.bmp");

%rgb2gray
x = rgb2gray(image);
level4= 64*round(x/64);
level8 =32*round(x/32);
level16 =16*round(x/16);
level32 =8*round(x/8);
level64 =4*round(x/4);
level128 =2*round(x/2);


figure
subplot(2,4,1)
imshow(x);
title(immse(x,x));
subplot(2,4,2)
imshow(level128);
title(immse(level128,x));
subplot(2,4,3)
imshow(level64);
title(immse(level64,x));
subplot(2,4,4)
imshow(level32);
title(immse(level32,x));
subplot(2,4,5)
imshow(level16);
title(immse(level16,x));
subplot(2,4,6)
imshow(level8);
title(immse(level8,x));
subplot(2,4,7)
imshow(level4);
title(immse(level4,x));




%histeq

x = histeq(x);

level4= 64*round(x/64);
level8 =32*round(x/32);
level16 =16*round(x/16);
level32 =8*round(x/8);
level64 =4*round(x/4);
level128 =2*round(x/2);

figure
subplot(2,4,1)
imshow(x);
title(immse(x,x));
subplot(2,4,2)
imshow(level128);
title(immse(level128,x));
subplot(2,4,3)
imshow(level64);
title(immse(level64,x));
subplot(2,4,4)
imshow(level32);
title(immse(level32,x));
subplot(2,4,5)
imshow(level16);
title(immse(level16,x));
subplot(2,4,6)
imshow(level8);
title(immse(level8,x));
subplot(2,4,7)
imshow(level4);
title(immse(level4,x));