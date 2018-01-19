function vectorImage = imageTo20x20Gray(fileName, cropPercentage=0, rotStep=0,Theta1,Theta2)
% Read as RGB image
Image3DmatrixRGB = imread(fileName);
% Convert to NTSC image (YIQ)
Image3DmatrixYIQ = rgb2ntsc(Image3DmatrixRGB );
% Convert to grays keeping only luminance (Y)
%        ...and discard chrominance (IQ)
Image2DmatrixBW  = Image3DmatrixYIQ(:,:,1);

% Get the size of your image
oldSize = size(Image2DmatrixBW);
% Obtain crop size toward centered square (cropDelta)
% ...will be zero for the already minimum dimension
% ...and if the cropPercentage is zero, 
% ...both dimensions are zero
% ...meaning that the original image will go intact to croppedImage
cropDelta = floor((oldSize - min(oldSize)) .* (cropPercentage/100));

% Compute the desired final pixel size for the original image
finalSize = oldSize - cropDelta;
% Compute each dimension origin for croping
cropOrigin = floor(cropDelta / 2) + 1;
% Compute each dimension copying size
copySize = cropOrigin + finalSize - 1;
% Copy just the desired cropped image from the original B&W image
croppedImage = Image2DmatrixBW( ...
                    cropOrigin(1):copySize(1), cropOrigin(2):copySize(2));

% Resolution scale factors: [rows cols]
scale = [20 20] ./ finalSize;
% Compute back the new image size (extra step to keep code general)
newSize = max(floor(scale .* finalSize),1); 

% Compute a re-sampled set of indices:
rowIndex = min(round(((1:newSize(1))-0.5)./scale(1)+0.5), finalSize(1));
colIndex = min(round(((1:newSize(2))-0.5)./scale(2)+0.5), finalSize(2));

% Copy just the indexed values from old image to get new image
newImage = croppedImage(rowIndex,colIndex,:);

% Rotate if needed: -1 is CCW, 0 is no rotate, 1 is CW
newAlignedImage = rot90(newImage, rotStep);

% Invert black and white
invertedImage = - newAlignedImage;

% Find min and max grays values in the image
maxValue = max(invertedImage(:));
minValue = min(invertedImage(:));
% Compute the value range of actual grays
delta = maxValue - minValue;

% Normalize grays between 0 and 1
normImage = (invertedImage - minValue) / delta;

% Add contrast. Multiplication factor is contrast control.
contrastedImage = sigmoid((normImage -0.5) * 15);

% Show image as seen by the classifier
[i,s] = predict2(Theta1,Theta2,reshape(normImage, 1, newSize(1) * newSize(2)));
figure('Name',num2str (i));

set(findobj(gcf,'type','axes'),'Visible','off');
subplot(12,10,[1:20]),axis off;
text(0.5,0.5,"Digit Recognition using neural network",'FontSize',25,'HorizontalAlignment','center');
subplot(12,10,[ 21:25 31:35 41:45 51:55 61:65 71:75 81:85 91:95]),axis off;

imshow(contrastedImage, [-1, 1] );
axis off;
pause(0.5);
subplot(12,10,[101:105 111:115]);
a=num2str(i);
tec = strcat("Prediction :  ",a);
text(0.5,0.5,tec,'FontSize',20,'HorizontalAlignment','center');
axis off;
subplot(12,10,[106:110 116:120]),axis off;
a=num2str(s);
tec = strcat("Accuracy :  ",a);
text(0.5,0.5,tec,'FontSize',20,'HorizontalAlignment','center');
axis off;
% Output the matrix as a unrolled vector
vectorImage = reshape(normImage, 1, newSize(1) * newSize(2));

end;