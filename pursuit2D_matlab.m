%% Extract Stimulus and Eye Data for Trial 2
trial_idx = 3; % MATLAB indexing starts at 1

% Stimulus Data
time_stim = stim.tTraj;  % Time points for stimulus positions

% Ensure trial index is within bounds
if trial_idx > size(stim.posTraj,1)
    disp(['Skipping trial ', num2str(trial_idx), ' as it exceeds available trials']);
else
    xStim = squeeze(stim.posTraj(trial_idx,1,:)); % X stimulus positions
    yStim = squeeze(stim.posTraj(trial_idx,2,:)); % Y stimulus positions
end

% Eye Data
time_eye = eyeData.t;
xEye = squeeze(eyeData.x2(trial_idx, :));
yEye = squeeze(eyeData.y2(trial_idx, :));

% Align Eye Data Time Range
time_eye = time_eye - min(time_eye); % Normalize time to start at 0
valid_indices = time_eye <= max(time_stim);
time_eye = time_eye(valid_indices);
xEye = xEye(valid_indices);
yEye = yEye(valid_indices);

disp(['New Eye Data Time Range: ', num2str(min(time_eye)), ' to ', num2str(max(time_eye)), ' ms']);

%% PLOT: Stimulus and Eye Position for Trial 2 Using Subplots
figure;
sgtitle('Visualization of Trial 2');

% X-Position vs. Time
subplot(3,1,1);
plot(time_stim, xStim, 'b', 'LineWidth', 2); hold on;
plot(time_eye, xEye, 'r', 'LineWidth', 1.5);
xlabel('Time (ms)'); ylabel('X Position');
title('X-Position vs. Time (Trial 2)');
legend('Stimulus', 'Eye Position');
grid on;

% Y-Position vs. Time
subplot(3,1,2);
plot(time_stim, yStim, 'b', 'LineWidth', 2); hold on;
plot(time_eye, yEye, 'r', 'LineWidth', 1.5);
xlabel('Time (ms)'); ylabel('Y Position');
title('Y-Position vs. Time (Trial 2)');
legend('Stimulus', 'Eye Position');
grid on;

% X vs. Y Trajectory
subplot(3,1,3);
plot(xStim, yStim, 'b', 'LineWidth', 2); hold on;
plot(xEye, yEye, 'r', 'LineWidth', 1.5);
xlabel('X Position'); ylabel('Y Position');
title('Stimulus vs. Eye Trajectory (Trial 2)');
legend('Stimulus', 'Eye Position');
grid on;

%% LOOP: Plot for All Trials with Same condId as Trial 2
matching_trials = find(stim.condIds == stim.condIds(trial_idx)); % Find all trials with same condition ID

figure;
sgtitle('Visualization of All Matching Trials');

for i = 1:length(matching_trials)
    trial = matching_trials(i);
    
    % Extract stimulus positions
    xStim = squeeze(stim.posTraj(trial,1,:));
    yStim = squeeze(stim.posTraj(trial,2,:));

    % Extract eye positions
    xEye = squeeze(eyeData.x2(trial, :));
    yEye = squeeze(eyeData.y2(trial, :));

    % Align eye data time range
    time_eye = eyeData.t;
    time_eye = time_eye - min(time_eye);
    valid_indices = time_eye <= max(time_stim);
    time_eye = time_eye(valid_indices);
    xEye = xEye(valid_indices);
    yEye = yEye(valid_indices);

    % Plot all trials in the same figure with subplots
    subplot(3,1,1);
    plot(time_stim, xStim, 'b', 'LineWidth', 1); hold on;
    plot(time_eye, xEye, 'r', 'LineWidth', 0.5);
    xlabel('Time (ms)'); ylabel('X Position');
    title('X-Position vs. Time');
    legend('Stimulus', 'Eye Position');
    grid on;

    subplot(3,1,2);
    plot(time_stim, yStim, 'b', 'LineWidth', 1); hold on;
    plot(time_eye, yEye, 'r', 'LineWidth', 0.5);
    xlabel('Time (ms)'); ylabel('Y Position');
    title('Y-Position vs. Time');
    legend('Stimulus', 'Eye Position');
    grid on;

    subplot(3,1,3);
    plot(xStim, yStim, 'b', 'LineWidth', 1); hold on;
    plot(xEye, yEye, 'r', 'LineWidth', 0.5);
    xlabel('X Position'); ylabel('Y Position');
    title('Stimulus vs. Eye Trajectory');
    legend('Stimulus', 'Eye Position');
    grid on;
end

%% Comparison of X Eye position processing
trial_idx = 2; % Select Trial 2

% Extract different versions of X eye position
xRaw = eyeData.xRaw(trial_idx, :);
x = eyeData.x(trial_idx, :);
x2 = eyeData.x2(trial_idx, :);
time_eye = eyeData.t; % Time axis

% Align Eye Data Time Range (Trim to 4500 ms)
valid_indices = time_eye <= 4500; % Keep only up to 4500 ms
time_eye = time_eye(valid_indices);
xRaw = xRaw(valid_indices);
x = x(valid_indices);
x2 = x2(valid_indices);

disp(['New Eye Data Time Range: ', num2str(min(time_eye)), ' to ', num2str(max(time_eye)), ' ms']);

% Plot comparison
figure;
plot(time_eye, xRaw, 'k', 'LineWidth', 0.5); hold on; % Raw in black
plot(time_eye, x, 'b', 'LineWidth', 0.5); % Partially processed in blue
plot(time_eye, x2, 'r', 'LineWidth', 0.5); % Most processed in red

xlabel('Time (ms)');
ylabel('X Position');
title('Comparison of X Eye Position Processing (Trial 2)');
legend('Raw (xRaw)', 'Processed (x)', 'Fully Processed (x2)');
grid on;
