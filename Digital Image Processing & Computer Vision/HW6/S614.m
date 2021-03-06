img = imread('Images/6/Lena.bmp');
img = rgb2gray(img);


level = 4;
output = wt(img,level,0);

x = iwt(output,level);
x = norm (x);
x = uint8(x);
imshow(output);
figure
imshow(x);
p = psnr(x,img);
p
m = immse(x,img);
m

function output= quantizer (img,gamma)
    [M,N] = size(img);
    output = zeros(M,N,'double');
     
    for i=1:M
        for j=1:N
            output(i,j) = gamma* sign(img(i,j))*floor( abs(img(i,j))/gamma);
        end
    end
end
function output = iwt(wt_pyramid,level)
    if(level==0)
        output = wt_pyramid;
        return
    end
    output = wt_pyramid;
    [R,C] = size(output);
    dec_part = output(1:R/(2^(level-1)),1:C/(2^(level-1)));
    
    
    [r,c] = size(dec_part);
    cA = dec_part(1:r/2,1:c/2);
    cV = dec_part(r/2+1:r,1:c/2);
    cH = dec_part(1:r/2,c/2+1:c);
    cD = dec_part(r/2+1:r,c/2+1:c);
    
     output(1:R/(2^(level-1)),1:C/(2^(level-1))) = idwt2(cA,cH,cV,cD,'haar');
    
    output = iwt(output,level-1);
    
end

function output = wt(img,level,present)

    if(level==0)
        output = img;
        return
    end
    [R,C] = size(img);
    output= zeros(R,C,'double');

    %[LoD,HiD] = wfilters('haar','d');
    [cA,cH,cV,cD] = dwt2(img,'haar');
    
    cA = quantizer(cA,2);
    cV = quantizer(cV,2);
    cH = quantizer(cH,2);
    cD = quantizer(cD,2);
    
    if(present)
        cA = norm(cA);
        cV = norm(cV);
        cH = norm(cH);
        cD = norm(cD);
    end
    output(1:R/2,1:C/2) = wt(cA,level-1,present);
    output(R/2+1:R,1:C/2)=cV;
    output(1:R/2,C/2+1:C)=cH;
    output(R/2+1:R,C/2+1:C)=cD;

    if (present)
        output = uint8(output);
    end

end
function output = norm(img)
    output = mat2gray(img);
    Max = max(max(output));
    Min = min(min(output));
    output = (255/(Max-Min))*output;
    
end