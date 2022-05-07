chosenClass = "IFR";
classIdx = find(trainedNet.Layers(end).Classes == chosenClass);
numImgsToShow =3;
[sortedScores,imgIdx] = findMaxActivatingImages(imdsTest,chosenClass,Xscores,numImgsToShow);
% figure

%% Visualize Cues for the Sushi Class  needs augmented dataset
for i=1:(numImgsToShow)
% imageNumber =imgIdx(i);

% observation = imdsTest(imgIdx(imageNumber));
img = readimage(imdsTest,imgIdx(i));

label = XPred(imgIdx(i));
score = Xscores(imgIdx(i),1);
% [gradcamMap,featureLayer,reductionLayer]= gradCAM(netTransfer,img,predClass);

gradcamMap = gradCAM(trainedNet,img,label);

figure
alpha = 0.5;
plotGradCAM(img,gradcamMap,alpha);
% sgtitle(string(label)+" (score: "+ max(score)+")")
score = sortedScores(i);
    sortedImgIdx = imgIdx(i);
    predClass = XPred(sortedImgIdx); 
    correctClass = imdsTest.Labels(sortedImgIdx);
        
    imgPath = imdsTest.Files{sortedImgIdx};
    
    if predClass == correctClass
        color = "\color{green}";
    else
        color = "\color{red}";
    end
    
    predClassTitle = strrep(string(predClass),'_',' ');
    correctClassTitle = strrep(string(correctClass),'_',' ');
    
   subplot(1,2,1)
    imshow(imread(imgPath));
    title("Predicted: " + color + predClassTitle + "\newline\color{black}Score: " + num2str(score) + "\newlineGround truth: " + correctClassTitle);
set(gcf,'PaperPositionMode','auto')
    print(strcat('IFR-GradCamMax_',num2str(i)),'-dpng','-r600')
end


chosenClass = "IFR";
classIdx = find(trainedNet.Layers(end).Classes == chosenClass);
numImgsToShow =3;
[sortedScores,imgIdx] = findMinActivatingImages(imdsTest,chosenClass,Xscores,numImgsToShow);
% figure
for i=1:(numImgsToShow)
% imageNumber =imgIdx(i);

% observation = imdsTest(imgIdx(imageNumber));
img = readimage(imdsTest,imgIdx(i));

label = XPred(imgIdx(i));
score = Xscores(imgIdx(i),1);
% [gradcamMap,featureLayer,reductionLayer]= gradCAM(netTransfer,img,predClass);

gradcamMap = gradCAM(trainedNet,img,label);

figure
alpha = 0.5;
plotGradCAM(img,gradcamMap,alpha);
% sgtitle(string(label)+" (score: "+ max(score)+")")
score = sortedScores(i);
    sortedImgIdx = imgIdx(i);
    predClass = XPred(sortedImgIdx); 
    correctClass = imdsTest.Labels(sortedImgIdx);
        
    imgPath = imdsTest.Files{sortedImgIdx};
    
    if predClass == correctClass
        color = "\color{green}";
    else
        color = "\color{red}";
    end
    
    predClassTitle = strrep(string(predClass),'_',' ');
    correctClassTitle = strrep(string(correctClass),'_',' ');
    
   subplot(1,2,1)
    imshow(imread(imgPath));
    title("Predicted: " + color + predClassTitle + "\newline\color{black}Score: " + num2str(score) + "\newlineGround truth: " + correctClassTitle);
    set(gcf,'PaperPositionMode','auto')
    print(strcat('IFR-GradCamMin_',num2str(i)),'-dpng','-r600')
end


function plotGradCAM(img,gradcamMap,alpha)

subplot(1,2,1)
imshow(img);

h = subplot(1,2,2);
imshow(img)
hold on;
imagesc(gradcamMap,'AlphaData',alpha);

originalSize2 = get(h,'Position');

colormap jet
colorbar

set(h,'Position',originalSize2);
hold off;
end
function [sortedScores,imgIdx] = findMaxActivatingImages(imds,className,predictedScores,numImgsToShow)
% Find the predicted scores of the chosen class on all the images of the chosen class
% (e.g. predicted scores for sushi on all the images of sushi)
[scoresForChosenClass,imgsOfClassIdxs] = findScoresForChosenClass(imds,className,predictedScores);

% Sort the scores in descending order
[sortedScores,idx] = sort(scoresForChosenClass,'descend');

% Return the indices of only the first few
imgIdx = imgsOfClassIdxs(idx(1:numImgsToShow));

end



function [sortedScores,imgIdx] = findMinActivatingImages(imds,className,predictedScores,numImgsToShow)
% Find the predicted scores of the chosen class on all the images of the chosen class
% (e.g. predicted scores for sushi on all the images of sushi)
[scoresForChosenClass,imgsOfClassIdxs] = findScoresForChosenClass(imds,className,predictedScores);

% Sort the scores in ascending order
[sortedScores,idx] = sort(scoresForChosenClass,'ascend');

% Return the indices of only the first few
imgIdx = imgsOfClassIdxs(idx(1:numImgsToShow));

end

function [scoresForChosenClass,imgsOfClassIdxs] = findScoresForChosenClass(imds,className,predictedScores)
% Find the index of className (e.g. "sushi" is the 9th class)
uniqueClasses = unique(imds.Labels);
chosenClassIdx = string(uniqueClasses) == className;

% Find the indices in imageDatastore that are images of label "className"
% (e.g. find all images of class sushi)
imgsOfClassIdxs = find(imds.Labels == className);

% Find the predicted scores of the chosen class on all the images of the
% chosen class
% (e.g. predicted scores for sushi on all the images of sushi)
scoresForChosenClass = predictedScores(imgsOfClassIdxs,chosenClassIdx);
end

function plotImages(imds,imgIdx,sortedScores,predictedClasses,numImgsToShow)

for i=1:numImgsToShow
    score = sortedScores(i);
    sortedImgIdx = imgIdx(i);
    predClass = predictedClasses(sortedImgIdx); 
    correctClass = imds.Labels(sortedImgIdx);
        
    imgPath = imds.Files{sortedImgIdx};
    
    if predClass == correctClass
        color = "\color{green}";
    else
        color = "\color{red}";
    end
    
    predClassTitle = strrep(string(predClass),'_',' ');
    correctClassTitle = strrep(string(correctClass),'_',' ');
    
    subplot(3,ceil(numImgsToShow./3),i)
    imshow(imread(imgPath));
    title("Predicted: " + color + predClassTitle + "\newline\color{black}Score: " + num2str(score) + "\newlineGround truth: " + correctClassTitle);
end

end
