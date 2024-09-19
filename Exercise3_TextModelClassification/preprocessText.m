function documents = preprocessText(textData)
% PREPROCESSTEXT function takes text data as input and does the following
% processing
% 1. Tokenize the text using tokenizedDocument.
% 2. Remove a list of stop words (such as "and", "of", and "the") using removeStopWords.
% 3. Lemmatize the words using normalizeWords.
% 4. Erase punctuation using erasePunctuation.
% 5. Remove words with 2 or fewer characters using removeShortWords.
% 6. Remove words with 50 or more characters using removeLongWords.
%
% Copyright 2024 The MathWorks, Inc.

% Tokenize the text.
documents = tokenizedDocument(textData);

% Remove a list of stop words then lemmatize the words. To improve
% lemmatization, first use addPartOfSpeechDetails.
documents = addPartOfSpeechDetails(documents);
documents = removeStopWords(documents);
documents = normalizeWords(documents,'Style','lemma');

% Erase punctuation.
documents = erasePunctuation(documents);

% Remove words with 2 or fewer characters, and words with 15 or more
% characters.
documents = removeShortWords(documents,2);
documents = removeLongWords(documents,50);

end