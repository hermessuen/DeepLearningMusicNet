%% Generates and runs tests for the neural net
clc;
 
%create validation data for data 10-20 in each folder
if exist('testData.mat')
    load('testData.mat');
else
    [testData, testLabels] = prepareTrainingData(906,940, 'testData',0,1);
end

numTests = length(testLabels);

%before testing, convert the complex double into a regular double
testData = real(testData) + imag(testData);

%this gets a categorical array of the predictions for the test Data
predictions = classify(musicNet, testData);

%display the accuracy
testLabels = categorical(testLabels);
numCorrect = nnz(predictions == testLabels);
accuracy = numCorrect/numel(testLabels);

