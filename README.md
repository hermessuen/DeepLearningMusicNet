# DeepLearningMusicNet
To use this code, first run the "Downloads" file MATLAB code. Specify the number of examples you want to download, as well as make sure the correct download location is set in the browser. Note that you will need to run this file at least twice, once for each genre of music

Next run CreateMusicNeuralNet to generate a neural net named "musicNet". Note that the code is structured so that you have to edit the number of samples to use for validation, testing, and training within this script. You customize these numbers by modifying the parameters to the function calls to "prepareTrainingData". 

Test the accuracy of the neural net using the testNerualNet script. If the neural net is not performing up to standards, considering trainign again or using more data. 
