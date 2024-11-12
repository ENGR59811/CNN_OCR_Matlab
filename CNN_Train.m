function net = CNN_Train(train_dir)
%
% Train a new CNN using information from TrainingSet directory
% Then return trained CNN

    %%%%%%%%%%% TRAIN THE CNN %%%%%%%%%%%
    
    % load the training image dataset into an imageDatastore
    % train_path contains the path to the dataset
    imds_train = imageDatastore(train_dir, ...
                               'IncludeSubfolders',true,...
                               'LabelSource','foldernames');
    % get the number of unique training labels in the training data
    noof_labels = height(countEachLabel(imds_train));
                           
    layers = [
        % set the size of the input image as 28x28 pixels with 1 color 
        % channel (grayscale)
        imageInputLayer([28 28 1])

        % create the first convolution layer, it has 8 convolutional
        % filters, each with a height and width of 3 and input is 0 padded.
        % the input is padded with the appropriate number of zeros so that
        % the size of the output is the same size as the input.
        convolution2dLayer(3,8,'Padding','same')
        % normalize the output of the convolution between the range -1 
        % and 1. this prevents the updated weights from increasing 
        % explosively during training.
        batchNormalizationLayer
        % apply rectilinear unit activation function that sets all negative
        % values to zero
        reluLayer

        % apply max pooling using a pooling size of (2x2), and using a 
        % stride of 2
        maxPooling2dLayer(2,'Stride',2)

        % create a second convolution layer, it has 16 convolutional
        % filters, each filter has a height and width of 3 and the input is
        % zero padded.
        convolution2dLayer(3,16,'Padding','same')
        batchNormalizationLayer
        reluLayer

        % apply max pooling using a pooling size of (2x2), and using a 
        % stride of 
        maxPooling2dLayer(2,'Stride',2)
        % create a third convolution layer, it has 32 convolutional
        % filters, each filter has a height and width of 3 and the input is
        % zero padded.
        convolution2dLayer(3,32,'Padding','same')
        batchNormalizationLayer
        reluLayer

        % create the ouput layer
        % the number of neurons in the output layer is equal to the number
        % of image labels
        fullyConnectedLayer(noof_labels)
        % use a softmax layer to convert the outputs to a set of 
        % probalities where each output represents the probability that the
        % image is a corresponding label.
        softmaxLayer
        % add a classification layer to make each output mutually
        % exclusive, in other words there's only a single correct label for 
        % each image
        classificationLayer];
    %END OF layers


    % specify CNN training options
    options = trainingOptions('sgdm', ...
                              'InitialLearnRate',0.01, ...
                              'MaxEpochs',500); 
    
    % sleep for a second to display the GUI
    pause(1);
    % start training the CNN
    % imds_train is imageDatastore that holds all training images and labels
    % layers is the architecture of the CNN
    % options contains the training parameters
    net = trainNetwork(imds_train,layers,options);
end