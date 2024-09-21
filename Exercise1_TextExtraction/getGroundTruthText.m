function groundTruthText = getGroundTruthText(imageFullPath)
% GETGROUNDTRUTHTEXT accepts a filename and returns the ground truth text
% for the input file image which contains text data.
%
% Copyright 2024 The MathWorks, Inc.

% Load the data

load("ground_truth_data.mat","groundTruthTextMap");
[~, label, ~] = fileparts(imageFullPath);
if ~any(ismember(groundTruthTextMap.keys, label))
    error(['There is no ground truth text for input :' label]);
end
groundTruthText = groundTruthTextMap(label);