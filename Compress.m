function result=Compress(image,Order)


fz=VideoCompressionFast2(image,Order);
fz=permute(fz,[2 1 3]);
fz=VideoCompressionFast2(fz,Order);
result=permute(fz,[2 1 3]);


end