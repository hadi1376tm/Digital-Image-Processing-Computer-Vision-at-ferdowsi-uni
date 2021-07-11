



function Hist = Img_Hist(img)
    [R,C]=size(img);
    Hist=zeros(256,1);
    for r = 1:R
        for c=1:C
            Hist(img(r,c)+1,1)=Hist(img(r,c)+1,1)+1;
        end
    end
  
end


