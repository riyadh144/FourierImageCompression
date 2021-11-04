function y=viewImageDoubleFast(CompressedImage,SizeOfImage,Order,DOrder,NumberOfLines)
CompressedImageRed=CompressedImage(:,:,1);
CompressedImageGreen=CompressedImage(:,:,2);
CompressedImageBlue=CompressedImage(:,:,3);
x1=[1:SizeOfImage(1)/NumberOfLines]';
x=[1:SizeOfImage(2)*NumberOfLines];
% finRed=zeros(SizeOfImage(1),SizeOfImage(2));
% finGreen=zeros(SizeOfImage(1),SizeOfImage(2));
% finBlue=zeros(SizeOfImage(1),SizeOfImage(2));
% intRed=zeros(SizeOfImage(1)/NumberOfLines,2*Order+1);
% intGreen=zeros(SizeOfImage(1)/NumberOfLines,2*Order+1);
% intBlue=zeros(SizeOfImage(1)/NumberOfLines,2*Order+1);
% secondRed=zeros(SizeOfImage(1)/NumberOfLines,SizeOfImage(2)*NumberOfLines);
% secondGreen=zeros(SizeOfImage(1)/NumberOfLines,SizeOfImage(2)*NumberOfLines);
% secondBlue=zeros(SizeOfImage(1)/NumberOfLines,SizeOfImage(2)*NumberOfLines);
ImageBack=zeros(SizeOfImage(1),SizeOfImage(2),3);

% for i=1:2*Order+1
%     intRed(:,i)=CompressedImageRed(1,i);
%     intGreen(:,i)=CompressedImageGreen(1,i);
%     intBlue(:,i)=CompressedImageBlue(1,i);
%     for ii=2:2:2*DOrder+1
%     intRed(:,i)=intRed(:,i)+CompressedImageRed(ii,i)*cos(x1*2*pi*(ii/2)/(SizeOfImage(1)*NumberOfLines-1))+CompressedImageRed(ii+1,i)*sin((x1*ii/2)*2*pi/(SizeOfImage(1)*NumberOfLines-1));
%     intGreen(:,i)=intGreen(:,i)+CompressedImageGreen(ii,i)*cos(x1*2*pi*(ii/2)/(SizeOfImage(1)*NumberOfLines-1))+CompressedImageGreen(ii+1,i)*sin((x1*ii/2)*2*pi/(SizeOfImage(1)*NumberOfLines-1));
%     intBlue(:,i)=intBlue(:,i)+CompressedImageBlue(ii,i)*cos(x1*2*pi*(ii/2)/(SizeOfImage(1)*NumberOfLines-1))+CompressedImageBlue(ii+1,i)*sin((x1*ii/2)*2*pi/(SizeOfImage(1)*NumberOfLines-1));
%     end
% end

ii=[1:DOrder];

CosMat=cos(x1*ii*2*pi/(SizeOfImage(1)*NumberOfLines-1));
SinMat=sin(x1*ii*2*pi/(SizeOfImage(1)*NumberOfLines-1));
CosSinMat=ones(2*DOrder,SizeOfImage(1)*NumberOfLines);

CosSinMat(2:2:end,:)=SinMat';
CosSinMat(1:2:end,:)=CosMat';
CosSinMat=[ones(1,SizeOfImage(1)*NumberOfLines);CosSinMat]';
intRed=(CompressedImageRed'*CosSinMat')';
intGreen=(CompressedImageGreen'*CosSinMat')';
intBlue=(CompressedImageBlue'*CosSinMat')';


% for i=1:(SizeOfImage(1)/NumberOfLines)
%     secondRed(i,:)=intRed(i,1);
%     secondGreen(i,:)=intGreen(i,1);
%     secondBlue(i,:)=intBlue(i,1);
%     for ii=2:2:2*Order+1
%     secondRed(i,:)=secondRed(i,:)+intRed(i,ii)*cos(x*2*pi*(ii/2)/(SizeOfImage(2)*NumberOfLines-1))+intRed(i,ii+1)*sin((x*ii/2)*2*pi/(SizeOfImage(2)*NumberOfLines-1));
%     secondGreen(i,:)=secondGreen(i,:)+intGreen(i,ii)*cos(x*2*pi*(ii/2)/(SizeOfImage(2)*NumberOfLines-1))+intGreen(i,ii+1)*sin((x*ii/2)*2*pi/(SizeOfImage(2)*NumberOfLines-1));
%     secondBlue(i,:)=secondBlue(i,:)+intBlue(i,ii)*cos(x*2*pi*(ii/2)/(SizeOfImage(2)*NumberOfLines-1))+intBlue(i,ii+1)*sin((x*ii/2)*2*pi/(SizeOfImage(2)*NumberOfLines-1));
%     end
% end

ii=[1:Order];

CosMat=cos(ii'*x*2*pi/(SizeOfImage(2)*NumberOfLines-1));
SinMat=sin(ii'*x*2*pi/(SizeOfImage(2)*NumberOfLines-1));
CosSinMat=ones(2*Order,SizeOfImage(2)*NumberOfLines);

CosSinMat(2:2:end,:)=SinMat;
CosSinMat(1:2:end,:)=CosMat;
CosSinMat=[ones(1,SizeOfImage(2)/NumberOfLines);CosSinMat];
secondRed=intRed*CosSinMat;
secondGreen=intGreen*CosSinMat;
secondBlue=intBlue*CosSinMat;

finRed=reshape(secondRed',SizeOfImage(2),SizeOfImage(1))';
finGreen=reshape(secondGreen',SizeOfImage(2),SizeOfImage(1))';
finBlue=reshape(secondBlue',SizeOfImage(2),SizeOfImage(1))';
if NumberOfLines>1
    finRed(2:2:end,:) = fliplr(finRed(2:2:end,:));
    finGreen(2:2:end,:) = fliplr(finGreen(2:2:end,:));
    finBlue(2:2:end,:) = fliplr(finBlue(2:2:end,:));
end
    ImageBack(:,:,1)=round(finRed);
    ImageBack(:,:,2)=round(finGreen);
    ImageBack(:,:,3)=round(finBlue);
    %ImageBack(ImageBack<=0)=1;
    ImageBack=uint8(ImageBack);
    imshow(ImageBack)
    imwrite(ImageBack,'D4kSingle.jpeg')
    y=ImageBack;
end

