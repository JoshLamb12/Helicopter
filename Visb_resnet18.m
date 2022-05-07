clc;clear;close all
%alex net,resnet,darknet importer,google net,cnn,tensorflow and keras models
%deepNetworkDesigner
% digitDatasetPath = fullfile('E:\FAA work\data\new data 06-21-2021\New Code\confMatrix\testimages risized');

imds = imageDatastore('C:\Users\joshl\Documents\GitHub\USB Backup\Training Images\Balanced', ...
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames');


[imdsTrain,imdsValidation, imdsTest] = splitEachLabel(imds,0.75,0.2,'randomized'); %make test folder
%imdsTest = imageDatastore('C:\Users\joshl\Documents\GitHub\Helicopter-Local\Test', ...
 %   'IncludeSubfolders',true, ...
  %  'LabelSource','foldernames');
% [imdsTrain,imdsValidation] = splitEachLabel(imds,0.7,'randomized');
net = resnet18;
%analyzeNetwork(net)
numClasses = numel(categories(imdsTrain.Labels));

lgraph = layerGraph(net);
newFCLayer = fullyConnectedLayer(numClasses,'Name','new_fc','WeightLearnRateFactor',10,'BiasLearnRateFactor',10);
lgraph = replaceLayer(lgraph,'fc1000',newFCLayer);
newClassLayer = classificationLayer('Name','new_classoutput');
lgraph = replaceLayer(lgraph,'ClassificationLayer_predictions',newClassLayer);
%inputSize = net.Layers(1).InputSize;
% inputSize= [224 224];
% augimdsTrain = augmentedImageDatastore(inputSize,imdsTrain);
% augimdsValidation = augmentedImageDatastore(inputSize,imdsValidation);
options = trainingOptions('sgdm', ...
    'MiniBatchSize',128, ... %Kyle 32 Damian 128
    'MaxEpochs',50, ...
    'InitialLearnRate',1e-4, ...
    'Shuffle','every-epoch', ...
    'ValidationData',imdsValidation, ...
    'ValidationFrequency',5, ...
    'Verbose',true, ...
    'Plots','training-progress', ...
    'ExecutionEnvironment','gpu');
trainedNet = trainNetwork(imdsTrain,lgraph,options);

[YPred,probs] = classify(trainedNet,imdsValidation);
YValidation = imdsValidation.Labels;
accuracy = sum(YPred == YValidation)/numel(YValidation)%0.9867
figure;plotconfusion(YValidation,YPred);title('Resnt18-Confusion Matrix')
set(gcf,'PaperPositionMode','auto')
print('Resnt18-Confusion Matrix_64E25TEST','-dpng','-r300')
%accuracy = mean(YPred == imdsValidation.Labels)
%%save Network
save sep02_64E25_Sep102021Resnet18Test.mat trainedNet lgraph %rename after each run
%% Try to classify something else
figure
img = readimage(imds,5000);
actualLabel = imds.Labels(5000);
predictedLabel = trainedNet.classify(img);
imshow(img);
title(['Predicted: ' char(predictedLabel) ', Actual: ' char(actualLabel)])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

idx = randperm(numel(imdsValidation.Files),16);

figure;sgtitle('RESNET18 Validation dataset ')%add full size option
for i = 1:16
    subplot(4,4,i)
    I = readimage(imdsValidation,idx(i));
    imshow(I)
    label = YPred(idx(i));
%     title(string(label));
%     
   actualLabel = imdsValidation.Labels(idx(i));
    predictedLabel = trainedNet.classify(I);
%     imshow(img);
title(['Predicted: ' char(predictedLabel) ', Actual: ' char(actualLabel)]) 
end

set(gcf,'PaperPositionMode','auto')
print('Testing RESNET18 Validation dataset-2 _dpi300TEST','-dpng','-r300')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
figure;plotconfusion(YValidation,YPred);title('Resnet18-Confusion MatrixconfMat')


% netTransfer.Layers(end).Classes(1:3)
figure
cm = confusionchart(YValidation,YPred)
cm.RowSummary = 'row-normalized';
cm.ColumnSummary = 'column-normalized';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure;
cm = confusionchart(YValidation,YPred,'Normalization','row-normalized');title('ResNet18-Confusion Matrix')
set(gcf,'PaperPositionMode','auto')
print('ResNe18t-Confusion Matrix_Validition2_dpi300','-dpng','-r300')
% fig = figure;
fig_Position = fig.Position;
fig_Position(3) = fig_Position(3)*1.5;
fig.Position = fig_Position;

%%%%%%%%%%%%%%%%%%%%%%%%%%testdata
XTest = imdsTest.Labels;
[XPred,Xscores] = classify(trainedNet,imdsTest);
idx = randperm(numel(imdsTest.Files),16); %formally 16
figure;sgtitle('RESNET18 Testing Dataset ')
for i = 1:16 %foramlly 16
    subplot(4,4,i)
    I = readimage(imdsTest,idx(i));
    imshow(I)
    label = XPred(idx(i));
    actualLabel = imdsTest.Labels(idx(i));
    predictedLabel = trainedNet.classify(I);
   title(['Predicted: ' char(predictedLabel) ', Actual: ' char(actualLabel)]) 
end
set(gcf,'PaperPositionMode','auto')
print('Testing RESNET18 Testing Dataset-2 (testting dataset _dpi300','-dpng','-r300')

accuracy = mean(XPred == XTest)
figure;plotconfusion(XTest,XPred);title('Resnet18-Confusion Matrix -Test Dataset')
set(gcf,'PaperPositionMode','auto')
print('Resnet18-Confusion Matrix -Test Dataset(testting dataset _dpi300','-dpng','-r300')
figure
cm = confusionchart(XTest,XPred)
cm.RowSummary = 'row-normalized';
cm.ColumnSummary = 'column-normalized';
fig = figure;
% cm = confusionchart(XTest,XPred,'RowSummary','row-normalized','ColumnSummary','column-normalized');
cm = confusionchart(XTest,XPred,'Normalization','row-normalized');title('ResNet18 Confusion Matrix-Testing data')
set(gcf,'PaperPositionMode','auto')
print('ResNet18-Confusion Matrix -Testing data Matrix2_dpi300','-dpng','-r300')

fig_Position = fig.Position;
fig_Position(3) = fig_Position(3)*1.5;
fig.Position = fig_Position;
analyzeNetwork(trainedNet)
