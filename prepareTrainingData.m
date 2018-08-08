%% This function is able to output x and y data that can be used to
%  train neural net. It takes the start and end data points of the folder 
% in question(which data points do we want)

%Inputs:
%   start: the index in the folder of datapoints to start
%   last: the index in the folder of datapoints to stop
%   nameOfMatFile: the title of the Mat file we want to store the results
%   validation: 0 or 1 depending on whether the data will be used for
%                  validation
%   test: 0 or 1 depending on if it will be used for testing

%Outputs:
%   inputData: the music files
%   labels:    the correct labels for those music files(rap or classical)

function [inputData, labels] = prepareTrainingData(start, last, nameOfMatFile, validation,test)

%% specify parameters
pathToClassical = 'D:\NeuralNets\MusicData\ClassicalMusic';
pathToRap = 'D:\NeuralNets\MusicData\RapMusic';
numSamples = 200000;
numRows = 227;
numCols = 227;


%% Get the category names of what we are trying to classify
[~,label1] = fileparts(pathToClassical);
[~,label2] = fileparts(pathToRap);

%% get data
classicalData = generateData(pathToClassical,numSamples,start,last);
rapData = generateData(pathToRap, numSamples,start,last);

%% findind the total number of samples we are dealing with 
numClassicalSamples = length(classicalData);
numRapSamples = length(rapData);

totalTrainingSamples = numClassicalSamples + numRapSamples;

labels = strings(totalTrainingSamples, 1);


%% Formatting the data sets to input into the neural network to train
for i =1:numClassicalSamples
    labels(i) = label1;
end

for i = numClassicalSamples + 1: totalTrainingSamples
    labels(i) = label2;
end

% this makes it into an image that can be inputted into alexnet
classicalData = formatFile(classicalData, numRows, numCols); 
rapData = formatFile(rapData,numRows,numCols);

%inputData = [classicalData;rapData];
inputData = cat(4, classicalData, rapData);

%% different saving structure if we are savin validation 
if validation
    valData = inputData;
    valLabels = labels;
    save(nameOfMatFile, 'valData','valLabels');
    
elseif test
    testData = inputData;
    testLabels = labels;
    save(nameOfMatFile, 'testData', 'testLabels');
else
     save(nameOfMatFile, 'inputData','labels', '-v7.3');
%% to get a certain number of seconds multiply
%  the seconds by the sampling rate Fs usually 44100

end



end

