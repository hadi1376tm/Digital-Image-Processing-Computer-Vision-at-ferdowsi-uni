image = imread('Images/3/Elaine.bmp');
filters = [3;5;7;9;11];
alpha = [0.5;1;2];

for i=1:size(filters)
    f=filters(i);
    smoothed_img = imgaussfilt(image,f);
    imwrite(smoothed_img,"smoothed_filter"+f+".png");
    for j =1:size(alpha)
        a = alpha(j);
        new_image = image + a*(smoothed_img - image);
        %imwrite(new_image,"alpha"+a+"filter"+f+".png");
        figure 
        imshow(new_image);
        title("alpha="+a+",filter="+f+"*"+f);

    end
end
