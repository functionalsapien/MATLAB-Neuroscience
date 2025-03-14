cd '~/Desktop/Project data'
load('NP.pursuit2D.stimType3.Session1.mat');  
% Extract time points and stimulus position for Trial 2
trial_idx = 2; % Trial 2 (MATLAB indexing starts at 1)
time_stim = stim.tTraj; % Time points for stimulus positions
x_stim = squeeze(stim.posTraj(trial_idx,1,:)); % X-positions for Trial 2
y_stim = squeeze(stim.posTraj(trial_idx,2,:)); % Y-positions for Trial 2

% Stimulus position trajectory in three different ways (trial 2)

%% X vs time (s)
figure;
plot(time_stim, x_stim, 'b', 'LineWidth', 2);
xlabel('Time (ms)');
ylabel('X Position');
title('X-Position vs. Time (Trial 2)');
grid on;

%% Y vs time (s)
figure;
plot(time_stim, y_stim, 'r', 'LineWidth', 2);
xlabel('Time (ms)');
ylabel('Y Position');
title('Y-Position vs. Time (Trial 2)');
grid on;

%% Y position vs X position
figure;
plot(x_stim, y_stim, 'k', 'LineWidth', 2);
xlabel('X Position');
ylabel('Y Position');
title('Y-position versus X-position (Trial 2)');
grid on;
axis equal; 

%%

% Extract time points and eye position for Trial 2
trial_idx = 2; % MATLAB indexing starts at 1

time_eye = eyeData.t; % Time points for eye positions
x_eye = squeeze(eyeData.x2(trial_idx, :)); % X-eye position for Trial 2
y_eye = squeeze(eyeData.y2(trial_idx, :)); % Y-eye position for Trial 2

% Eye position in three different ways (trial 2)

%% X-Eye Position vs. Time (s)
figure;
plot(time_eye, x_eye, 'b', 'LineWidth', 2);
xlabel('Time (ms)');
ylabel('X-Eye Position');
title('X-Eye Position vs. Time (Trial 2)');
grid on;

%% Y-Eye Position vs. Time (s)
figure;
plot(time_eye, y_eye, 'r', 'LineWidth', 2);
xlabel('Time (ms)');
ylabel('Y-Eye Position');
title('Y-Eye Position vs. Time (Trial 2)');
grid on;

%% Y-Eye Position vs. X-Eye Position (Eye Trajectory)
figure;
plot(x_eye, y_eye, 'k', 'LineWidth', 2);
xlabel('X-Eye Position');
ylabel('Y-Eye Position');
title('Eye Trajectory (Trial 2)');
grid on;
axis equal; % Keep the aspect ratio equal

%% Overlay Plots

%X-Position vs. Time (Stimulus & Eye Movement)
figure;
plot(time_stim, x_stim, 'b', 'LineWidth', 2); hold on; % Stimulus
plot(time_eye, x_eye, 'r', 'LineWidth', 1.5); % Eye movement
xlabel('Time (ms)');
ylabel('X Position');
title('X-Position vs. Time (Trial 2)');
legend('Stimulus', 'Eye Position');
grid on;
hold off;


%% Y-Position vs. Time (Stimulus & Eye Movement)
figure;
plot(time_stim, y_stim, 'b', 'LineWidth', 2); hold on; % Stimulus
plot(time_eye, y_eye, 'r', 'LineWidth', 1.5); % Eye movement
xlabel('Time (ms)');
ylabel('Y Position');
title('Y-Position vs. Time (Trial 2)');
legend('Stimulus', 'Eye Position');
grid on;
hold off;

%% Y-Position vs. X-Position (Trajectory)
figure;
plot(x_stim, y_stim, 'b', 'LineWidth', 2); hold on; % Stimulus trajectory
plot(x_eye, y_eye, 'r', 'LineWidth', 1.5); % Eye movement trajectory
xlabel('X Position');
ylabel('Y Position');
title('Stimulus vs. Eye Trajectory (Trial 2)');
legend('Stimulus', 'Eye Position');
grid on;
axis equal; % Keep the aspect ratio equal
hold off;
%%
