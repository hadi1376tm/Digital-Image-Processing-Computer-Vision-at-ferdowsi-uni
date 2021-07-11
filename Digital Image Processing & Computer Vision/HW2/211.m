
image = imread('Images\2\Camera Man.bmp');
hist =Img_Hist(image);
figure
subplot(2,1,1);
imshow(image);
title('original');
subplot(2,1,2);
bar(hist);

D = devide_func(image,3);
histD =Img_Hist(D);
figure
subplot(2,1,1);
imshow(D);
title('dividing intensity by 3');
subplot(2,1,2);
bar(histD);

H = histeq(D);
histH =Img_Hist(H);
figure
subplot(2,1,1);
imshow(H);
title('histogram equalization on D');
subplot(2,1,2);
bar(histH);

local = image(70:512, 42:450);
L = image;
localhisteq = histeq(local);
L(70:512, 42:450) = localhisteq;
histL =Img_Hist(L);
figure
subplot(2,1,1);
imshow(L);
title('local histogram equalization on D');
subplot(2,1,2);
bar(histL);


logImg = log_transform(image,35);
histLog =Img_Hist(logImg);
figure
subplot(2,1,1);
imshow(logImg);
title('log transform');
subplot(2,1,2);
bar(histLog);

powerImg = power_transform(image,15,0.5);
histPower =Img_Hist(powerImg);
figure
subplot(2,1,1);
imshow(powerImg);
title('power-law transform');
subplot(2,1,2);
bar(histPower);


function Hist = Img_Hist(img)
    [R,C]=size(img);
    Hist=zeros(256,1);
    for r = 1:R
        for c=1:C
            Hist(img(r,c)+1,1)=Hist(img(r,c)+1,1)+1;
        end
    end
  
end

function out = devide_func(image, n)
    [M,N] = size(image);
    out=zeros(M,N,'uint8');
    for i=1:M
        for j=1:N
            m=double(image(i,j));
            m=nearest_floor(m,n);
            out(i,j)=m;
        end
    end
   
end

function out = log_transform(image,c)
    [M,N] = size(image);
    out=zeros(M,N,'uint8');
    for i=1:M
        for j=1:N
            r=double(image(i,j));
            out(i,j)=c*log(1 + (r)); % Log Transform
        end
    end
  
end

function out = power_transform(image,c,omega)
    [M,N] = size(image);
    out=zeros(M,N,'uint8');
    for i=1:M
        for j=1:N
            r=double(image(i,j));
            out(i,j)=c*(r^omega); % Log Transform
        end
    end
  
end

function out = nearest_floor(m,n)
    for r = 1:n
       if(mod(m,n)==0)
        out=m;
        break
       end
       m=m-1;
    end
  
end

