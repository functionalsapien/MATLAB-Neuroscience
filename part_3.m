% Extract contrast and response data
contrast = contHuman;
response = respHuman;

% Calculate unique contrasts, trial counts, and performance (percent correct)
[uniqueContrasts, ~, idx] = unique(contrast);
performanceSummary = accumarray(idx, response, [], @mean) * 100;

% Ensure uniqueContrasts and performanceSummary are column vectors
uniqueContrasts = uniqueContrasts(:);  % Convert to column vector
performanceSummary = performanceSummary(:);  % Convert to column vector

% Define the sigmoid function model (logistic function)
sigmoidModel = fittype('100/(1 + exp(-a*(x-b)))', 'independent', 'x', 'coefficients', {'a', 'b'});

% Fit the data to the sigmoid function
[fitResult, gof] = fit(uniqueContrasts, performanceSummary, sigmoidModel);

% Display the fitted curve formula
disp('Fitted sigmoid function:');
disp(fitResult);

% Plot the data and the fitted curve
figure;
plot(fitResult, uniqueContrasts, performanceSummary, 'o');
title('Sigmoid Fit of Participant Performance');
xlabel('Contrast (%)');
ylabel('Percent Correct (%)');
grid on;

% Extract the coefficients (a and b) from the fitted model
a = fitResult.a;
b = fitResult.b;

% Generate the curve equation as a string for the plot
curveEquation = sprintf('y = 100 / (1 + exp(-%.2f(x - %.2f)))', a, b);
rSquared = gof.rsquare;  % R-squared value

% Plot the data and the fitted curve
figure;
plot(fitResult, uniqueContrasts, performanceSummary, 'o');  
hold on;

% Annotate graph with the equation and R-squared value
annotationText = sprintf('%s\nR^2 = %.3f', curveEquation, rSquared);
text(60, 20, annotationText, 'FontSize', 10, 'BackgroundColor', 'w');  

% title and labels
title('Sigmoid Fit of Participant Performance');
xlabel('Contrast (%)');
ylabel('Percent Correct (%)');
grid on;