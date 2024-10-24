% Plot the “contrast response function” for the neuron
figure;
plot(contNeuron, respNeuron, '-o', 'LineWidth', 3, 'MarkerSize', 4, 'MarkerFaceColor','b');
xlabel('Contrast (%)', 'FontSize', 12);
ylabel('Response (spikes/s)', 'FontSize', 12);
title('Contrast Response Function for a Neuron', 'FontSize', 14);
grid on;

% Customize the axes and limits 
set(gca, 'FontSize', 12);
set(gca, 'XTick', 0:10:100); % Adjust x-axis ticks
set(gca, 'YTick', 0:10:60);  % Adjust y-axis ticks
xlim([0 100]);               % Set x-axis limits
ylim([0 60]);                % Set y-axis limits



% Create a table to use with fitlm
T = table(contNeuron', respNeuron', 'VariableNames', {'Contrast', 'Response'});

% Fit a quadratic polynomial regression model
mdl = fitlm(T, 'Response ~ Contrast + Contrast^2');

% Display model summary to check p-values and other statistics
disp(mdl);

% Display R^2 and adjusted R^2
disp(['R-squared: ', num2str(mdl.Rsquared.Ordinary)]);
disp(['Adjusted R-squared: ', num2str(mdl.Rsquared.Adjusted)]);

% Plot the fitted curve
figure;
plot(contNeuron, respNeuron, 'o'); % Original data
hold on;
plot(mdl); % Plot the fitted model
xlabel('Contrast (%)');
ylabel('Response (spikes/s)');
title('Polynomial Regression of Neuron Response');
grid on;

% Extract R-squared from the model
R_squared = mdl.Rsquared.Ordinary;  % Use the Rsquared field from the model

% Add the R^2 value as text to the graph
text(50, 35, ['R^2 = ', num2str(R_squared, 3)], 'FontSize', 12, 'Color', 'black', 'FontWeight', 'bold');

% Extract the coefficients from the fitted model
coeffs = mdl.Coefficients.Estimate;  % [Intercept, Contrast, Contrast^2]
c = coeffs(1);  % Intercept
b = coeffs(2);  % Coefficient for Contrast
a = coeffs(3);  % Coefficient for Contrast^2

% Create a range of contrast values for smooth plotting of the quadratic trendline
x_fit = linspace(min(contNeuron), max(contNeuron), 100);  % 100 points between min and max contrast
y_fit = a*x_fit.^2 + b*x_fit + c;  % Calculate the quadratic function for these values



% Display the quadratic equation on the graph
equation_text = sprintf('y = %.4fx^2 + %.4fx + %.4f', a, b, c);  % Create equation string
text(50, 40, equation_text, 'FontSize', 12, 'Color', 'black', 'FontWeight', 'bold');  % Display the equation




