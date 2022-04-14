clc; clear;

fileList = dir('D:\Helicopter Clinic\Training Images\VFR');  %folder where images are saved(specifically each category)
fileList(1,:) = []; %deletes first two in directory(i had two random lines)
fileList(1,:) = [];
numFiles = length(fileList)
orderToUse = randperm(numFiles);
for k = 1 : numFiles
	% Get what random index this one is.
	index = orderToUse(k);
	% Construct the full filename.
	fullFileName = fullfile(fileList(index).folder, fileList(index).name);
	fprintf('Processing #%d of %d:\n  which is file #%d in the list : %s\n',...
		k, numFiles, index, fullFileName);
	destdirectory = ("D:\Helicopter Clinic\New\NewVFR\VFR"+k+".jpg"); %folder where new images are saved
    destdirectory2 = ("D:\Helicopter Clinic\Test\TestVFR\VFR"+k+".jpg"); %folder where test images are saved
%fulldestination = fullfile(destdirectory, fullFileName);
%imsave(fullFileName);
g = imread(fullFileName);
if k < 4000 %number is how many are saved in new folder, others are put in test
imwrite(g,destdirectory) 
else
    imwrite(g,destdirectory2) 
end
end
