% Plot “contrast response function” for the neuron
figure;
plot(contNeuron, respNeuron, '-o', 'LineWidth', 3, 'MarkerSize', 4, 'MarkerFaceColor','b');
xlabel('Contrast (%)', 'FontSize', 12);
ylabel('Response (spikes/s)', 'FontSize', 12);
title('Contrast Response Function for a Neuron', 'FontSize', 14);
grid on;

% Axes and limits 
set(gca, 'FontSize', 12);
set(gca, 'XTick', 0:10:100); % Adjust x-axis ticks
set(gca, 'YTick', 0:10:60);  % Adjust y-axis ticks
xlim([0 100]);               % Set x-axis limits
ylim([0 60]);                % Set y-axis limits


% Create a table to use with fitlm
T = table(contNeuron', respNeuron', 'VariableNames', {'Contrast', 'Response'});


% Define the sigmoid function
sigmoid = @(p, x) p(1) ./ (1 + exp(-p(2) * (x - p(3))));  % p(1)=a, p(2)=b, p(3)=c

% Initial guesses for the parameters [a, b, c]
p0 = [max(respNeuron), 1, mean(contNeuron)];  % Initial guess for max response, slope, and midpoint

% Fit the sigmoid function to the data using nlinfit
[p_fit, R, J, covb] = nlinfit(contNeuron, respNeuron, sigmoid, p0);  % Get covariance matrix (covb)

% Generate a smooth set of x values for plotting the fitted sigmoid curve
x_fit = linspace(min(contNeuron), max(contNeuron), 100);
y_fit = sigmoid(p_fit, x_fit);  % Sigmoid trendline values

% Plot the original data points
figure;
plot(contNeuron, respNeuron, 'o');  % Plot original data points
hold on;

% Plot the fitted sigmoid curve
plot(x_fit, y_fit, '-r', 'LineWidth', 2);  % Sigmoid curve as red line

% Label the graph
xlabel('Contrast (%)');
ylabel('Response (spikes/s)');
title('Neuron Response with Sigmoid Trendline');
grid on;

% Manually calculate R-squared
y_pred = sigmoid(p_fit, contNeuron);  % Predicted response values
SS_res = sum((respNeuron - y_pred).^2);  % Residual sum of squares
SS_tot = sum((respNeuron - mean(respNeuron)).^2);  % Total sum of squares
R_squared = 1 - (SS_res / SS_tot);  % Calculate R-squared

% Display the R-squared value on the graph
text(50, 30, ['R^2 = ', num2str(R_squared, 3)], 'FontSize', 12, 'Color', 'black', 'FontWeight', 'bold');

% Display the sigmoid equation on the graph
equation_text = sprintf('y = %.4f / (1 + e^{%.4f(x - %.4f)})', p_fit(1), -p_fit(2), p_fit(3));
text(50, 35, equation_text, 'FontSize', 12, 'Color', 'black', 'FontWeight', 'bold');

% Display the standard errors from the covariance matrix (covb)
standard_errors = sqrt(diag(covb));
disp('Standard errors of the parameters:');
disp(standard_errors);

% Calculate p-values for the parameters
t_stats = p_fit ./ standard_errors;  % Calculate t-statistics
df = length(respNeuron) - length(p_fit);  % Degrees of freedom: n - k
p_values = 2 * (1 - tcdf(abs(t_stats), df));  % Two-tailed p-value from the t-distribution

% Display the p-values for each parameter (properly formatted)
disp('P-values of the parameters:');
fprintf('P-value for a (amplitude): %.4f\n', p_values(1));
fprintf('P-value for b (slope): %.4f\n', p_values(2));
fprintf('P-value for c (midpoint): %.4f\n', p_values(3));


hold off;

