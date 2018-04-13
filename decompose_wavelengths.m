OriginalImage=imread('starry-night.jpg');
 
Red=OriginalImage(:,:,1);
Green=OriginalImage(:,:,2);
Blue=OriginalImage(:,:,3);
 
vector470=[0,169, 255];
vector530=[94,255,0];
vector650=[255,0,0];
ConvertMatrix=[vector650' vector530' vector470'];
 
for pixelcoordinate1=1:size(OriginalImage,1)
    for pixelcoordinate2=1:size(OriginalImage,2)
        DesiredVector(1:3)=double(OriginalImage(pixelcoordinate1,pixelcoordinate2, :));
         
        temp=((double(ConvertMatrix))\double(DesiredVector)')';
        Scale470(pixelcoordinate1,pixelcoordinate2)=temp(3);
        Scale530(pixelcoordinate1,pixelcoordinate2)=temp(2);
        Scale650(pixelcoordinate1,pixelcoordinate2)=temp(1);
    end
end
 
 
MakeZeroImage1(:,:,3)=Scale470;
MakeZeroImage1(:,:,2)=Scale530;
MakeZeroImage1(:,:,1)=Scale650;
 
for i=1:size(OriginalImage,1)*size(OriginalImage,2)*size(OriginalImage,3)
    if MakeZeroImage1(i)<0
        MakeZeroImage1(i)=0;
    end
end
 
MakeZeroImage(:,:,1)=vector650(1)*MakeZeroImage1(:,:,1)+vector530(1)*MakeZeroImage1(:,:,2)+vector470(1)*MakeZeroImage1(:,:,3);
MakeZeroImage(:,:,2)=vector650(2)*MakeZeroImage1(:,:,1)+vector530(2)*MakeZeroImage1(:,:,2)+vector470(2)*MakeZeroImage1(:,:,3);
MakeZeroImage(:,:,3)=vector650(3)*MakeZeroImage1(:,:,1)+vector530(3)*MakeZeroImage1(:,:,2)+vector470(3)*MakeZeroImage1(:,:,3);
 
 
figure
image(OriginalImage)
figure
image(uint8(MakeZeroImage))
 
ScaleImage1(:,:,3)=Scale470;
ScaleImage1(:,:,2)=Scale530;
ScaleImage1(:,:,1)=Scale650;
 
ScaleImage1=(ScaleImage1+min(min(min(ScaleImage1))))*255/(1-min(min(min(ScaleImage1))));
 
ScaleImage(:,:,1)=vector650(1)*ScaleImage1(:,:,1)+vector530(1)*ScaleImage1(:,:,2)+vector470(1)*ScaleImage1(:,:,3);
ScaleImage(:,:,2)=vector650(2)*ScaleImage1(:,:,1)+vector530(2)*ScaleImage1(:,:,2)+vector470(2)*ScaleImage1(:,:,3);
ScaleImage(:,:,3)=vector650(3)*ScaleImage1(:,:,1)+vector530(3)*ScaleImage1(:,:,2)+vector470(3)*ScaleImage1(:,:,3);
 
figure
image(uint8(ScaleImage))
