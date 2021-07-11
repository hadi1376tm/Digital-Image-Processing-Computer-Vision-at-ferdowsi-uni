image = imread('Images/3/Elaine.bmp');
image = double(image);

filter1 = [1 0 -1]/2;
filter2 = [1 0 -1;1 0 -1;1 0 -1]/6;
filter3 = [1 0 -1;2 0 -2;1 0 -1]/8;

img1 = filtering(image,filter1);
img2 = filtering(image,filter2);
img3 = filtering(image,filter3);

imwrite(img1,'out1.png');
imwrite(img2,'out2.png');
imwrite(img3,'out3.png');

function output=filtering(image,filter)
    [R,C] = size(image);
    [x,y] = size(filter);
    image = padarray(image,[1,1]);
    output = zeros(R,C,'double');
    for i=1:R
        for j=1:C
            part = image(i:i+x-1,j:j+y-1);
            mult = part.*filter;
            out = sum(mult,'all');
            output(i,j) = out;
        end
    end
end