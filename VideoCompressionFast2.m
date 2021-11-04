function y=VideoCompressionFast2(Image,Order)
SizeOfImage=size(Image);

x=1:1:SizeOfImage(2);
T=SizeOfImage(2)-1;


RepeatedImageRed=single(Image(:,:,1));
RepeatedImageGreen=single(Image(:,:,2));
RepeatedImageBlue=single(Image(:,:,3));

Cos=single(cos((2*pi/T)*(x'*[1:Order])));
Sin=single(sin((2*pi/T)*(x'*[1:Order])));
CosSin=single(ones(SizeOfImage(2),2*Order+1));



CosSin(:,2:2:end)=Cos;
CosSin(:,3:2:end)=Sin;


RepeatedImageRed=RepeatedImageRed*CosSin;
RepeatedImageGreen=RepeatedImageGreen*CosSin;
RepeatedImageBlue=RepeatedImageBlue*CosSin;

Carry2Red=(2/T)*RepeatedImageRed(:,2:end);
Carry1Red=(1/T)*RepeatedImageRed(:,1);
RepeatedImageRed=[Carry1Red Carry2Red];
Carry2Green=(2/T)*RepeatedImageGreen(:,2:end);
Carry1Green=(1/T)*RepeatedImageGreen(:,1);
RepeatedImageGreen=[Carry1Green Carry2Green];
Carry2Blue=(2/T)*RepeatedImageBlue(:,2:end);
Carry1Blue=(1/T)*RepeatedImageBlue(:,1);
RepeatedImageBlue=[Carry1Blue Carry2Blue];


CompressedImage=zeros(SizeOfImage(1),2*Order+1,3);
CompressedImage(:,:,1)=RepeatedImageRed;
CompressedImage(:,:,2)=RepeatedImageGreen;
CompressedImage(:,:,3)=RepeatedImageBlue;

y=single(CompressedImage);

end