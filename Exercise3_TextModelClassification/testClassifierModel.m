function testClassifierModel()
% TESTCLASSIFIERMODEL partitions the data into training and validation. It uses
% the model created with the training data set to test the validation data
% set and displays the accuracy of classification.
%
% Copyright 2024 The MathWorks, Inc.

% Load the data
filename = 'products_data.csv';
data = readtable(filename,'TextType','string');

% Partition the data into a training partition and a held-out test set. 
% Specify the holdout percentage to be 10%.
cvp = cvpartition(data.Category,'Holdout',0.2);
dataTrain = data(training(cvp),:);
dataValidation = data(test(cvp),:);

% Create a simple text classifier model
[bagOfWords, simpleTextClassifierMdl] = trainSimpleTextClassifier(dataTrain);


% Extract the text data and labels for validation
textDataValidation = dataValidation.Ingredients;
YValidation = dataValidation.Category;
documentsValidation = preprocessText(textDataValidation);

% Test the classifier
XValidation = encode(bagOfWords,documentsValidation);
YPred = predict(simpleTextClassifierMdl,XValidation);

[c, order] = confusionmat(YValidation, YPred);
confusionchart(c, order);
% Calculate and print the accuracy of prediction
acc = sum(YPred == YValidation)/numel(YValidation);
disp(['Classification accuracy is: '  num2str(acc*100) '%'])