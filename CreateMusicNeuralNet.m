%% Creates, trains, and uses a neural network to detect
% whether or not the mp3 file is piece of classical music or not

clc;clear

 if exist('trainingData.mat')
      load('trainingData.mat');
 else
     % creates training data for data 50-74 in each folder
     [inputData, labels] = prepareTrainingData(91,900, 'trainingData',0,0);
 end
 
%create validation data for data 10-20 in each folder
if exist('validationData.mat')
    load('validationData.mat');
    validationData = {valData,valLabels};
else
    [valData,valLabels] = prepareTrainingData(1,90, 'validationData',1,0);
     validationData = {valData valLabels};
end


%% Building the network for transfer learning proccesses
net = alexnet;
layers = net.Layers;

% only need to use the layers from alexnet to do the actual training
% just change these layers but keep everything else the same
layers(23) = fullyConnectedLayer(2);
layers(25) = classificationLayer;



%% Training the network
%before training, convert the complex double into a regular double
valData = real(valData) + imag(valData);
inputData = real(inputData) + imag(inputData);


%Convert the output data into categoricals
valLabels = categorical(valLabels);
labels = categorical(labels);

validationData = {valData valLabels};

%Set the options for training
options = trainingOptions('sgdm', 'MaxEpochs', 10, 'InitialLearnRate', 0.01 ...
    ,'Plots', 'training-progress', 'ValidationData', validationData, ...
    'ValidationFrequency', 10, 'ValidationPatience', 30 ...
    ,'ExecutionEnvironment', 'auto', 'MiniBatchSize', 20, ...
    'Momentum', 0.7);

musicNet = trainNetwork(inputData,labels,layers,options);


