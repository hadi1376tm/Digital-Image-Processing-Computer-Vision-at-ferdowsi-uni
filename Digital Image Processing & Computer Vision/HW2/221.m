%he = imread('Images/2/HE1.jpg');
%he = imread('Images/2/HE2.jpg');
%he = imread('Images/2/HE3.jpg');
he = imread('Images/2/HE4.jpg');
%imshow(he3);

im = rgb2gray(he);
x = local_hist(im,400);
imshow(x);
title('HE4 window size 400');
function L=local_hist(image,local_size)
    [r,c] = size(image);
    radias= local_size/2;
    if((radias*2)>min(r,c))
        radias = floor(((min(r,c))/2)-1);
    end
    s1=floor(((r/2)-radias));
    s2=floor(((r/2)+radias));
    s3=floor(((c/2)-radias));
    s4=floor(((c/2)+radias));
    local = image(s1:s2,s3:s4);
    L = image;
    localhisteq = hist_eq(local);
    L(s1:s2,s3:s4) = localhisteq;

            
end
function new_image = hist_eq(img)
    [r,c,z] = size(img);
    n = r * c;
    
    new_image = zeros(r,c,z,'uint8');
    
    cdf = zeros(256,1,'double');
    pdf = zeros(256,1,'double');
    count = zeros(256,1,'double');
    out = zeros(256,1,'double');
    for i=1:r
        for j=1:c
            value = img(i,j,:);
            count(value+1) = count(value+1)+1;
        end
    end
    pdf = count/n;
    sum = 0; L =255;
    for i=1:256
        sum = sum +pdf(i);
        cdf(i) = sum;
        out(i) = round(cdf(i)*L);
    end
    for i=1:r
        for j=1:c
            new_image(i,j,:) = out(img(i,j,:)+1);
        end
    end
end
