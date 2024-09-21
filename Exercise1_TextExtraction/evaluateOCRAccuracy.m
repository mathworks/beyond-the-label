function accuracy = evaluateOCRAccuracy(resultTxt, groundTruthTxt)
%EVALUATEOCRACCURACY takes in the resultTxt and groundTruthTxt and
%calculates percentage accuracy based on the Levenshtein distance.
%
% Copyright 2024 The MathWorks, Inc.

% Normalize texts (convert to lowercase and remove punctuation)
groundTruthText = lower(regexprep(groundTruthTxt, '[^\w\s]', ''));
extractedText = lower(regexprep(resultTxt, '[^\w\s]', ''));

% Calculate Levenshtein distance
levenshteinDist = editDistance(groundTruthText, extractedText);

% Calculate accuracy
maxLength = max(length(groundTruthText), length(extractedText));
accuracy = (1 - levenshteinDist / maxLength) * 100;