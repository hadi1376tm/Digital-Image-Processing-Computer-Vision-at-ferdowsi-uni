image = imread('Images/3/noisy2.jpg');
image = rgb2gray(image);

x = median_filtering(image,7);
x= unsharp_masking_filter(x,2,4);
x=brightness(x,10);

imwrite(image,"image.png");
imwrite(x,"out.png");

function output=median_filtering(image,window_size)
    [R,C] = size(image);
    image = padarray(image,[floor(window_size/2),floor(window_size/2)]);
    output = zeros(R,C,'uint8');
    for i=1:R
        for j=1:C
            part = image(i:i+window_size-1,j:j+window_size-1);
            out = median(part,'all');
            output(i,j) = out;
        end
    end
end

function output=brightness(img,add)
    [R,C] = size(img);
    output = zeros(R,C,'uint8');
    for i=1:R
        for j=1:C
           
            img(i,j)=img(i,j)+add;
            
            output(i,j) = img(i,j);
        end
    end
end


function output=unsharp_masking_filter(image,alpha,i)
        smoothed_img = imgaussfilt(image,i);
        output = image + alpha*(smoothed_img - image);
end