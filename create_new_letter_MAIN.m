clc;
clear;

if exist('create_character_data_GUI','dir') == 7
    % get access to all files in the 'create_character_data_GUI' directory
    addpath('create_character_data_GUI');
else
    error("Error: Unable to locate 'create_character_data_GUI' directory")
end

if exist('functions','dir') == 7
    % get access to all files in the 'functions' directory
    addpath('functions');
else
    error("Error: Unable to locate 'functions' directory")
end

% open the welcome GUI
GUI_1_WELCOME()
