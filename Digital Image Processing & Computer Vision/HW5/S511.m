img = imread('Images/5/Lena.bmp');
figure
imshow(img);
title('orginal');
 
R = im2double(img (:,:,1));
G = im2double(img (:,:,2));
B = im2double(img (:,:,3));



tetha = acosd((0.5*((R-G)+(R-B)))./((R-G).^2+(R-B).*(G-B)).^0.5);


%H component
X = B-G;
t = X<=0;
h1 = tetha .*t;
t = X>0;
h2 = (360-tetha) .*t;
H = h1+h2;
H = H./360;

%S component
S = 1 - (3.*min(min(R,G),B)./(R+G+B));

%I component
I = (R+G+B)/3;



figure
imshow(H);
title('Hue');
figure
imshow(S);
title('Saturation');
figure
imshow(I);
title('Intensity');

