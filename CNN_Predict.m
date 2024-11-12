function Prediction = CNN_Predict(net,ref_path,char_img)
% this GUI shows prediction for the character drawn by the user 

    S.net = net;
    S.ref = ref_path;
    % open a window(figure) for the GUI
    S.fh = figure('units','pixels',...
                'position',[500 300 600 400],...
                'menubar','none',...
                'name','Character Recognition Using CNN',...
                'numbertitle','off',...
                'resize','off',...
                'Color',[0.8588 0.9412 0.8275]);
        
    % create an axes to hold the images
    S.ax = axes('units','pix',...
               'position',[100 250 200 90]);
    % pass the drawing to the CNN and get a prediction
    [Prediction,~] = classify(net, char_img);
    
    % retreive the appropriate reference image for prediction
    full_ref_path = fullfile(ref_path,char(Prediction));
    ref_imd = imageDatastore(full_ref_path);
            
    % display user input image
    subplot(1,2,1);
    imshow(char_img);
    title('YOUR CHARACTER','FontSize',15);

    % display prediction image
    subplot(1,2,2);
    imshow(ref_imd.Files{1});
    title('CNN PREDICTION','FontSize',15);
end
