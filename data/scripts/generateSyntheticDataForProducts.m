function generateSyntheticDataForProducts

load('raw_ingredients.mat', 'raw_ingredients');
% List of endocrine disruptors
listOFEndocrineDisruptors = {'phthalate', 'paraben', 'phthalate esters', ...
    'esters of phthalic acid', 'Butylated hydroxytoluene', ...
    'dibutylhydroxytoluene', 'octamethylcyclotetrasiloxane', ...
    'decamethylcyclopentasiloxane', 'dodecamethylcyclohexasiloxane',...
    'Per- and polyfluoroalkyl', 'pfa', 'Resorcinol', 'benzophenone',...
    'Oxybenzone', 'benzophenone-3', 'benzophenone-2', 'Homosalate',...
    'Octocrylene', 'BPA', 'Bisphenol A', 'Propylparaben', 'Formaldehyde',...
    'Paraformaldehyde','Methylene glycol', 'Quaternium 15',...
    'Polychlorinated biphenyls','sodium laureth sulfate','PEG',...
    'Dibutyl pthalate', 'diethylhexyl phthalate',...
    'methylparaben', 'propylparaben', 'butylparaben', 'ethylparaben'};

% Initialize arrays to store the table data
productNames = cell(500, 1);
ingredientsList = cell(500, 1);
categories = cell(500, 1);

% Random seed for reproducibility (optional)
rng(0);

% Generate 500 combinations
for i = 1:500
    % Randomly select the number of ingredients (between 10 and 20)
    numIngredients = randi([10, 20]);
    
    % Randomly select ingredients from the array
    selectedIngredients = raw_ingredients(randperm(length(raw_ingredients), numIngredients));
    
    % Create a product name
    productNames{i} = sprintf('Product %d', i);
    
    % Create a string of ingredients separated by commas
    ingredientsList{i} = strjoin(selectedIngredients, ', ');
    
    % Determine if the product is 'toxic' or 'clean'
    if any(contains(selectedIngredients, listOFEndocrineDisruptors, 'IgnoreCase', true))
        categories{i} = 'toxic';
    else
        categories{i} = 'clean';
    end
end

% Create a table
product_data = table(productNames, ingredientsList, categories, ...
    'VariableNames', {'Name', 'Ingredients', 'Category'});

% Convert 'Name' column
product_data.Name = string(product_data.Name);

% Convert 'Ingredients' column
product_data.Ingredients = string(product_data.Ingredients);

% Convert 'Category' column
product_data.Category = string(product_data.Category);
writetable(product_data, 'products_data.csv');