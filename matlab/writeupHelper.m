clear;
resultsdir  = '../results'; %the directory for dumping results
[filterBank] = createFilterBank();
image = imread('../data/desert/sun_adpbjcrpyetqykvt.jpg');
image=double(image) / 255;
H=size(image,1);
W=size(image,2);
 
[filterResponses] = extractFilterResponses(image, filterBank);

for i=1:size(filterResponses,3)
     result=reshape(filterResponses(:,:,i),H,W);   
%      size(result)
     m = max(max(result));
     result = result / m;
     result = uint8(result * 255);
     figure;
     imshow(result)
end