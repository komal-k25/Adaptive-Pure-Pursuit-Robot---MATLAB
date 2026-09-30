clc;
clear;
close all;

%% PATH SELECTION
pathType = "s-shaped";
[x_track, y_track] = generatePath(pathType);

%% CONTROLLER SETTINGS
lookAhead = 20;
Kp = 0.08;

minSpeed = 0.8;
maxSpeed = 3;

dt = 0.1;
numSteps = 600;

%% CLOSED PATH CHECK
isClosed = strcmpi(pathType, "circle");

%% INITIAL ROBOT POSITION

if pathType == "circle"
    x = 400;
    y = 200;
    theta = pi/2;
else
    x = 0;
    y = 200;
    theta = 0;
end

%% DATA STORAGE

timeData = zeros(1,numSteps);
speedData = zeros(1,numSteps);

robotX = zeros(1,numSteps);
robotY = zeros(1,numSteps);

%% CREATE FIGURE

figure;

plot(x_track, y_track, 'b', 'LineWidth', 2);
hold on;

robotPlot = plot(x, y, 'ro', ...
    'MarkerSize', 8, ...
    'MarkerFaceColor', 'r');

targetPlot = plot(x, y, 'gx', ...
    'MarkerSize', 10, ...
    'LineWidth', 2);

trajectoryPlot = plot(x, y, 'r--');

grid on;
axis equal;

xlabel('X');
ylabel('Y');

title(['Adaptive Pure Pursuit - ' char(pathType)]);

legend('Reference Path', ...
       'Robot', ...
       'Target', ...
       'Robot Trajectory');

%% SIMULATION

for step = 1:numSteps

    % Pure Pursuit
    [theta, headingError, targetX, targetY, nearestIdx] = ...
        purePursuit(x, y, theta, ...
        x_track, y_track, ...
        lookAhead, Kp, isClosed);

    % Adaptive speed
    speed = adaptiveSpeed( ...
        x_track, y_track, ...
        nearestIdx, ...
        minSpeed, maxSpeed);

    % Move robot
    [x, y] = robotModel( ...
        x, y, theta, speed, dt);

    % Store data
    timeData(step) = step * dt;
    speedData(step) = speed;

    robotX(step) = x;
    robotY(step) = y;

    % Update robot
    set(robotPlot, ...
        'XData', x, ...
        'YData', y);

    % Update target
    set(targetPlot, ...
        'XData', targetX, ...
        'YData', targetY);

    % Update trajectory
    set(trajectoryPlot, ...
        'XData', robotX(1:step), ...
        'YData', robotY(1:step));

    drawnow;

    pause(0.005);

end

%% SPEED VS TIME

figure;

plot(timeData, speedData, 'LineWidth', 2);

grid on;

xlabel('Time (seconds)');
ylabel('Speed');

title('Robot Speed vs Time');