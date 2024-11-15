function image = draw_tool()
% draw_tool() displays a GUI that allows the user to draw a character.

    % open a window(figure) for the draw tool
    S.fh = figure('units','pixels', 'position',[500 300 600 400],...
           'menubar','none', 'name','Character Recognition Using CNN',...
           'numbertitle','off', 'resize','off','Color',[0.8588 0.9412 0.8275]);
    % create a textbox
    S.tb = uicontrol('style','text',...
                'unit','pix', 'position',[15 360 570 30],...
                'min',0,'max',2, 'fontsize',18,...
                'string','DRAW A CHARACTER BELOW USING A MOUSE',...
                'BackgroundColor',[1.0000 0.9490 0.7412],...
                'fontweight', 'bold');
    % create a blank axes
    % this is where the user draw their character
    S.ax = axes('units','pix',...
               'position',[50 60 500 290],...
               'XColor','none',...
               'YColor','none');
    % create a button to stop drawing
    S.pb = uicontrol('style','push',...
                'units','pix',...
                'position',[100 10 400 40],...
                'fontsize',14,...
                'string','Click here when finished',...
                'backgroundColor',[0.3020 0.4471 0.7412],...
                'foregroundcolor','w',...
                'callback',{@pb_call,S});
    % set color for the drawing to blue
    draw_color = [0 0.447 0.741];
    colororder(draw_color);
    
    % done is a boolean that indicates whether or not
    % the user is done drawing their character
    done = false;
    first = true;
    % draw a character
    while(~done)
        % check if the GUI window is still open
        if ishandle(S.fh)
            % convert the drawing into a 28x28 image
            if first == false
                image = process_image(S.ax);
            end
            % draw a curve
            get_curve(S.fh);
            first = false;
        else
            done = true;
        end
    end
end

function [] = pb_call(varargin)
% button callback function
    S = varargin{3};
    % close the draw tool GUI
    close(S.fh);
end
