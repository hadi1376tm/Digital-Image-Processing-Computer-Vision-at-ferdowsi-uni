image = imread('Images\2\Camera Man.bmp');
new_image = hist_eq(image);
hist_orig = Img_Hist(image);
hist_eqimg = Img_Hist(new_image);
subplot(2,2,1);
imshow(image);
title('original');
subplot(2,2,2);
bar(hist_orig);
subplot(2,2,3);
imshow(new_image);
title('histeq');
subplot(2,2,4);
bar(hist_eqimg);


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


function Hist = Img_Hist(img)
    [R,C]=size(img);
    Hist=zeros(256,1);
    for r = 1:R
        for c=1:C
            Hist(img(r,c)+1,1)=Hist(img(r,c)+1,1)+1;
        end
    end
end