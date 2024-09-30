function [bag, mdl] = trainSimpleTextClassifier(data)
% TRAINSIMPLETEXTCLASSIFIER function takes data input which is in table
% format and has columns Name, Ingredients and Category. It retruns the
% bag-of-words model and the simple text classifier model by using the input
% data for training.
%
% Copyright 2024 The MathWorks, Inc.

requiredColumns = {'Name', 'Ingredients', 'Category'};

% Check if all required columns are present
if ~all(ismember(requiredColumns, data.Properties.VariableNames))
    error("Input data needs to be a table with required columns Name, Ingredients and Category");
end


% Check if the column type is 'string'
if ~isequal(class(data.Ingredients), 'string')
    error('The Ingredients column should be of type string.');
end

if ~isequal(class(data.Category), 'string') && ~isequal(class(data.Category), 'categorical')
    error('The Category column should be of type string.');
end

textData = data.Ingredients;
labels = data.Category;
documents = preprocessText(textData);
bag = bagOfWords(documents);
bag = removeInfrequentWords(bag,2);
[bag,idx] = removeEmptyDocuments(bag);
labels(idx) = [];
xtrain = bag.Counts;
mdl = fitcecoc(xtrain,labels,'Learners','linear');

end