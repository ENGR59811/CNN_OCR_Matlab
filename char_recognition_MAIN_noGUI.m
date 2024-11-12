% The City College of New York, City University of New York 
% Written by Ricardo Valdez
% August, 2020
% Optical character recognition using CNNs
clc;
clear;
% select training directory
train_dir = 'TrainingSet'; 
% select reference directory
ref_dir = 'ReferenceSet';
%output directory
saved_cnns = 'Saved_CNNs';
if exist('functions','dir') == 7
    % get access to all files in the 'functions' directory
    addpath('functions');
else
    error("Error: Unable to locate 'functions' directory")
end
message = sprintf('WELCOME TO USING CNN. MAKE YOUR SELECTION:');
disp(message);
disp('Enter 1 to train a new CNN 2 to load an existing CNN');
user_entry = input('Enter your choice: ');
if (user_entry == 1)
    % train a new CNN:
    disp('Be patient until statistics are displayed...');
    cnn_trained = CNN_Train(train_dir);
    input('CNN training is complete. Press enter to start using CNN.\n');
elseif (user_entry == 2)
    % use an existing CNN:
    cnn_file = input('Enter CNN name (dont forget .mat extension): ', 's');
    cnn_path = pwd;
    disp(cnn_file);
    try
        % load the CNN and assign it to cnn_trained
        load_data = load(fullfile(cnn_path, saved_cnns, cnn_file));
        cnn_trained = load_data.cnn_trained;
    catch
        disp('Enter a valid file name next time... Leaving... Bye');
        return;
    end
else
    disp('Enter a valid choice next time... Leaving... Bye');
    return;
end

% Use trained CNN to make predictions:
% start drawing a character
image = draw_tool();

% CNN predicts the character
cnn_prediction = CNN_Predict(cnn_trained, ref_dir, image);

user_entry = input('Do you want to save CNN? (y/n) ','s');
if(user_entry == 'y')
    file_name = input('Enter file name (do not forget .mat extension): ',...
        's');
    save(fullfile(saved_cnns,file_name), 'cnn_trained');
else   
end
disp('Have a predictably nice day!');
    