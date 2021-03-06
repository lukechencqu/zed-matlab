clc;
disp('=========SL_ZED_WITH_MATLAB -- SVO Recording=========');
close all;
clear mex; clear functions; clear all;

mexZED('create');

% parameter struct, the same as sl::InitParameters
% values as enum number, defines in : sl/defines.hpp 
% or from https://www.stereolabs.com/developers/documentation/API/
% 1: true, 0: false for boolean

InitParameters.camera_resolution = 2; %HD720
InitParameters.camera_fps = 60;
InitParameters.system_units = 2; %METER
InitParameters.depth_mode = 0; %DEPTH_MODE_NONE
result = mexZED('open', InitParameters);

nb_frame_to_save = 1000;
if(strcmp(result,'SUCCESS'))
    svo_output_filename = 'MySVO.svo';
    result =   mexZED('enableRecording', svo_output_filename);
    if(strcmp(result,'SUCCESS'))
        disp('Start Recording');
        f = 0;
        while f < nb_frame_to_save
            % grab the current image
            result = mexZED('grab');
            if(strcmp(result,'SUCCESS'))
                % record the current image
                mexZED('record');
                f = f+1;
            end
        end
        disp('End of Recording');
    end
    mexZED('disableRecording');
end
mexZED('close')
clear mex;